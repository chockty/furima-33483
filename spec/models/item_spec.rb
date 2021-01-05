require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  context '商品の出品ができる場合' do
    it '必要情報が全て正確に入力されている場合、商品の出品ができる' do
      expect(@item).to be_valid
    end
  end

  context '商品の出品ができない場合' do
    it '商品画像が添付されていない場合、商品の出品ができない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it '商品名が空の場合、商品の出品ができない' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it '商品の説明が空の場合、商品の出品ができない' do
      @item.info = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Info can't be blank")
    end
    it 'カテゴリの情報が選択されていない（＝「--」のまま）場合、商品の出品ができない' do
      @item.item_category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Item category Select')
    end
    it '商品の状態についての情報が選択されていない（＝「--」のまま）場合、商品の出品ができない' do
      @item.item_sales_status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Item sales status Select')
    end
    it '配送料の負担についての情報が選択されていない（＝「--」のまま）場合、商品の出品ができない' do
      @item.item_shipping_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Item shipping Select')
    end
    it '発送元の地域についての情報が選択されていない（＝「--」のまま）場合、商品の出品ができない' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture Select')
    end
    it '発送までの日数についての情報が選択されていない（＝「--」のまま）場合、商品の出品ができない' do
      @item.item_scheduled_delivery_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Item scheduled delivery Select')
    end
    it '価格が空の場合、商品の出品ができない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'ユーザが紐づいていない場合、商品の出品ができない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
    it '価格の範囲が¥300~¥9,999,999の間ではない場合、商品の出品ができない（１）' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end
    it '価格の範囲が¥300~¥9,999,999の間ではない場合、商品の出品ができない（２）' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end
    it '価格が半角全角混同の場合、商品の出品ができない' do
      @item.price = '100あいう'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Half-width number')
    end
    it '価格が全角文字の場合、商品の出品ができない' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Half-width number')
    end
    it '価格が半角英数混合の場合、商品の出品ができない' do
      @item.price = 'abc1000'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Half-width number')
    end
    it '価格が半角英語の場合、商品の出品ができない' do
      @item.price = 'abcdef'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Half-width number')
    end
  end
end
