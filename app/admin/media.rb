ActiveAdmin.register Media do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :_type, :title, :summary, :cover, :file, :play_url, :duration, :owner_id, :opened, :sort, { tags: [] }, radio_content_attributes: [:id, :lyrics, :composer, :original_singer, :content, :_destroy]

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
    f.input :_type, as: :select, collection: [['电台', 1], ['MV', 2]]
    f.input :owner_id, as: :select, collection: Performer.where(verified: true).order('id desc').map { |p| [p.name, p.uniq_id] }, required: true
    f.input :title, placeholder: '作品标题'
    f.input :cover, hint: '图片建议尺寸为1650x928，格式为：jpg/png/gif'
    f.input :file, hint: '播放文件格式为：mp4/mp3/ogg/wav'
    f.input :summary, placeholder: '简要介绍作品'
    f.input :duration, placeholder: '02:30'
    # f.input :play_url
    f.input :opened
    f.input :sort, hint: '值越大显示越靠前'
  end
  
  f.inputs '电台MP3其它信息',
    data: { need_show: "#{(f.object and f.object._type == 1) ? '1' : '0'}" },
    id: 'radio-content',
    for: [:radio_content, (f.object.radio_content || RadioContent.new)] do |s|
      s.input :lyrics, label: '作词'
      s.input :composer, label: '作曲'
      s.input :original_singer, label: '原唱'
      s.input :content, as: :text, label: '歌词', input_html: { class: 'redactor' }, 
        placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
  end
  
  actions
end

end
