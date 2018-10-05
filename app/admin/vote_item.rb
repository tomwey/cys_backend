ActiveAdmin.register VoteItem do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :performer_id, :body, :video, :sort, :opened, :vote_id
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
  column '#', :id
  column 'ID', :uniq_id
  column '所属投票' do |o|
    o.vote.try(:title) ? link_to(o.vote.try(:title), admin_vote_path(o.vote)) : '--'
  end
  column '候选艺人' do |o|
    o.perform ? link_to(o.perform.name, admin_performer_path(o.perform)) : '--'
  end
  column '得票数', :vote_count
  column '是否启用', :opened
  column 'at', :created_at
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :vote_id, as: :select, label: '所属投票', collection: Vote.order('id desc').map { |vote| [vote.title, vote.id] }
    f.input :performer_id, as: :select, label: '候选艺人', collection: Performer.where(verified: true).map { |o| [o.name, o.uniq_id] }, prompt: '-- 选择候选艺人 --', required: true
    render partial: 'file_uploader', locals: { f: f }
    f.input :body, as: :text, input_html: { class: 'redactor' }, 
        placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :opened
    f.input :sort, hint: '值越小显示越靠前'
  end
  
  actions
end

end
