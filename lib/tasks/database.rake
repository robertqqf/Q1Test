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
        prv       = f.province
        uid       = f.user_id

        #通过提取编号表中的编号与本月的测试记录中的编号进行比对来利旧旧的编号，这样可以少申请一些编号，甚至不需要再申请编号。
        cno_array = ClientNo.select('c_no').where('city_code_id = ? and province = ? and operator_code = 2', cc, prv).map(&:c_no)
        tl_list   = TestLog.where('city_code = ? and province = ? and created_at >= ? and created_at < ? ', cc, prv, Time.now.at_beginning_of_month, Time.now.at_beginning_of_month + 1.month).map(&:cno)

        tl_list.each do |tmp|
          cno_array.delete(tmp) if cno_array.include? tmp
        end

        ci_tmp = ContactInfo.find(rand(length)+1)
        if cno_array.blank?
          puts '-'*50 + 'get new cno.'
          cno = pd.get_client_no cc, prv, ci_tmp, uid, 2
          puts '-'*50 + cno.to_s
        else
          cno = cno_array[0]
        end

        if cno.blank?
          puts '-'*50 + ' cno is blank,pls check it.'
        else
          pd.send_data cc, prv, cno, ci_tmp, 2
          f.update_attribute(:count, f.count + 1)
          #创建测试记录，方便进行本月编号的比对。
          TestLog.create(cno: cno, city_code: cc, province: prv)
        end

      elsif f.count == f.cs
        f.update_attribute(:status, 1)
      end

      #测试移动xpon、联通xpon、电信xpon
      if f.cmcc_status == 0
        cc     = f.city_code
        prv    = f.province
        uid    = f.user_id
        length = CmccCi.count

        cno_array = ClientNo.select('c_no').where('city_code_id = ? and province = ? and operator_code = 12', cc, prv).map(&:c_no)
        ci_tmp    = CmccCi.find(rand(length)+1)

        if cno_array.blank?
          puts '-'*50 + 'get new cmcc cno.'
          cno = pd.get_client_no cc, prv, ci_tmp, uid, 12
          puts '-'*50 + cno.to_s
        else
          cno = cno_array[0]
        end

        if cno.blank?
          puts '-'*50 + 'cmcc cno is blank,pls check it.'
        else
          pd.send_data cc, prv, cno, ci_tmp, 12
          f.update_attribute(:cmcc_status, 1)
        end
      end

      if f.union_status == 0
        cc     = f.city_code
        prv    = f.province
        uid    = f.user_id
        length = UnionCi.count

        cno_array = ClientNo.select('c_no').where('city_code_id = ? and province = ? and operator_code = 3', cc, prv).map(&:c_no)
        ci_tmp    = UnionCi.find(rand(length)+1)

        if cno_array.blank?
          puts '-'*50 + 'get new union cno.'
          cno = pd.get_client_no cc, prv, ci_tmp, uid, 3
          puts '-'*50 + cno.to_s
        else
          cno = cno_array[0]
        end

        if cno.blank?
          puts '-'*50 + 'union cno is blank,pls check it.'
        else
          pd.send_data cc, prv, cno, ci_tmp, 3
          f.update_attribute(:union_status, 1)
        end
      end

      if f.tele_status == 0
        cc     = f.city_code
        prv    = f.province
        uid    = f.user_id
        length = TeleCi.count

        cno_array = ClientNo.select('c_no').where('city_code_id = ? and province = ? and operator_code = 1', cc, prv).map(&:c_no)
        ci_tmp    = UnionCi.find(rand(length)+1)

        if cno_array.blank?
          puts '-'*50 + 'get new tele cno.'
          cno = pd.get_client_no cc, prv, ci_tmp, uid, 1
          puts '-'*50 + cno.to_s
        else
          cno = cno_array[0]
        end

        if cno.blank?
          puts '-'*50 + 'tele cno is blank,pls check it.'
        else
          pd.send_data cc, prv, cno, ci_tmp, 1
          f.update_attribute(:tele_status, 1)
        end
      end

    end

  end

  desc '测试移动xpon数据'
  task :pdcmcc => :environment do
    pd     = PostData::DataProcedure.new

    tdbs = TestDb.where('created_at >= ? and created_at < ? and status = 0', Time.now.at_beginning_of_month, Time.now.at_beginning_of_month + 1.month)
    tdbs.each do |f|
      #测试移动xpon
      if f.cmcc_status == 0
        cc     = f.city_code
        prv    = f.province
        uid    = f.user_id
        length = CmccCi.count

        cno_array = ClientNo.select('c_no').where('city_code_id = ? and province = ? and operator_code = 12', cc, prv).map(&:c_no)
        ci_tmp    = CmccCi.find(rand(length)+1)

        if cno_array.blank?
          puts '-'*50 + 'get new cmcc cno.'
          cno = pd.get_client_no cc, prv, ci_tmp, uid, 12
          puts '-'*50 + cno.to_s
        else
          cno = cno_array[0]
        end

        if cno.blank?
          puts '-'*50 + 'cmcc cno is blank,pls check it.'
        else
          pd.send_data cc, prv, cno, ci_tmp, 12
          f.update_attribute(:cmcc_status, 1)
        end
      end
    end
  end

  desc '将青海的近出口数据发送至总部服务器上'
  task :pdjck => :environment do
    pd = PostData::DataProcedure.new
    pd.send_data_jck1
    pd.send_data_jck2

    puts "It's done."

  end

  desc '添加移动用户信息'
  task :cmcc => :environment do
    CmccCi.create(name: '吴小莉', contact_info: '10086', comment: '移动XPON用户', mac: '001e-90ac-64e1',company: 0)
    CmccCi.create(name: '魏嘉志', contact_info: '10086', comment: '移动XPON用户', mac: '0022-1906-dcc3',company: 0)
    CmccCi.create(name: '乐彦博', contact_info: '10086', comment: '移动XPON用户', mac: '001e-90ac-6438',company: 0)
    CmccCi.create(name: '殷伟诚', contact_info: '10086', comment: '移动XPON用户', mac: '000f-e29f-5b52',company: 0)
    CmccCi.create(name: '魏高俊', contact_info: '10086', comment: '移动XPON用户', mac: '000f-e2a8-12de',company: 0)
    CmccCi.create(name: '章明旭', contact_info: '10086', comment: '移动XPON用户', mac: '0014-c2d8-1bb8',company: 0)
    CmccCi.create(name: '潘俊哲', contact_info: '10086', comment: '移动XPON用户', mac: '0022-190e-6fa1',company: 0)
    CmccCi.create(name: '柳德厚', contact_info: '10086', comment: '移动XPON用户', mac: '000f-e2a8-12cd',company: 0)
    CmccCi.create(name: '史明旭', contact_info: '10086', comment: '移动XPON用户', mac: '0022-1906-e02b',company: 0)
    CmccCi.create(name: '吕宣朗', contact_info: '10086', comment: '移动XPON用户', mac: '0022-190e-75df',company: 0)
    CmccCi.create(name: '彭伟博', contact_info: '10086', comment: '移动XPON用户', mac: '0022-1912-3e87',company: 0)
    CmccCi.create(name: '袁宣朗', contact_info: '10086', comment: '移动XPON用户', mac: '0023-54d8-adef',company: 0)
    CmccCi.create(name: '酆建功', contact_info: '10086', comment: '移动XPON用户', mac: '0023-54d8-baa2',company: 0)
    CmccCi.create(name: '范熙泰', contact_info: '10086', comment: '移动XPON用户', mac: '0022-1912-3dee',company: 0)
    CmccCi.create(name: '郝熙华', contact_info: '10086', comment: '移动XPON用户', mac: '0022-1912-3e8a',company: 0)
    CmccCi.create(name: '任凯泽', contact_info: '10086', comment: '移动XPON用户', mac: '0023-54d8-baa0',company: 0)
    CmccCi.create(name: '许心怡', contact_info: '10086', comment: '移动XPON用户', mac: '000f-e2a8-1246',company: 0)
    CmccCi.create(name: '殷鸿涛', contact_info: '10086', comment: '移动XPON用户', mac: '0016-d399-38ec',company: 0)
    CmccCi.create(name: '俞德馨', contact_info: '10086', comment: '移动XPON用户', mac: '001a-4b85-c468',company: 0)
    CmccCi.create(name: '赵芳', contact_info: '10086', comment: '移动XPON用户', mac: '0022-1906-df15',company: 0)
    CmccCi.create(name: '赵锋', contact_info: '10086', comment: '移动XPON用户', mac: '0023-54e2-b8ac',company: 0)

    puts "It's done."

  end

  desc '添加联通用户信息'
  task :union => :environment do
    UnionCi.create(name: '柏雅惠', contact_info: '10010', comment: '联通XPON用户', mac: '001e-90ac-64e1',company: 0)
    UnionCi.create(name: '伍嘉云', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1906-dcc3',company: 0)
    UnionCi.create(name: '曹芷若', contact_info: '10010', comment: '联通XPON用户', mac: '001e-90ac-6438',company: 0)
    UnionCi.create(name: '李颖慧', contact_info: '10010', comment: '联通XPON用户', mac: '000f-e29f-5b52',company: 0)
    UnionCi.create(name: '史晓莉', contact_info: '10010', comment: '联通XPON用户', mac: '000f-e2a8-12de',company: 0)
    UnionCi.create(name: '韦红云', contact_info: '10010', comment: '联通XPON用户', mac: '000d-605e-5cd5',company: 0)
    UnionCi.create(name: '李秀筠', contact_info: '10010', comment: '联通XPON用户', mac: '000f-e2a8-12ad',company: 0)
    UnionCi.create(name: '吕红英', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1906-df5e',company: 0)
    UnionCi.create(name: '苗嘉歆', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1906-e398',company: 0)
    UnionCi.create(name: '沈清霁', contact_info: '10010', comment: '联通XPON用户', mac: '0022-190e-7670',company: 0)
    UnionCi.create(name: '马蕴秀', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1912-3e87',company: 0)
    UnionCi.create(name: '薛梦菲', contact_info: '10010', comment: '联通XPON用户', mac: '0023-54d8-adef',company: 0)
    UnionCi.create(name: '韩欣艳', contact_info: '10010', comment: '联通XPON用户', mac: '0023-54d8-baa2',company: 0)
    UnionCi.create(name: '安怀玉', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1912-3dee',company: 0)
    UnionCi.create(name: '郝欣笑', contact_info: '10010', comment: '联通XPON用户', mac: '000f-e2a8-12cd',company: 0)
    UnionCi.create(name: '殷若兰', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1906-e02b',company: 0)
    UnionCi.create(name: '王雅容', contact_info: '10010', comment: '联通XPON用户', mac: '0022-190e-75df',company: 0)
    UnionCi.create(name: '彭红云', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1912-3e87',company: 0)
    UnionCi.create(name: '范娟秀', contact_info: '10010', comment: '联通XPON用户', mac: '0023-54d8-adef',company: 0)
    UnionCi.create(name: '孙雪 ', contact_info: '10010', comment: '联通XPON用户', mac: '0023-54d8-baa2',company: 0)
    UnionCi.create(name: '张帆 ', contact_info: '10010', comment: '联通XPON用户', mac: '0022-1912-3dee',company: 0)

    puts "It's done."

  end

  desc '添加电信用户信息'
  task :tele => :environment do
    TeleCi.create(name: '章晓乐', contact_info: '10000', comment: '电信XPON用户', mac: '000f-e2a8-12cd',company: 0)
    TeleCi.create(name: '井欣雨', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1906-e02b',company: 0)
    TeleCi.create(name: '王子淳', contact_info: '10000', comment: '电信XPON用户', mac: '0022-190e-75df',company: 0)
    TeleCi.create(name: '潘彦辉', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1912-3e87',company: 0)
    TeleCi.create(name: '时从筠', contact_info: '10000', comment: '电信XPON用户', mac: '0023-54d8-adef',company: 0)
    TeleCi.create(name: '郁雅婷', contact_info: '10000', comment: '电信XPON用户', mac: '0023-54d8-baa2',company: 0)
    TeleCi.create(name: '滑靖雄', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1912-3dee',company: 0)
    TeleCi.create(name: '巩初蝶', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1912-3e8a',company: 0)
    TeleCi.create(name: '严玄庚', contact_info: '10000', comment: '电信XPON用户', mac: '0023-54d8-baa0',company: 0)
    TeleCi.create(name: '习元柳', contact_info: '10000', comment: '电信XPON用户', mac: '0022-190e-75df',company: 0)
    TeleCi.create(name: '袁宣朗', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1912-3e87',company: 0)
    TeleCi.create(name: '酆建功', contact_info: '10000', comment: '电信XPON用户', mac: '0023-54d8-adef',company: 0)
    TeleCi.create(name: '乐翠梅', contact_info: '10000', comment: '电信XPON用户', mac: '0023-54d8-baa2',company: 0)
    TeleCi.create(name: '任新然', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1912-3dee',company: 0)
    TeleCi.create(name: '马仁娟', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1912-3e8a',company: 0)
    TeleCi.create(name: '向之平', contact_info: '10000', comment: '电信XPON用户', mac: '000d-605e-5cd5',company: 0)
    TeleCi.create(name: '鲍沛萍', contact_info: '10000', comment: '电信XPON用户', mac: '000f-e2a8-12ad',company: 0)
    TeleCi.create(name: '杨中方', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1906-df5e',company: 0)
    TeleCi.create(name: '龙力', contact_info: '10000', comment: '电信XPON用户', mac: '0022-1906-e398',company: 0)
    TeleCi.create(name: '顾如彤', contact_info: '10000', comment: '电信XPON用户', mac: '0022-190e-7670',company: 0)
    TeleCi.create(name: '能采文', contact_info: '10000', comment: '电信XPON用户', mac: '0023-54e2-b8ac',company: 0)

    puts "It's done."

  end

end