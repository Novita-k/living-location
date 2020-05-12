class AddDateTimeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :date_time, :datetime
  end
end
