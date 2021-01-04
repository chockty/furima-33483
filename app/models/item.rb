class Item < ApplicationRecord
  has_one :purchase
  belongs_to :user
  belongs_to :item_category_id
  belongs_to :item_shipping_id
  belongs_to :prefecture_id
  belongs_to :item_scheduled_delivery_id
end
