class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.references :book, null: false, foreign_key: true
      t.text :title
      t.text :body
      t.text :owner
      t.integer :favnum
      t.integer :page

      t.timestamps
    end
  end
end
