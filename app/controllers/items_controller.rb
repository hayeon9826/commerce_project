class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :toggle, :edit, :update, :destroy, :add]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
    #내가 판매하는 상품
    if params[:type] == "selling"
      redirect_to root_path, notice: "로그인을 해야합니다" unless current_user
      @items = current_user.items
    else
      @items = Item.all
      @items = @items.where(category_id: params[:category_id]) if params[:category_id].present?
      @items = @items.ransack(title_or_description_cont: params[:q]).result(distinct: true) if params[:q].present?
    end
    # @items = params[:order].present? ? @items.order(params[:order]) : @items.order(created_at: :desc)
    @items = params[:order].blank? ? @items.order(created_at: :desc) : @items.order(params[:order])
    @items = @items.page(params[:page]).per(8)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create!(object_params)
    redirect_to items_path(type: :selling), notice: "상품을 성공적으로 등록하였습니다."
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
  end


  def add
    #edit은 판매자 상품 편집 기능
    @order = get_cart
    line_item = @order.line_items.where(item: @item).first_or_create(price: @item.price)
    line_item.increment!(:amount)
    line_item.set_order_total
    redirect_to new_order_path, notice: "장바구니에 상품을 담았습니다"
  end

  def update
    @item.update(object_params)
    redirect_to item_path(@item), notice: "상품이 수정되었습니다."
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "상품이 삭제되었습니다"
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def object_params
    params.require(:item).permit(:title, :price, :description, :user_id, :image, :category_id)
  end

  def check_owner
    redirect_to root_path, notice: "권한이 없습니다" unless @item.user == current_user
  end

end
