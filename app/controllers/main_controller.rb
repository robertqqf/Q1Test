class MainController < ApplicationController
  def index
  end

  def logout
    reset_session
    redirect_to root_path
  end

  def q1_test
    @cc = CityCode.all
    @cs = [[10, 10], [20, 20], [30, 30]]
  end

  def p_data
    #城市代码,通过提取用户的city_code_id即可。
    ccn = session[:city_code_id]
    #测试次数
    cs  = params[:cs]
    #计数器默认为0，然后累加至cs所指定的次数，status默认为0，如果测试完成改为1
    if Time.now < User.find(session[:user_id]).expire_date
      TestDb.create(city_code: ccn, cs: cs, count: 0, status: 0, user_id: session[:user_id], year: Time.now.year, month: Time.now.month)
    end
  end

  def item
    @cc   = CityCode.all
    @item = ContactInfo.new
  end

  def p_item
    unless params[:contact_info][:company].blank? || params[:contact_info][:name].blank? || params[:contact_info][:contact_info].blank? || params[:contact_info][:mac].blank? || params[:contact_info][:comment].blank?
      ContactInfo.create(ci_params)
    end
    redirect_to action: 'index'
  end

  private

  def ci_params
    params.required(:contact_info).permit(:company, :name, :contact_info, :mac, :comment)
  end

end
