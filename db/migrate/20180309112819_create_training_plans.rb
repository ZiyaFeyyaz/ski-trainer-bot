class CreateTrainingPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :training_plans do |t|
      t.string :name

      t.timestamps
    end

    add_index :training_plans, :name, unique: true
  end
end
