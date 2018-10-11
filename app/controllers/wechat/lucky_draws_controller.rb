class Wechat::LuckyDrawsController < Wechat::ApplicationController
  layout 'application'
  
  skip_before_filter :check_weixin_legality
  
  before_filter :require_user
  before_filter :check_user
  
  def checkin
    @ld = LuckyDraw.find_by(uniq_id: params[:id])
    if @ld.blank? or !@ld.opened
      render text: '抽奖不存在', status: 404
      return
    end
    
    LuckyDrawCheckin.where(user_id: current_user.id, lucky_draw_id: @ld.id).first_or_create!
    
    @prize = @ld.lucky_draw_items.where(opened: true).where(started_at: nil).order('sort asc').first
  end
  
  private 
  def require_user
    if current_user.blank?
      # 登录
      store_location
      redirect_to wechat_login_path
    end
  end
  
  def check_user
    unless current_user.verified
      # flash[:error] = "您的账号已经被禁用"
      # redirect_to wechat_shop_root_path
      render(text: "您的账号已经被禁用", status: 403)
      return
    end
  end
  
end