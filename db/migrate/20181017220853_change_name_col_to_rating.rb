class ChangeNameColToRating < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :name, :text
    add_column :reviews, :rating, :integer
    
  end

end
