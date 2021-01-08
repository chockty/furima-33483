require 'rails_helper'

RSpec.describe PurchaseShippingaddress, type: :model do
  before do
    @purchase_shippingaddress = FactoryBot.build(:purchase_shippingaddress)
  end

  context '商品が購入できる場合' do
    it '必要項目が全て適切に入力されている場合、商品を購入することができる' do
      expect(@purchase_shippingaddress).to be_valid
    end
    it '建物名が空欄でも他の必要項目が全て適切に入力されている場合、商品を購入することができる' do
      @purchase_shippingaddress.building = ''
      expect(@purchase_shippingaddress).to be_valid
    end
  end

  context '商品が購入できない場合' do
    it 'tokenが空の場合、商品を購入することができない' do
      @purchase_shippingaddress.token = ''
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include("Token can't be blank")
    end
    it '郵便番号が空の場合、商品を購入することができない' do
      @purchase_shippingaddress.postal_code = ''
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include("Postal code can't be blank")
    end
    it '郵便番号が指定のフォーマット（000-0000という形式）以外の場合、商品を購入することができない' do
      @purchase_shippingaddress.postal_code = '00-000000'
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include('Postal code Input correctly')
    end
    it '郵便番号が文字の場合、商品を購入することができない' do
      @purchase_shippingaddress.postal_code = 'あいう-えおかき'
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include('Postal code Input correctly')
    end
    it '都道府県が選択されていない（＝「--」のまま）場合、商品を購入することができない' do
      @purchase_shippingaddress.prefecture_id = 0
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include('Prefecture Select')
    end
    it '市区町村が空の場合、商品を購入することができない' do
      @purchase_shippingaddress.city = ''
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include("City can't be blank")
    end
    it '番地が空の場合、商品を購入することができない' do
      @purchase_shippingaddress.addresses = ''
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include("Addresses can't be blank")
    end
    it '電話番号が空の場合、商品を購入することができない' do
      @purchase_shippingaddress.phone_number = ''
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号が数字以外の場合、商品を購入することができない' do
      @purchase_shippingaddress.phone_number = 'あいうえお'
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include('Phone number Input only number')
    end
    it '電話番号が12文字以上の場合、商品を購入することができない' do
      @purchase_shippingaddress.phone_number = '090123456789'
      @purchase_shippingaddress.valid?
      expect(@purchase_shippingaddress.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
    end
  end
end
