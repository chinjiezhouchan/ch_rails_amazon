class ChangeLastNameColumnToLastName < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_infos, :Last_name, :text
    add_column :user_infos, :last_name, :text
  end
end
