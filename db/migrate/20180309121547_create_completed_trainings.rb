class CreateCompletedTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :completed_trainings do |t|
      t.references :user, foreign_key: true, null: false
      t.references :training, foreign_key: true, null: false

      t.timestamps
    end

    add_index :completed_trainings, [:user_id, :training_id], unique: true
  end
end
