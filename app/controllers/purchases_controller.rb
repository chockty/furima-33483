class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create]

  def index
    judge_ok_or_not
    @purchase_shippingaddress = PurchaseShippingaddress.new
  end

  def create
    judge_ok_or_not
    @purchase_shippingaddress = PurchaseShippingaddress.new(purchase_shippingaddress_params)
    if @purchase_shippingaddress.valid?
      @purchase_shippingaddress.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private
  def purchase_shippingaddress_params
    params.require(:purchase_shippingaddress).permit(:hoge, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def judge_ok_or_not
    @item = Item.find(params[:item_id])
    if @item.user.id == current_user.id
      redirect_to root_path
    elsif @item.purchase
      redirect_to root_path
    end
  end
end