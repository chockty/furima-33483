class PurchaseShippingaddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token
  
  with_options presence: true do
    validates :token, :postal_code, :city, :addresses, :phone_number, :user_id, :item_id
  end
  validates :postal_code, format:{with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"} 
  validates :prefecture_id, numericality:{only_integer: true, other_than: 0, message: 'Select'}
  validates :phone_number, format:{with: /\A[0-9]+\z/, message: "Input only number"}, length:{maximum: 11}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shippingaddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
