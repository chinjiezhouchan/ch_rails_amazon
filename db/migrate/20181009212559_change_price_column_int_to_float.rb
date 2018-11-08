class ChangePriceColumnIntToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :price, :float
    # When changing between different data types, e.g. price from string to integer, it could mess up. It will try to convert 
  end
end
