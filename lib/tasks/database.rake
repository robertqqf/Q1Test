namespace :database do

  desc '测试是否生效'
  task :test => :environment do
    puts "hello"
  end

  desc '提取数据库中的数据进行发送至总部服务器上'
  task :pd => :environment do
    pd = PostData::DataProcedure.new

    puts URI::encode(Iconv.conv("GBK","UTF-8","李宁"))
    pd.get_client_no 1
  end


end