class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_object, only: [:show, :update]

  def new
    @order = get_cart
  end

  def item_delete
    @order = get_cart
    @line_item = @order.line_items.where(item_id: params[:item_id]).last
    @line_item.destroy!
    @order.set_order_total
    redirect_to new_order_path, alert: "해당 상품을 장바구니에서 삭제했습니다."
  end

  def update
    @order.paid!
    redirect_to @order
  end

  def show
  end

  def index
    @orders = current_user.orders.page(params[:page]).per(10)
  end


  private

  def set_object
    @order = Order.find(params[:id])
  end

end
