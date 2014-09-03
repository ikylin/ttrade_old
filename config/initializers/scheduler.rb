require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton


# Stupid recurrent task...
#
#s.cron '36 13 * * *' do

#  Rails.logger.info "hello, it's #{Time.now}"
#end
