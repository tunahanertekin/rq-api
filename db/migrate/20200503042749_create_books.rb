class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title
      t.text :author
      t.text :publisher
      t.text :translator
      t.integer :edition
      t.text :language

      t.timestamps
    end
  end
end
