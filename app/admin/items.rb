ActiveAdmin.register Item do
  menu parent: "상품 관리"
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :title, :price, :description, :image, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :title, :price, :description, :image, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
    index do
  	selectable_column
  	id_column
  	column :user
  	column :category
  	column :title
  	column :image do |obj|
  		link_to(image_tag(obj.image.url, style: "width: 100px;"), obj.image.url, target: :_blank) if obj.image?
  	end
  	column :created_at
  	actions
  end
end
