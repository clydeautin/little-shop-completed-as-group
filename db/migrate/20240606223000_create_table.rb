class CreateTable < ActiveRecord::Migration[7.1]
  def change
    create_table :Discounts do |t|
      t.string :name
      t.integer :percentage
      t.integer :threshold
      t.references :merchants, null: false, foreign_key: true

      t.timestamps
    end
  end
end
