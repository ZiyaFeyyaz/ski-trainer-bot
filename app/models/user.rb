class User < ApplicationRecord
  enum gender: { male: 'male', female: 'female' }

  belongs_to :training_plan, optional: true

  def trainings_inline_keyboard
    Training.for_user(self).map do |training|
      [{
        text: "#{training.name} | #{training.start_time.to_s(:long)}\n",
        callback_data: "show:#{training.id}"
      }]
    end
  end
end
