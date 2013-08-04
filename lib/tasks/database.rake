namespace :database do

  desc '测试是否生效'
  task :test => :environment do
    puts "hello"
  end

  desc '提取数据库中的数据进行发送至总部服务器上'
  task :pd => :environment do
    pd     = PostData::DataProcedure.new

    #puts URI::encode(Iconv.conv("GBK", "UTF-8", "李宁"))

    length = ContactInfo.count

    tdbs = TestDb.where('created_at >= ? and created_at < ? and status = 0', Time.now.at_beginning_of_month, Time.now.at_beginning_of_month + 1.month)
    tdbs.each do |f|
      if f.count < f.cs
        ci_tmp = ContactInfo.find(rand(length)+1)
        #todo:得到当前用户的city_code_id,正式部署的时候用
        cc     = session[:city_code_id]
        #cc     = 6
        #cno    = pd.get_client_no cc, ct, ci, memo, mac
        cno    = pd.get_client_no 6,ci_tmp
puts '-'*50 + cno.to_s
        pd.send_data cc,cno,ci_tmp

        f.update_attribute(:count, f.count + 1)
      elsif f.count == f.cs
        f.update_attribute(:status, 1)
      end

    end


    #get_client_no(cc,contact,ci,memo, mac)
  end


end