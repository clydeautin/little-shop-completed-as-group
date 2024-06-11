class RenameDiscountsTableAndMerchantId < ActiveRecord::Migration[7.1]
  def change
    rename_table :Discounts, :discounts

    rename_column :discounts, :merchants_id, :merchant_id
  end
end
