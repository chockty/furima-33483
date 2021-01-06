class PurchaseShippingaddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token               | string     | null: false                    |
  
  with_options presence: true do
    validates :city, :addresses, :postal_code,
  end
  validates :postal_code, format:{with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"}
  validates :prefecture_id, numericality:{only_integer: true, other_than: 0, message: 'Select'}
  validates :phone_number, numericality:{with: /\A[0-9]+\z/, message: "Input only number"}
end