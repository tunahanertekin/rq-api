class AddHashedPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hashedPassword, :text
  end
end
