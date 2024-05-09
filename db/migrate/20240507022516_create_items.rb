class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :product_name, null: false
      t.text  :product_description, null: false
      t.integer :category_id, null: false
      t.integer :product_condition_id, null: false
      t.integer :shipping_fee_burden_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_day_id, null: false
      t.integer :selling_price, null: false
      t.timestamps
    end
  end
end
