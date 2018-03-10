class TrainingPlan < ApplicationRecord
  enum name: { beginner: 'beginner', middle: 'middle', advanced: 'advanced' }
end
