ActiveAdmin.register Vote do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :_type, :expired_at, :body, :body_url, :video, :opened, :sort
  # vote_items_attributes: [:id, :performer_id, :vote_count, :_destroy]
#

index do
  selectable_column
  column('#',:id)
  column 'ID', :uniq_id
  column :title
  column :expired_at
  column :_type do |o|
    o._type == 1 ? '投单人' : '投多人'
  end
  column '参与选手' do |o|
    raw("#{o.vote_items.map { |vi| vi.perform.try(:name) }.join('<br>')}")
  end
  # column :body
  # column '视频文件' do |o|
  #   raw("<video
  #         id=\"video\"
  #         src=\"#{o.video_url}\"
  #         controls = \"true\"
  #         poster=\"\" /*视频封面*/
  #         preload=\"auto\"
  #         webkit-playsinline=\"true\" /*这个属性是ios 10中设置可以
  #                    让视频在小窗内播放，也就是不是全屏播放*/
  #         playsinline=\"true\"  /*IOS微信浏览器支持小窗内播放*/
  #         x-webkit-airplay=\"allow\"
  #         x5-video-player-type=\"h5\"  /*启用H5播放器,是wechat安卓版特性*/
  #         x5-video-player-fullscreen=\"true\" /*全屏设置，
  #                    设置为 true 是防止横屏*/
  #         x5-video-orientation=\"portraint\" //播放器支付的方向， landscape横屏，portraint竖屏，默认值为竖屏
  #         style=\"object-fit:fill\" width=\"240\">
  #         </video>")
  # end
  column '统计数据' do |o|
    raw("选手数: #{o.vote_items.count}<br>阅读量: #{o.view_count}<br>投票数: #{o.vote_count}")
  end
  column :sort
  column :opened
  column 'at', :created_at
  actions
end


form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :title, placeholder: '输入标题'
    f.input :_type, as: :radio, collection: [['单选', 1], ['多选', 2]], 
      hint: '单选是指用户只能选择一个进行投票，多选可以选择多个进行投票', required: true
    f.input :expired_at, as: :string, placeholder: '2018-01-01 12:30'
    f.input :body, as: :text, label: '投票介绍', input_html: { class: 'redactor' }, 
        placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    render partial: 'file_uploader', locals: { f: f }
    # f.input :body_url, label: '投票介绍文章地址',placeholder: '输入一个投票详情文章地址', hint: '投票介绍与文章地址至少填入一个'
    f.input :opened
    f.input :sort, hint: '值越大显示越靠前'
  end
  
  # f.inputs '投票选项' do
  #   f.has_many :vote_items, heading: nil, allow_destroy: true do |a|
  #     a.input :performer_id, as: :select, label: '候选艺人', collection: Performer.where(verified: true).map { |o| [o.name, o.uniq_id] }, prompt: '-- 选择候选艺人 --', required: true
  #   end
  # end
  
  actions
end

end
