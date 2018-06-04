ActiveAdmin.register Performer do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :avatar, :mobile, :_type, :school, :bio 
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do
  selectable_column
  column('#',:id)
  column 'ID', :uniq_id
  column '头像' do |o|
    image_tag o.avatar.url(:large), size: '32x32'
  end
  column :name
  column :mobile
  actions
end

form do |f|
  f.semantic_errors
  f.inputs do
    f.input :avatar
    f.input :name
    f.input :mobile
    f.input :_type, as: :select, collection: [['入驻艺人', 1], ['签约艺人', 2]]
    f.input :school
    f.input :bio
  end
  actions
end

end
