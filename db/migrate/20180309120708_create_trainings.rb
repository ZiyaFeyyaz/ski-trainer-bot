class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.datetime :start_time, null: false
      t.references :training_plan, foreign_key: true, null: false

      t.timestamps
    end
  end
end
