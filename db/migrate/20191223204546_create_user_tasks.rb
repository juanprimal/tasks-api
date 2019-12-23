class CreateUserTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tasks do |t|
      t.string :description
      t.boolean :state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
