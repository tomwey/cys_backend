module API
  module V1
    class CommentsAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :comments, desc: '评论相关的接口' do
        
        desc "获取评论"
        params do
          optional :token,     type: String,  desc: '用户TOKEN'
          requires :comment_type, type: String,  desc: '被评论的类型，默认为Media'
          requires :comment_id, type: Integer,  desc: '被评论的对象ID'
          use :pagination
        end
        get do
          @comments = Comment.where(opened: true).where(commentable_type: params[:comment_type], commentable_id: params[:commentable_id]).order('created_at desc')
          if params[:page]
            @comments = @comments.paginate page: params[:page], per_page: page_size
            total = @comments.total_entries
          else
            total = @comments.size
          end
          render_json(@comments, API::V1::Entities::Comment, {}, total)
          
        end # end get /
        
        desc "发评论"
        params do
          requires :token,     type: String,  desc: '用户TOKEN'
          requires :comment_type, type: String,  desc: '评论的对象类型，默认为Media'
          requires :comment_id,   type: Integer, desc: '评论的对象ID'
          requires :content, type: String, desc: '评论内容'
          optional :address, type: String, desc: '评论的地理位置'
        end
        post :create do
          user = authenticate!
          
          klass = Object.const_get params[:comment_type]
          @commentable = klass.find_by(uniq_id: params[:comment_id])
          if @commentable.blank?
            return render_error(4004, '被评论的对象不存在')
          end
          
          @comment = Comment.create!(user_id: user.uid, commentable_type: @commentable.class, commentable_id: @commentable.uniq_id || @commentable.id, content: params[:content], ip: client_ip, address: params[:address])
          
          render_json(@comment, API::V1::Entities::Comment)
          
        end # end like create
        
        
        
      end # end resource
      
    end
  end
end