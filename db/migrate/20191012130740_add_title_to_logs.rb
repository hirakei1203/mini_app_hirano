class AddTitleToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :title, :string
  end
end
