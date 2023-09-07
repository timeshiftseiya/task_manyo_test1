class ChangeColumnNullTasks < ActiveRecord::Migration[6.0] # ここに適切なRailsのバージョンを指定
  def change
    change_column :tasks, :title, :string, null: false
  end
end




