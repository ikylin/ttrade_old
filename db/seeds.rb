# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#uid = User.find_by(openid: '123')
#Marketdate.all.each do |m|
#	i = Random.rand 10
#	Account.create! id: uid, name: 'test', profit: (1.0 + i/3.0), marketdate: m.tradedate
#end


Sysconfig.delete_all

Sysconfig.create! cfgname: 'marketdate', cfgdate: '2014-07-23'
Sysconfig.create! cfgname: 'batchstart', cfgtime: '23:30:00'
Sysconfig.create! cfgname: 'batchend', cfgtime: '23:59:00'
Sysconfig.create! cfgname: 'account_num_max', cfginteger: 3
Sysconfig.create! cfgname: 'portfolio_num_max', cfginteger: 5
Sysconfig.create! cfgname: 'batchstatus', cfginteger: 0 
Sysconfig.create! cfgname: 'batchname', cfgstring: 'datechange'  
