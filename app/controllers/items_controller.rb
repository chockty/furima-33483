class ItemsController < ApplicationController
  before_action :basic_auth, only: [:index]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_one_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to(root_path)
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if @item.user.id != current_user.id
  end

  def update
    if @item.user.id != current_user.id
      redirect_to root_path
    elsif @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    if @item.user.id != current_user.id
      redirect_to root_path
    else
      @item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :price, :image, :item_category_id, :item_sales_status_id, :item_shipping_id,
                                 :prefecture_id, :item_scheduled_delivery_id).merge(user_id: current_user.id)
  end

  def find_one_item
    @item = Item.find(params[:id])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

end
