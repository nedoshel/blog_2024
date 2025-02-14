class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
