class AddUsernameUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
  end
end
