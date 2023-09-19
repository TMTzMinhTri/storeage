class AddUsernameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, unique: true
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
