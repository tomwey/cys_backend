ActiveAdmin.register Vote do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :_type, :expired_at, :body, :body_url, :opened, :sort, 
  vote_items_attributes: [:id, :performer_id, :vote_count, :_destroy]
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
  f.inputs '基本信息' do
    f.input :title, placeholder: '输入标题'
    f.input :_type, as: :radio, collection: [['单选', 1], ['多选', 2]], 
      hint: '单选是指用户只能选择一个进行投票，多选可以选择多个进行投票', required: true
    f.input :expired_at, as: :string, placeholder: '2018-01-01 12:30'
    f.input :body, as: :text, label: '投票介绍', input_html: { class: 'redactor' }, 
        placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :body_url, label: '投票介绍文章地址',placeholder: '输入一个投票详情文章地址', hint: '投票介绍与文章地址至少填入一个'
    f.input :opened
    f.input :sort, hint: '值越大显示越靠前'
  end
  
  f.inputs '投票选项' do
    f.has_many :vote_items, heading: nil, allow_destroy: true do |a|
      a.input :performer_id, as: :select, label: '候选艺人', collection: Performer.where(verified: true).map { |o| [o.name, o.uniq_id] }, prompt: '-- 选择候选艺人 --', required: true
    end
  end
  
  actions
end

end
