class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :toggle, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #내가 판매하는 상품
    if params[:type] == "selling"
      redirect_to root_path, notice: "로그인을 해야합니다" unless current_user
      @items = current_user.items
    else
      @items = Item.all
      @items = @items.where(category_id: params[:category_id]) if params[:category_id].present?
    end
    @items = @items.page(params[:page]).per(8)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create!(object_params)
  end

  def show
  end

  def toggle
    if user_item = current_user.user_items.where(item: @item).first
      user_item.destroy
      flash[:alert] = "찜을 제거하였습니다."
    else
      current_user.user_items.where(item: @item).create!
      flash[:notice] = "찜하였습니다."
    end
    redirect_back fallback_location: root_path
  end


  def edit
    @order = get_cart
    line_item = @order.line_items.where(item: @item).first_or_create(price: @item.price)
    line_item.increment!(:amount)
    line_item.set_order_total
    redirect_to new_order_path, notice: "장바구니에 상품을 담았습니다"
  end

  def update
  end

  def destroy
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def object_params
    params.require(:item).permit(:title, :price, :description, :user_id, :image, :category_id)
  end
end
