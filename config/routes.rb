Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'items#index'
# 상품목록, 상품상세
  resources :items do
    member do
      get :toggle
    end
  end

   # 주문목록, 주문하기
  resources :orders do
    get :item_delete
  end
  resources :user_items # 찜하기
end
