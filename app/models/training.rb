class Training < ApplicationRecord
  belongs_to :training_plan

  scope :for_user, ->(user) { where training_plan_id: user.training_plan_id }

  def completed_for?(user)
    CompletedTraining.find_by(user: user, training: self).present?
  end
end
