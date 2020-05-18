class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :item


  # line_item변결될 때마다 주문의 총 가격 변경!
  
  after_save :set_order_total

  def set_order_total
    order.update(total: order.line_items.sum("amount * price"))
  end
end
