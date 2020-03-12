class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      # t.string :image, null: false
      t.string :title
      t.text :text
      t.references :user, foreing_key: true
      t.timestamps
    end
  end
end
