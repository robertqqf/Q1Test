#encoding : utf-8
require 'net/http'
require 'uri'
require 'json'

module PostData

  class DataProcedure

    def send_data(cno)
      uri                    = URI.parse("http://221.174.16.37/chinatt2/postresult_f2_2.php?provincecode=19&citycode=6&operatorcode=1&contact=%C0%EE%C4%FE&contactinfo=10050&no=#{cno}&MACADDR=08-00-27-00-9C-11&ver=2.0.3&memo=%B5%E7%D0%C5%D3%C3%BB%A7")
      posttime               = Time.now
      rtime                  = Time.now.strftime("%a, %d %b %Y %H:%M:%S")
      tt                     = "#{rtime}"
      xml_data               = '<?xml version="1.0"?>
<testset version="1.0" time="'+"#{rtime}"+'">
 <paras>
  <para name="PacketSize" value="128"/>
  <para name="PacketNumber" value="10"/>
  <para name="TTL" value="64"/>
  <para name="TimeOut" value="2"/>
  <para name="Interval" value="60"/>
 </paras>
 <sites>
  <site desc="雅虎中国" ip="www.yahoo.com.cn" url="http://www.yahoo.com.cn" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="8" reset="6" speed="878.9" sdelay="63" fspeed="200" ie_full="1305" delay="23" hops="-1" loss="0" tag="2" route="10,0,0,61.234.169.1;10,20,20,10.10.40.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
   <site desc="腾讯QQ" ip="www.qq.com" url="http://www.qq.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="777.5" sdelay="54" fspeed="322" ie_full="1950" route="8,9,9,61.234.169.1;11,15,15,172.20.16.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="ebay" ip="www.ebay.com" url="http://www.ebay.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="877.5" sdelay="52" fspeed="320" ie_full="1950" route="10,11,11,61.234.169.1;15,15,15,192.100.200.5;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="搜狐网" ip="www.sohu.com" url="http://www.sohu.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="759.5" sdelay="54" fspeed="175" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,117.79.254.117;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="Google" ip="www.google.com" url="http://www.google.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="797" sdelay="54" fspeed="200" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,112.90.193.137;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="淘宝网" ip="www.taobao.com" url="http://www.taobao.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="788" sdelay="54" fspeed="185" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,192.10.10.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="Tom在线" ip="www.tom.com" url="http://www.tom.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="995" sdelay="54" fspeed="198" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,172.20.15.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="迅雷在线" ip="www.xunlei.com" url="http://www.xunlei.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="776" sdelay="54" fspeed="305" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,192.100.200.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="东方财富网" ip="www.eastmoney.com" url="http://www.eastmoney.com" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="799" sdelay="54" fspeed="527" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,10.110.231.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="北京联通" ip="www.bj.cnc.cn" url="http://www.bj.cnc.cn" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="784" sdelay="54" fspeed="309" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,61.145.64.5;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="上海联通" ip="www.sh.cnc.cn" url="http://www.sh.cnc.cn" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="792.5" sdelay="54" fspeed="513" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,10.100.4.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="广东联通" ip="www.gd.cnc.cn" url="http://www.gd.cnc.cn" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="781" sdelay="54" fspeed="211" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,192.10.14.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="四川联通" ip="www.sc.cnc.cn" url="http://www.sc.cnc.cn" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="767" sdelay="54" fspeed="233" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,10.254.150.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="北京电信" ip="www.bjtelecom.net" url="http://www.bjtelecom.net" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="1087.5" sdelay="54" fspeed="206" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,123.88.127.145;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="黑龙江联通" ip="www.hl.cnc.cn" url="http://www.hl.cnc.cn" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="780.5" sdelay="54" fspeed="217" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,10.210.16.1;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
  <site desc="上海电信" ip="www.shanghaitelecom.com.cn" url="http://www.shanghaitelecom.com.cn" ftp="" time="' +"#{posttime}"+ '" pdns="61.235.70.98" sdns="61.235.70.252" dns="6" reset="3" delay="23" hops="203" loss="0" tag="2" speed="793" sdelay="54" fspeed="202" ie_full="1950" route="10,11,11,61.234.169.1;10,15,15,219.158.13.177;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;-1,-1,-1,*;" rhops="11" rhops2="11"/>
 </sites>
</testset>'

      # Create the HTTP objects
      http                   = Net::HTTP.new(uri.host, uri.port)
      request                = Net::HTTP::Post.new(uri.request_uri)
      request['conten-type'] = 'text/xml'
      request.body           = xml_data.to_s

      # Send the request
      response               = http.request(request)
      puts response.body

    end

    def get_client_no(cc, mac='')
      get_no_uri = URI.parse("http://221.174.16.37/chinatt2/clientno.php?actiontype=getclientno&provincecode=19&citycode=#{cc}&operatorcode=1&contact=%C0%EE%C4%FE&contactinfo=10050&MACADDR=08-00-27-00-9C-11&ver=2.0.3&memo=%B5%E7%D0%C5%D3%C3%BB%A7&id=&no=")
      http       = Net::HTTP.new(get_no_uri.host, get_no_uri.port)
      get_r      = Net::HTTP::Get.new get_no_uri.request_uri
      response   = http.request(get_r)
      #puts response.body

      arr_tmp    = response.body.to_s.split
      no         = arr_tmp[1]
      puts no


      #tt = { :contact => '李宁' }.to_query
      puts tt
    end
  end
end