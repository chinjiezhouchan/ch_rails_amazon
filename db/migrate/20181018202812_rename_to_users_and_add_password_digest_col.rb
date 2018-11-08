class RenameToUsersAndAddPasswordDigestCol < ActiveRecord::Migration[5.2]
  def change
    rename_table('user_infos', 'users')
  end
end
