class AddHiddenToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :hidden, :boolean
  end
end
