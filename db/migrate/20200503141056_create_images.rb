class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image, null: false
      t.integer :post_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
