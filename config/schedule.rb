# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
env :PATH, ENV['PATH']
#添加环境变量,否则找不到bundle命令。
set :output, "#{path}/log/whenever.log" #设置日志输出文件

#每一个小时做一次，一直到做满所指定的次数。
every 1.hours do
  rake 'database:pd'
end

every 1.month do
  rake 'database:pdjck'
end