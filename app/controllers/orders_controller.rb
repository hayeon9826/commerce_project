class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_object, :check_owner, only: [:show, :update, :edit]
  #다른 사람도 주문 아이디만 알면 접근이 가능하므로 내 주문은 나만 볼 수 있도록 구너한


  def new
    @order = get_cart
  end

  def edit
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
    @order.update(object_params)
    redirect_to @order
  end

  def show
  end

  def index
    @orders = current_user.orders.paid.order(:paid_at).page(params[:page]).per(4)
  end


  private

  def set_object
    @order = Order.find(params[:id])
  end

  def object_params
    params.require(:order).permit(:zipcode, :address1, :address2)
  end

  def check_owner
    redirect_to root_path, notice: "권한이 없습니다" unless @order.user == current_user
  end

end
