class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_items, dependent: :destroy
 #찜하기는 회원 삭제되면 같이 없어짐

 has_many :items, dependent: :nullify
 #등록된 상품은 회원 삭제되도 유지. 외래키만 null로 변환
 has_many :orders, dependent: :destroy #order가 user_id를 가지고 있는 것

 def has_item? item
   user_items.where(item: item).present?
 end
end
