class Item < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  has_many :line_items, dependent: :nullify

  mount_uploader :image, ImageUploader

  def self.generate_items
    %w(샤오미 안드로이드 아이패드 맥북 시계 애플와치 갤러시케어).each do |title|
      category = Category.third
      Item.create(category: category, title:title, price:20000, image: Item.first.image, user: User.first, description: "상품 설명 입니다")
    end
  end
end
