class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :judge_ok_or_not, only:[:index, :create]

  def index
    @purchase_shippingaddress = PurchaseShippingaddress.new
  end

  def create
    @purchase_shippingaddress = PurchaseShippingaddress.new(purchase_shippingaddress_params)
    if @purchase_shippingaddress.valid?
      pay_paid
      @purchase_shippingaddress.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private
  def purchase_shippingaddress_params
    params.require(:purchase_shippingaddress).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def judge_ok_or_not
    @item = Item.find(params[:item_id])
    if @item.user.id == current_user.id
      redirect_to root_path
    elsif @item.purchase
      redirect_to root_path
    end
  end

  def pay_paid
    item = Item.find(purchase_shippingaddress_params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create({
      amount: item.price,
      card: purchase_shippingaddress_params[:token],
      currency: "jpy"
    })
    end
end