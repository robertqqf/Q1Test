#encoding : utf-8
require 'net/http'
require 'uri'
require 'json'

module PostData

  class DataProcedure

    def send_data(cc, prv, cno, f)
      ct                     = URI::encode(f.name.to_s.encode "GBK", "UTF-8")
      ci                     = URI::encode(f.contact_info.to_s.encode "GBK", "UTF-8")
      memo                   = URI::encode(f.comment.to_s.encode "GBK", "UTF-8")
      mac                    = URI::encode(f.mac.to_s.encode "GBK", "UTF-8")
      uri                    = URI.parse("http://221.174.16.37/chinatt2/postresult_f2_2.php?provincecode=#{prv}&citycode=#{cc}&operatorcode=2&contact=#{ct}&contactinfo=#{ci}&no=#{cno}&MACADDR=#{mac}&ver=2.0.3&memo=#{memo}")
      t_time                 = Time.now - 30.second
      posttime               = t_time.strftime("%Y-%-m-%-d %H:%M:%S")
      rtime                  = t_time.strftime("%a, %d %b %Y %H:%M:%S")
      xml_data               = gen_xml(rtime, posttime)

      # Create the HTTP objects
      http                   = Net::HTTP.new(uri.host, uri.port)
      request                = Net::HTTP::Post.new(uri.request_uri)
      request['conten-type'] = 'text/xml'
      request.body           = xml_data.to_s

      # Send the request
      response               = http.request(request)
      puts response.body

    end

    def get_client_no(cc, prv, f, uid)
      ct         = URI::encode(f.name.to_s.encode "GBK", "UTF-8")
      ci         = URI::encode(f.contact_info.to_s.encode "GBK", "UTF-8")
      memo       = URI::encode(f.comment.to_s.encode "GBK", "UTF-8")
      mac        = URI::encode(f.mac.to_s.encode "GBK", "UTF-8")
      get_no_uri = URI.parse("http://221.174.16.37/chinatt2/clientno.php?actiontype=getclientno&provincecode=#{prv}&citycode=#{cc}&operatorcode=2&contact=#{ct}&contactinfo=#{ci}&MACADDR=#{mac}&ver=2.0.3&memo=#{memo}&id=&no=")
      #get_no_uri = URI.parse("http://221.174.16.37/chinatt2/clientno.php?actiontype=getclientno&provincecode=19&citycode=#{cc}&operatorcode=1&contact=%C0%EE%C4%FE&contactinfo=10050&MACADDR=08-00-27-00-9C-11&ver=2.0.3&memo=%B5%E7%D0%C5%D3%C3%BB%A7&id=&no=")
      http       = Net::HTTP.new(get_no_uri.host, get_no_uri.port)
      get_r      = Net::HTTP::Get.new get_no_uri.request_uri
      response   = http.request(get_r)
      #puts response.body

      arr_tmp    = response.body.to_s.split
      unless arr_tmp[1].blank?
        ClientNo.create(c_no: arr_tmp[1], city_code_id: cc, user_id: uid, operator_code: 2, province: prv)
        arr_tmp[1]
      end
      #puts no
      #tt = { :contact => '李宁' }.to_query
    end

    def gen_xml(rtime, posttime)
      xml_data = '<?xml version="1.0"?>
<testset version="1.0" time="'+"#{rtime}"+'">
 <paras>
  <para name="PacketSize" value="128"/>
  <para name="PacketNumber" value="10"/>
  <para name="TTL" value="64"/>
  <para name="TimeOut" value="2"/>
  <para name="Interval" value="60"/>
 </paras>
 <sites>
  <site desc="腾讯" ip="www.qq.com" url="http://www.qq.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="3" reset="4" delay="7"  hops="201" loss="0"  tag="2"  speed="' + gen_ranstr(3000, 1) + '" sdelay="' + gen_ranstr(97, 2) + '" fspeed="' + gen_ranstr(440, 2) + '" ie_full="' + gen_ranstr(1880, 2) + '"  route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.165;0,15,0,222.50.127.53;0,16,0,61.237.121.122;0,16,0,61.237.2.74;15,0,16,10.200.5.33;0,15,0,10.200.5.54;16,0,16,10.200.102.162;0,15,16,10.187.246.169;0,15,16,10.187.246.169;0,15,0,182.254.1.167;" rhops="11" rhops2="11"/>
  <site desc="搜狐" ip="www.sohu.com" url="http://www.sohu.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="8" reset="4" delay="39"  hops="211" loss="0"  tag="2"  speed="' + gen_ranstr(1633, 1) + '" sdelay="' + gen_ranstr(110, 2) + '" fspeed="' + gen_ranstr(640, 2) + '" ie_full="' + gen_ranstr(2440, 2) + '"  route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.165;0,15,0,222.50.127.57;0,16,0,61.237.122.70;-1,-1,-1,*;16,-1,16,221.176.18.97;0,31,0,221.183.10.89;47,0,31,221.183.14.14;16,31,0,221.181.240.226;31,16,31,112.25.2.34;0,31,16,112.25.2.226;31,31,31,112.25.24.135" rhops="13" rhops2="13"/>
  <site desc="网易" ip="www.163.com" url="http://www.163.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="10" reset="4" delay="46"  hops="209" loss="0"  tag="2"  speed="' + gen_ranstr(1900, 1) + '" sdelay="' + gen_ranstr(112, 2) + '" fspeed="' + gen_ranstr(1000, 2) + '" ie_full="' + gen_ranstr(6310, 2) + '"  route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.157;0,15,0,222.50.127.101;0,16,0,61.237.121.110;-1,-1,-1,*;16,15,0,221.176.18.97;47,-1,47,221.176.18.14;0,47,15,221.176.20.154;16,31,16,211.137.98.50;31,31,31,183.221.240.62;31,16,31,183.221.240.70;31,63,63,223.87.1.59;" rhops="13" rhops2="13"/>
  <site desc="优酷"  ip="www.youku.com" url="http://www.youku.com" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="7" reset="4" delay="31" hops="8" loss="0" tag="2" speed="' + gen_ranstr(650, 1) + '" sdelay="' + gen_ranstr(85, 2) + '" fspeed="' + gen_ranstr(693, 2) + '" ie_full="' + gen_ranstr(2100, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.149;15,0,0,222.50.127.57;32,31,31,61.237.126.117;47,31,31,222.44.0.170;31,32,31,222.44.1.222;31,31,16,122.72.120.241;" rhops="8" rhops2="8"/>
  <site desc="迅雷" ip="www.xunlei.com" url="http://www.xunlei.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="1" reset="7" delay="9" hops="202" loss="0" tag="2" speed="' + gen_ranstr(3700, 1) + '" sdelay="' + gen_ranstr(97, 2) + '" fspeed="' + gen_ranstr(201, 2) + '" ie_full="' + gen_ranstr(8700, 2) + '" route="0,0,0,172.16.36.8;94,0,-1,61.235.93.65;16,0,0,110.211.254.165;0,15,0,61.235.68.209;0,16,0,119.9.127.1;0,0,16,221.4.120.197;0,0,15,221.4.7.65;0,0,16,221.4.2.21;0,15,0,120.80.2.26;16,16,15,221.4.124.142;0,16,-1,120.80.198.250;0,15,0,58.251.57.175;" rhops="12" rhops2="12"/>
  <site desc="新浪" ip="www.sina.com.cn" url="http://www.sina.com.cn/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="7" reset="9" delay="42" hops="199" loss="0" tag="2" speed="' + gen_ranstr(800, 1) + '" sdelay="' + gen_ranstr(103, 2) + '" fspeed="' + gen_ranstr(634, 2) + '" ie_full="' + gen_ranstr(3000, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.165;0,15,0,222.50.127.57;47,47,31,61.237.121.85;47,47,47,61.233.9.21;31,47,46,222.35.65.178;32,46,47,211.98.132.67;" rhops="8" rhops2="8"/>
  <site desc="土豆" ip="www.tudou.com" url="http://www.tudou.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="3" reset="12" delay="37" hops="199" loss="0" tag="2" speed="' + gen_ranstr(355, 1) + '" sdelay="' + gen_ranstr(103, 2) + '" fspeed="' + gen_ranstr(536, 2) + '" ie_full="' + gen_ranstr(2010, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.165;15,0,0,222.50.127.81;32,62,47,61.237.97.125;31,47,47,222.44.0.170;31,31,47,222.44.1.238;31,31,47,122.72.120.212;" rhops="8" rhops2="8"/>
  <site desc="POCO" ip="www.poco.cn" url="http://www.poco.cn/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="7" reset="7" delay="25" hops="203" loss="0" tag="2" speed="' + gen_ranstr(410, 1) + '" sdelay="' + gen_ranstr(104, 2) + '" fspeed="' + gen_ranstr(656, 2) + '" ie_full="' + gen_ranstr(11100, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.141;0,15,0,61.234.109.245;0,16,0,61.235.68.221;0,0,16,222.50.127.49;31,47,31,61.237.122.178;47,31,47,61.237.0.178;46,32,31,202.97.15.77;31,31,47,202.97.50.217;31,31,32,202.97.68.46;46,32,31,61.174.69.86;4,7,31,31,61.175.3.18;47,47,31,122.227.136.130;47,46,32,183.136.195.32;" rhops="15"  rhops2="15"/>
  <site desc="Tom在线" ip="www.tom.com" url="http://www.tom.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="7" reset="40" delay="48" hops="209" loss="0" tag="2" speed="' + gen_ranstr(310, 1) + '" sdelay="' + gen_ranstr(102, 2) + '" fspeed="' + gen_ranstr(269, 2) + '" ie_full="' + gen_ranstr(2100, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.157;15,0,0,222.50.127.101;0,16,0,61.237.121.110;-1,-1,-1,*;16,15,0,221.176.18.97;-1,0,47,221.176.18.14;0,47,15,221.176.20.154;47,0,47,211.137.98.50;0,47,0,183.221.240.62;62,0,47,183.221.240.70;0,62,62,223.87.1.59;" rhops="13" rhops2="13"/>
  <site desc="中国中央电视台" ip="www.cctv.com" url="http://www.cctv.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="4" reset="45" delay="49" hops="209" loss="0" tag="2" speed="' + gen_ranstr(250, 1) + '" sdelay="' + gen_ranstr(103, 2) + '" fspeed="' + gen_ranstr(153, 2) + '" ie_full="' + gen_ranstr(23300, 2) + '" route="0,0,0,172.16.36.8;78,-1,16,61.235.93.65;0,0,0,110.211.254.157;15,0,0,222.50.127.101;16,0,0,61.237.121.110;-1,-1,-1,*;-1,16,15,221.176.18.97;0,31,16,221.176.18.14;31,16,47,221.176.20.158;0,46,0,211.137.98.50;47,16,31,183.221.240.62;16,46,0,183.221.240.70;47,63,63,223.87.1.59;" rhops="13" rhops2="13"/>
  <site desc="新时速" ip="www.68cn.com" url="http://www.68cn.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="3" reset="42" delay="3" hops="196" loss="0" tag="2" speed="' + gen_ranstr(1320, 1) + '" sdelay="' + gen_ranstr(53, 2) + '" fspeed="' + gen_ranstr(66, 2) + '" ie_full="' + gen_ranstr(487, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.129;15,0,0,222.50.126.2;16,0,0,61.235.71.8;" rhops="5" rhops2="5"/>
  <site desc="北京联通" ip="www.bj.cnc.cn" url="http://www.bj.cnc.cn/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="-1" reset="0" delay="0" hops="1" loss="0" tag="2" speed="-1" sdelay="-1" fspeed="-1" ie_full="-1" route="0,0,0,127.0.0.1;" rhops="1" rhops2="1"/>
  <site desc="上海联通" ip="www.sh.cnc.cn" url="http://www.sh.cnc.cn/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="-1" reset="0" delay="0" hops="1" loss="0" tag="2" speed="-1" sdelay="-1" fspeed="-1" ie_full="-1" route="0,0,0,127.0.0.1;" rhops="1" rhops2="1"/>
  <site desc="广东联通" ip="www.gd.cnc.cn" url="http://www.gd.cnc.cn/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="4" reset="57" delay="15" hops="210" loss="0" tag="2" speed="' + gen_ranstr(380, 1) + '" sdelay="' + gen_ranstr(150, 2) + '" fspeed="' + gen_ranstr(396, 2) + '" ie_full="' + gen_ranstr(2712, 2) + '" route="0,0,0,172.16.36.8;78,0,0,61.235.93.65;15,0,0,110.211.254.157;16,0,0,61.235.68.209;16,0,0,10.255.0.126;15,0,31,192.168.16.1;16,0,0,20.110.1.7;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="10" rhops2="-1"/>
  <site desc="四川联通" ip="www.sc.cnc.cn" url="http://www.169ol.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="4" reset="23" delay="0" hops="1" loss="0" tag="2" speed="' + gen_ranstr(429, 1) + '" sdelay="' + gen_ranstr(120, 2) + '"  fspeed="' + gen_ranstr(360, 2) + '" ie_full="' + gen_ranstr(3551, 2) + '" route="0,0,0,127.0.0.1;" rhops="1" rhops2="1"/>
  <site desc="黑龙江联通" ip="www.hl.cnc.cn" url="http://www.hlj165.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="3" reset="62" delay="67" hops="143" loss="0" tag="2" speed="' + gen_ranstr(400, 1) + '" sdelay="' + gen_ranstr(120, 2) + '" fspeed="' + gen_ranstr(600, 2) + '" ie_full="' + gen_ranstr(4100, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.149;15,0,0,61.235.68.209;16,0,0,61.235.68.166;0,16,0,222.50.127.33;0,15,0,61.237.121.126;0,0,16,221.4.120.173;0,0,15,221.4.7.33;32,31,31,120.80.0.69;16,0,15,219.158.19.9;31,47,31,219.158.101.117;94,62,63,219.158.8.238;78,78,62,113.4.128.190;78,63,62,113.4.128.62;62,63,62,221.212.26.154;-1,-1,-1,*;78,-1,62,221.212.213.106;" rhops="18" rhops2="18"/>
  <site desc="北京电信" ip="www.bjtelecom.net" url="http://www.bjtelecom.net/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="3" reset="64" delay="42" hops="204" loss="0" tag="2" speed="0.8" sdelay="' + gen_ranstr(150, 2) + '" fspeed="' + gen_ranstr(350, 2) + '" ie_full="' + gen_ranstr(300, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.165;15,0,0,61.234.109.245;16,0,0,61.235.68.221;0,16,0,222.50.127.49;0,15,0,61.237.121.126;0,16,0,61.237.5.10;15,0,0,202.97.44.17;47,47,31,202.97.34.37;78,-1,-1,220.181.16.18;-1,31,-1,218.30.104.26;47,47,31,220.181.17.78;47,31,47,220.181.22.228;" rhops="14" rhops2="14"/>
  <site desc="上海电信" ip="www.shanghaitelecom.com.cn" url="http://sh.ct10000.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="1" reset="31" delay="0" hops="1" loss="0" tag="2" speed="' + gen_ranstr(135, 1) + '" sdelay="' + gen_ranstr(170, 2) + '" fspeed="' + gen_ranstr(820, 2) + '" ie_full="' + gen_ranstr(2600, 2) + '" route="0,0,0,127.0.0.1;" rhops="1" rhops2="1"/>
  <site desc="广东电信" ip="www.gdtel.com.cn" url="http://www.gdtel.com.cn/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="1" reset="38" delay="6" hops="15" loss="0" tag="2" speed="' + gen_ranstr(85, 1) + '" sdelay="' + gen_ranstr(210, 2) + '" fspeed="' + gen_ranstr(550, 2) + '" ie_full="' + gen_ranstr(4000, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.141;15,0,0,61.234.109.245;0,16,0,61.235.68.221;0,0,16,222.50.127.49;0,0,0,61.237.127.234;15,0,0,202.105.95.10;16,15,0,202.97.53.6;16,0,0,202.97.46.85;16,0,15,61.144.3.5;0,0,16,183.56.31.42;0,0,15,61.144.5.17;0,16,0,183.63.98.102;-1,-1,-1,*;16,0,0,61.144.150.133;15,0,16,61.144.150.133;0,15,0,61.140.99.33;" rhops="18" rhops2="18"/>
  <site desc="四川电信" ip="www.sctel.com.cn" url="http://www.sctel.com.cn/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="4" reset="59" delay="42" hops="13" loss="0" tag="2" speed="' + gen_ranstr(180, 1) + '" sdelay="' + gen_ranstr(203, 2) + '" fspeed="' + gen_ranstr(1000, 2) + '" ie_full="' + gen_ranstr(3600, 2) + '" route="0,0,0,172.16.36.8;78,0,-1,61.235.93.65;16,0,0,110.211.254.149;15,0,0,61.234.109.245;16,0,0,61.235.68.221;0,16,0,222.50.127.49;0,15,0,61.237.121.122;0,16,0,202.105.95.10;0,15,16,202.97.63.250;0,16,0,202.97.46.121;46,32,46,202.97.35.182;47,31,47,171.208.202.178;47,31,47,222.210.99.26;-1,-1,-1,*;62,-1,47,61.157.77.198;" rhops="15" rhops2="15"/>
  <site desc="黑龙江电信" ip="www.hljtele.com" url="http://www.hljtele.com/" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="-1" reset="47" delay="0" hops="1" loss="0" tag="2" speed="-1" sdelay="-1" fspeed="-1" ie_full="-1" route="0,0,0,127.0.0.1;" rhops="1" rhops2="1"/>
  <site desc="百度" ip="www.baidu.com" url="http://www.baidu.com" ftp="" time="' + "#{posttime}" + '" pdns="61.235.70.252" sdns="61.235.70.98" dns="3" reset="67" delay="35" hops="202" loss="0" tag="2" speed="' + gen_ranstr(350, 1) + '" sdelay="' + gen_ranstr(110, 2) + '" fspeed="' + gen_ranstr(152, 2) + '" ie_full="' + gen_ranstr(260, 2) + '" route="0,0,0,172.16.36.8;78,-1,16,61.235.93.65;0,0,0,110.211.254.157;15,0,0,222.50.127.61;47,31,32,61.237.123.129;46,32,31,61.233.9.202;47,31,31,222.35.251.110;31,47,31,222.35.251.202;47,31,47,192.168.0.5;31,47,31,10.65.190.130;31,47,31,119.75.218.77;" rhops="11" rhops2="11"/>
 </sites>
</testset>'
    end

    def gen_ranstr(base, type)
      other = base / 10
      if type == 1
        result = (base + (rand(0) * other).round(1)).to_s
      else
        result = (base + (rand(0) * other).round(0)).to_s
      end
      result
    end


  end
end