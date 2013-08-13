class LoginController < ApplicationController
  skip_before_filter :authenticate, :only => [:index, :login]

  def index

  end

  def login
    name = params[:name]
    pass = params[:pass]
    user = User.find_by_name(name)

    if user.blank?
      flash[:error] = '用户名或密码输入不正确，请重试!'
      redirect_to root_path
    else
      if Digest::MD5.hexdigest(pass) == user.password && Time.now < user.expire_date
        session[:user_id]      = user.id
        session[:company]      = user.company
        session[:city_code_id] = user.city_code_id
        redirect_to main_index_url
      elsif Time.now >= user.expire_date
        flash[:error] = '阁下的帐号已过期，考虑到本系统主人也是一个苦逼的程序猿，各位就赞助一点银两吧!'
        redirect_to root_path
      else
        flash[:error] = '用户名或密码输入不正确，请重试!'
        redirect_to root_path
      end
    end
  end
end
