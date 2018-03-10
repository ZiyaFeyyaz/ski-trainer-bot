class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!

  def start(value = nil, *)
    user = User.find_or_create_by uid: from['id']

    if user.gender.blank?
      if User.genders.values.include?(value)
        user.gender = value
        user.save!
      else
        respond_with :message, text: t('.gender_question'),
                     reply_markup: {
                       keyboard: [User.genders.values],
                       resize_keyboard: true,
                       one_time_keyboard: true,
                       selective: true
                     }
        save_context :start
        return
      end
    end

    if user.age.blank?
      age = value.to_i
      if age > 0
        user.age = age
        user.save!
      else
        respond_with :message, text: t('.age_question')
        save_context :start
        return
      end
    end

    if user.training_plan.blank?
      if TrainingPlan.names.values.include?(value)
        user.training_plan = TrainingPlan.find_by name: value
        user.save
      else
        respond_with :message, text: t('.training_plan_question'),
                     reply_markup: {
                       keyboard: [TrainingPlan.names.values],
                       resize_keyboard: true,
                       one_time_keyboard: true,
                       selective: true
                     }
        save_context :start
        return
      end
    end

    user.username = from[:username]
    user.first_name = from[:first_name]
    user.last_name = from[:last_name]
    user.save
    respond_with :message, text: t('.content')
  end

  def help(*)
    respond_with :message, text: t('.content'), parse_mode: 'Markdown'
  end

  def trainings(*)
    user = User.find_or_create_by uid: from['id']
    if user.training_plan.present?
      respond_with :message, text: t('.content'), parse_mode: 'Markdown',
                   reply_markup: { inline_keyboard: user.trainings_inline_keyboard }
    else
      respond_with :message, text: t('.warning')
    end
  end

  def callback_query(data)
    return if data.blank?

    answer_callback_query ''
    attributes = data.split ':'
    action = attributes[0]
    id = attributes[1]

    training = Training.find_by_id id
    user = User.find_by_uid from['id']
    return if training.blank? || user.blank?

    case action
      when 'show'
        show_training user, training
      when 'complete'
        complete_training user, training
      else
        answer_callback_query t('.action_not_supported')
    end
  end

  def message(message)
    respond_with :message, text: t('.content', text: message['text'])
  end

  private

  def show_training(user, training)
    completed = training.completed_for?(user)
    text = t(
      '.content',
      name: training.name,
      start_time: training.start_time.to_s(:long),
      description: training.description,
      completed: completed ? 'Yes' : 'No'
    )

    options = { text: text, parse_mode: 'Markdown' }
    unless completed
      options[:reply_markup] = {
        inline_keyboard: [[{ text: t('.complete'), callback_data: "complete:#{training.id}" }]]
      }
    end

    respond_with :message, options
  end

  def complete_training(user, training)
    CompletedTraining.create user: user, training: training
    respond_with :message, text: t('.completed', name: training.name), parse_mode: 'Markdown'
  end
end
