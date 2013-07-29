class MainController < ApplicationController
  def index
  end

  def q1_test
    @cc = CityCode.all
    @cs = [[10,10],[20,20],[30,30]]
  end

  def p_data
    #城市代码
    ccn = params[:ccn]
    #测试次数
    cs = params[:cs]
    #计数器默认为0，然后累加至cs所指定的次数，status默认为0，如果测试完成改为1
    TestDb.create(city_code: ccn, cs: cs, count: 0,status: 0,user_id: 1)

  end
end
