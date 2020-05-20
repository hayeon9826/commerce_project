class UserItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.user_items.page(params[:page]).per(8)
  end
end
