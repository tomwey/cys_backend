ActiveAdmin.register LuckyDraw do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :body, :opened, lucky_draw_items_attributes: [:id, :name, :quantity, :prize, :opened, :sort, :_destroy]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
  f.semantic_errors
  f.inputs '基本资料' do
    f.input :title
    f.input :body, as: :text, input_html: { class: 'redactor' }, placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :opened
  end
  
  f.inputs "抽奖奖项" do
    f.has_many :lucky_draw_items, allow_destroy: true, heading: '抽奖奖项' do |item_form|
      item_form.input :name, placeholder: '例如：一等奖12名或幸运奖50名'
      item_form.input :quantity
      item_form.input :prize, placeholder: '例如：价值50元电影票'
      item_form.input :opened
      item_form.input :sort, hint: '显示顺序，值越小越靠前'
    end
  end
  
  actions
end

end
