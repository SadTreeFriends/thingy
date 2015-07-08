class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    # Enforce uniqueness at database level:
    # add index to email column of users table, enforcing uniqueness
    add_index :users, :email, unique: true
  end
end
