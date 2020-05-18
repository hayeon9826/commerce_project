class ApplicationController < ActionController::Base


  def get_cart
    current_user.orders.cart.first_or_create
    #첫번째 레코드가 있으면 가져오고, 없으면 생성
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

end
