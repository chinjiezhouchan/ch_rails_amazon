class CreateUserInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infos do |t|
      t.text :first_name
      t.text :Last_name
      t.text :email

      t.timestamps
    end
  end
end
