require 'rest-client'
module API
  module V1
    class MediaAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :media, desc: '多媒体相关接口' do
        desc "获取MV列表"
        params do
          requires :action, type: String, desc: '值为latest或hot'
          optional :school, type: String, desc: '学校'
          optional :token,  type: String, desc: '用户TOKEN'
          use :pagination
        end
        get '/:action' do
          unless %w(latest hot).include? params[:action]
            return render_error(-1, '不正确的action参数，值为latest或hot')
          end
          
          @medias = Media.opened.send(params[:action])
          if params[:school] && params[:school] != '全部'
            @medias = @medias.joins("inner join performers on performers.uniq_id = media.owner_id")
            .where('performers.school = ?', params[:school])
          end
          
          if params[:page]
            @medias = @medias.paginate page: params[:page], per_page: page_size
            total = @medias.total_entries
          else
            total = @medias.size
          end
          
          render_json(@medias, API::V1::Entities::MediaDetail, { user: User.find_by(private_token: params[:token]) }, total)
          
        end # end get list
        
      end # end resource
      
    end
  end
end