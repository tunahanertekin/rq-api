class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.text :email
      t.text :favouriteUsers
      t.text :favouriteBooks
      t.text :favouriteQuotes
      t.string :avatar
      t.text :pinned

      t.timestamps
    end
  end
end
