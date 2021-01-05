class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  validates :name, :info, :image, :price, presence: true 
  validates :price, numericality: { with: /\A[0-9]+\z/, message: "Half-width number"}
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range" }
  with_options numericality: { only_integer: true, other_than: 0, message: "Select" } do
    validates :item_category_id, :item_sales_status_id, :item_shipping_id, :prefecture_id, :item_scheduled_delivery_id
  end

  has_one :purchase
  belongs_to :user
  belongs_to :item_category
  belongs_to :item_sales_status
  belongs_to :item_shipping
  belongs_to :prefecture
  belongs_to :item_scheduled_delivery
end
