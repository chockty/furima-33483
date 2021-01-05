class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false 
      t.text :info, null: false 
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :item_category_id ,null: false
      t.integer :item_sales_status_id, null: false
      t.integer :item_shipping_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :item_scheduled_delivery_id, null: false 
      t.timestamps
    end
  end
end
