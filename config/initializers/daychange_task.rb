require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.new

#scheduler.every("2s") do
scheduler.at '2014/07/31 16:10:00' do
   puts Time.now
end
