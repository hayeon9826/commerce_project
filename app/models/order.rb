class Order < ApplicationRecord
  belongs_to :user, optional: true
  enum status: [:cart, :paid, :canceled]

  has_many :line_items, dependent: :destroy

  def set_order_total
    self.update(total: self.line_items.sum("amount * price"))
  end

end
