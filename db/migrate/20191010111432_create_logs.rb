class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.text :logs, null:false
      t.text :problem
      t.integer :user_id, null:false, foreign_key: true
      t.timestamps null: false
    end
  end
end
