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
        cc        = f.city_code

        #通过提取编号表中的编号与本月的测试记录中的编号进行比对来利旧旧的编号，这样可以少申请一些编号，甚至不需要再申请编号。
        cno_array = ClientNo.select('c_no').where('city_code_id = ? and operator_code = 2', cc).map(&:c_no)
        tl_list   = TestLog.where('city_code = ? and created_at >= ? and created_at < ?', cc, Time.now.at_beginning_of_month, Time.now.at_beginning_of_month + 1.month).map(&:cno)

        tl_list.each do |tmp|
          cno_array.delete(tmp) if cno_array.include? tmp
        end

        ci_tmp = ContactInfo.find(rand(length)+1)
        if cno_array.blank?
          puts '-'*50 + 'get new cno.'
          cno = pd.get_client_no cc, ci_tmp
          puts '-'*50 + cno.to_s
        else
          cno = cno_array[0]
        end

        if cno.blank?
          puts '-'*50 + ' cno is blank,pls check it.'
        else
          pd.send_data cc, cno, ci_tmp
          f.update_attribute(:count, f.count + 1)
          #创建测试记录，方便进行本月编号的比对。
          TestLog.create(cno: cno, city_code: cc)
        end

      elsif f.count == f.cs
        f.update_attribute(:status, 1)
      end

    end

  end

end