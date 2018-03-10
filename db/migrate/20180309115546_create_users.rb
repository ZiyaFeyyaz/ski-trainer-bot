class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false, default: ''
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.integer :age
      t.references :training_plan, foreign_key: true

      t.timestamps
    end
  end
end
