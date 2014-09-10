#encoding:utf-8
require 'gruff'

module QuotationdatafilesHelper


#	1. input today quotation
	#	1.1 update profit
# 2. input today reserver
# 3. modify today reserver
# 4. select portfolio by pretradedate data
# 5. date change
# 6. select portfolio by tradedate data
	def sysmarketdate
		return Sysconfig.find_by(cfgname: 'marketdate').cfgdate
	end
	
	def config_get cfgname
		case cfgname
		when 'batchname'
			return Sysconfig.find_by(cfgname: 'batchname').cfgstring	
		when 'batchstatus'
			return Sysconfig.find_by(cfgname: 'batchstatus').cfginteger	
		else

		end
	end
	
	def config_set cfgname, cfgvalue
		case cfgname
		when 'batchname'
			return Sysconfig.find_by(cfgname: 'batchname').update(cfgstring: cfgvalue)
		when 'batchstatus'
			return Sysconfig.find_by(cfgname: 'batchstatus').update(cfginteger: cfgvalue)
		else

		end
	end

	def tradedate
		m = Marketdate.where("daystate = ''").order(tradedate: :asc).first
		return m.tradedate unless m.nil?
	end

	def pretradedate
		m = Marketdate.where("daystate = 'past'").order(tradedate: :asc).last
		return m.tradedate unless m.nil?
	end

	def posttradedate
		m = Marketdate.where("daystate = ''").order(tradedate: :asc).limit(2).last
		return m.tradedate unless m.nil?
	end

	def marketdatechange
		m = Marketdate.where("daystate = ''").order(tradedate: :asc).first
		m.update!(daystate: 'past')
		Sysconfig.find_by(cfgname: 'marketdate').update!(cfgdate: tradedate)
	end
	
	def sysaccount_num_max
		return Sysconfig.find_by(cfgname: 'account_num_max').cfginteger
	end

	def sysportfolio_num_max
		return Sysconfig.find_by(cfgname: 'portfolio_num_max').cfginteger
	end

	
	def marketdatefileprocess path
		File.open(@quotationdatafile.avatar.path, 'r') do |file|
      file.each_line do |line|
        cols = line.force_encoding('gb2312').split("\r\n")
        logger.info cols
        m = Marketdate.new
        m.tradedate = cols[0].strip

        m.save
      end
    end
	end

	# before date 
	# 20140723 all data
	# 20140724 tradedate 
	# after date
	# 20140724 all data
	# 20140725 tradedate
	def quotationfileprocess path 
    File.open(path, 'r') do |file|
      file.each_line do |line|
        cols = line.force_encoding('gb2312').split("\t")
        if /\d{6}/ =~ cols[0][2..7].strip
					#added new quotation
          q = Quotation.new
          q.marketdate = tradedate
 
          q.code = cols[0][2..7].strip
          q.name = cols[1].strip
          q.cqstatus = 'chuquan' unless q.name[0..1] != 'XD'
          q.plate = cols[18].strip

          if cols[11].strip == '--'
            preq = Quotation.find_by(marketdate: pretradedate, code: q.code) 
            q.open = 0 
            q.high = 0 
            q.low = 0 
            q.close = cols[14].strip
					  q.dprofit = 0 

            q.tpstatus = 'tingpai' 
          else
            q.open = cols[11].strip
            q.high = cols[12].strip
            q.low = cols[13].strip
            q.close = cols[3].strip

					  q.dprofit = cols[2].strip
          end
					
          q.save
        end
      end
    end
	end	
		
	def updateReserves
		Reserve.where(marketdate: pretradedate, stockstatus: 1).each do |reserve|
			r = reserve.dup
			r.marketdate = tradedate
			
			r.quotation = Quotation.where(marketdate: tradedate, code:reserve.quotation.code).first
			
			unless r.hhv.nil? || r.quotation.nil? || r.hhv > r.quotation.close
				r.hhv = r.quotation.close 
				r.hdate = tradedate
				r.optadvise = 'sell'
				r.stockstatus = '2'
        r.releasedate = tradedate
			end
			unless r.llv.nil? || r.quotation.nil? || r.llv < r.quotation.close
				r.llv = r.quotation.close 
				r.ldate = tradedate
				r.optadvise = 'sell'
				r.stockstatus = '0'
        r.releasedate = tradedate
			end
			
			r.profit = (r.hhv - r.quotation.close)/r.quotation.close unless r.hhv.nil? || r.quotation.nil? || r.quotation.close.nil? || r.quotation.close == 0
			r.loss = (r.quotation.close - r.llv)/r.quotation.close unless r.llv.nil? || r.quotation.nil? || r.quotation.close.nil? || r.quotation.close == 0
			unless r.profit.nil? || r.loss.nil?
				if r.profit > 0 and r.loss > 0
					r.plratio = r.profit/r.loss
          r.winpercentage = 1/(1+r.plratio)
          if r.plratio > 2
            r.optadvise = 'buy'
            r.catchplratio = r.plratio
          elsif r.optadvise = 'buy'
            r.optadvise = '' 
          end
				else
					r.plratio = 0
				end
			end
			
			r.save!	unless r.quotation.nil?
		end
	end
		
	def updatePortfolios
		Portfolio.where(marketdate: pretradedate).each do |portfolio|
			next unless portfolio.sellprice.nil?

			p = portfolio.dup 

			p.marketdate = tradedate
			
			p.quotation = Quotation.where(marketdate: tradedate, code:portfolio.quotation.code).first
			
			case p.option 
			when 'buy' #execute buy option			
				p.buyprice = p.quotation.open
				p.buydate = tradedate
				p.profit = 0
				p.volum = 1 / sysportfolio_num_max
				p.option = 'hold'
			when 'hold'	
				#p.profit = (p.quotation.close - p.buyprice)/p.buyprice
				p.profit += p.quotation.dprofit
			when 'sell' #execute sell option
				#p.profit = (p.quotation.open - p.buyprice)/p.buyprice
				p.profit += p.quotation.dprofit
				p.sellprice = p.quotation.open
				p.selldate = tradedate
				if p.account.preprofit.nil? 
					p.account.preprofit = 0
				end
				p.account.preprofit += p.profit / sysportfolio_num_max
				if p.account.pretradenum.nil? 
					p.account.pretradenum = 0
				end
				p.account.pretradenum += 1
				if p.account.prewincount.nil? 
					p.account.prewincount = 0
				end
				if p.account.prelosscount.nil? 
					p.account.prelosscount = 0
				end
				if p.profit > 0
					p.account.prewincount += 1	
				else
					p.account.prelosscount += 1	
				end
				
			else
					
			end
			p.duration += 1 # duration init with 0
			
			p.account.save!			
			p.save!
		end
	end
	
	def updateAccounts
		Account.all.each do |account|	
		
			account.tradenum = account.pretradenum
			account.profit = account.preprofit
			account.wincount = account.prewincount
			account.losscount = account.prelosscount	

			Portfolio.where("account_id = ? and marketdate = ? and option = 'hold'", account.id, tradedate).each do |p|
				account.profit += p.profit/sysportfolio_num_max	
				account.tradenum += 1
				if p.profit > 0
					account.wincount += 1	
				else
					account.losscount += 1
				end
			end
			account.winratio = account.wincount/account.tradenum unless account.tradenum == 0 or account.wincount.nil? or account.wincount < 1 or account.losscount.nil? or account.losscount < 1
			if account.profitmax.nil?
				account.profitmax = 0
			end	
			if account.lossmax.nil?
				account.lossmax = 0
			end	
			account.profitmax = account.profit unless account.profitmax.nil? or account.profit.nil? or account.profitmax > account.profit
			account.lossmax = account.profit unless account.lossmax.nil? or account.profit.nil? or account.lossmax < account.profit
			account.plratio = account.profit/account.lossmax unless account.profitmax.nil? || account.lossmax.nil? || account.lossmax == 0
			if account.duration.nil?
				account.duration = 0
			end	
			account.duration += 1 #duration init with 0
			
			account.marketdate = tradedate
			
			account.save!
		end
	end

  def reservefileprocess path 
    File.open(path, 'r') do |file|
      file.each_line do |line|
        cols = line.force_encoding('gb2312').split("\t")
        if /\d{6}/ =~ cols[0][2..7].strip
          q = Quotation.find_or_initialize_by(code: cols[0][2..7].strip, marketdate: tradedate)
          q.marketdate = tradedate
 
          q.code = cols[0][2..7].strip
          q.name = cols[1].strip
					unless q.name.include? "ST"
            q.plate = cols[18].strip

            q.open = cols[11].strip
            q.high = cols[12].strip
            q.low = cols[13].strip
            q.close = cols[3].strip
            q.dprofit = cols[2].strip
            
            prer = Reserve.where(marketdate: tradedate, quotation_id: q.id).first
            #preq = Quotation.find_by(marketdate: pretradedate, code: q.code)
            odsr = Odsreserf.find_by(code: q.code)
           
            if odsr.nil? 
              Odsreserf.create!(code: q.code, name: q.name, plate: q.plate, open: q.open, high: q.high, low: q.low, close: q.close, dprofit: q.dprofit, duration: 1)
              if prer.nil?
                r = q.reserve.build(marketdate: tradedate, catchdate: tradedate, duration: 0, analyst_id: current_user.analyst.id )

                r.save!
              #else
              #	r = prer.dup
              #	q.reserve << r
              end
            else
              odsr.duration = 1
              odsr.save!
            end

            q.save!
					end
        end
      end
    end
	end	

  def odsreservefileprocess path 

    Odsreserf.delete_all

    File.open(path, 'r') do |file|
      file.each_line do |line|
        cols = line.force_encoding('gb2312').split("\t")
        if /\d{6}/ =~ cols[0][2..7].strip
					unless cols[1].strip.include? "ST"
           Odsreserf.create!(code: cols[0][2..7].strip, name: cols[1].strip, plate: cols[18].strip, open: cols[11].strip, high: cols[12].strip, low: cols[13].strip, close: cols[3].strip, dprofit: cols[2].strip, duration: 1)
          end
        end
      end
    end
	end	

	# data 	
	def doadvise
		#Reserve.daydata(sysmarketdate).where("optadvise == 'sell'").each do |r|
		Analyst.all.each do |analyst|
			analyst.reserve.daydata(sysmarketdate).each do |r|
			#analyst.reserve.daydata(sysmarketdate).where("optadvise == 'sell'").each do |r|
        r.duration += 1 unless r.stockstatus != '1'
        r.save!
        unless r.optadvise != 'sell'
          #Portfolio.daydata(tradedate).each do |p|
          analyst.accounts.each do |account|
            account.portfolios.daydata(tradedate).each do |p|
              if p.quotation.code == r.quotation.code
                p.option = r.optadvise 
                p.save!
              end
            end
          end
				end
			end
		end
	end

  def dataclean
    dm = Sysconfig.find_by(cfgname: 'durationmax').cfginteger

    Odsreserf.where("duration > ?", dm).delete_all

    Odsreserf.update_all("duration = duration + 1")
  end

  def cleandatatotoday
    Quotation.where("marketdate >= ?", tradedate).delete_all
    Reserve.where("marketdate >= ?", tradedate).delete_all

    Sysconfig.find_by(cfgname: 'batchname').update!(cfgstring: 'datechange')
  end
	
	def guanzhu openid
    #logger.info "guanzhu >>>>>>>>>>>>>>" + openid
    u = User.find_by(openid: openid)
    if u.nil?
      attributes = {openid: openid, weixinstatus: 1, guanzhudate: tradedate, email: "#{openid}@weixin.com", password: openid[1..8]}
      #attributes = {openid: '123'}
      User.create!(attributes)	
      welcome_message
    else
      u.update(weixinstatus: 1, quxiaoguanzhudate: '')
      welcome_again_message 
    end
	end

  def usercheck openid
    #logger.info "guanzhu >>>>>>>>>>>>>>" + openid
    u = User.find_by(openid: openid)
    if u.nil?
      attributes = {openid: openid, weixinstatus: 1, guanzhudate: tradedate, email: "#{openid}@weixin.com", password: openid[1..8]}
      User.create!(attributes)	
    else
      if u.weixinstatus == 0
        u.update(weixinstatus: 1, quxiaoguanzhudate: '')
        welcome_again_message 
      end
    end
	end


  def welcome_again_message 
    "朋友，欢迎回到三元量化投资模型。\n"
  end
  def welcome_message
    resumeinfo
  end

  def quxiaoguanzhu openid
    logger.info "quxiao guanzhu >>>>>>>>>>>>>>" + openid
    User.find_by(openid: openid).update(weixinstatus: 0, quxiaoguanzhudate: tradedate)
  end 
	
	def gensui
		u = User.find_by(openid: '123')
		unless u.nil?
			a = u.accounts.where(name: 'wenjian')
			unless a.nil?
				analyst = Analyst.find_by(name: 'sys')	
				unless analyst.nil?
					analyst.accounts << a	
					analyst.save!
				end
			end
		end
	end
	
	def createAccount
		u = User.find_by(openid: '123')
		unless u.nil?
			return if u.accounts.size == sysaccount_num_max
		  u.accounts.create(name: 'wenjian')
		end
	end
	
	def jiangu
		u = User.find_by(openid: '123')
		a = u.accounts.find_by(name: 'wenjian')
		unless u.nil? || a.nil? || a.portfolios.where("option <> 'sell'").count >= sysportfolio_num_max
		
			rarr = []
			#Reserve.daydata(tradedate).where(optadvise: 'buy').each do |r|
			a.analyst.reserves.daydata(tradedate).where(optadvise: 'buy').each do |r|
				rarr.push r.quotation.code	
			end
			parr = []
			Portfolio.daydata(tradedate).where("option <> 'sell' and account_id = ?", a.id).each do |p|
				parr.push p.quotation.code
			end
			rarr -= parr
			code = rarr[Random.rand(rarr.length)] unless rarr.length == 0
			q = Quotation.find_by("code = ? and marketdate = ?", code, tradedate)	unless code.nil? 
			p = q.portfolio.build unless q.nil?
			unless p.nil?
				p.marketdate = tradedate
				p.volum = 1 / sysportfolio_num_max	
				p.duration = 0
				p.option = 'buy'
				p.save!
				a.portfolios << p
				a.save!
				u.save!
			end

		end
	end

  def allportfolios
      if Sysconfig.find_by(cfgname: 'batchname').cfgstring != 'datechange' 
        @reserves = Reserve.where(marketdate: tradedate, optadvise: 'buy').order(plratio: :desc)
      else 
        @reserves = Reserve.where(marketdate: pretradedate, optadvise: 'buy').order(plratio: :desc)
      end

			i = 1	
      @allportfolios = "【#{tradedate}】 \n序号 编码 名称 盈亏比 收益率 当前价 止盈 止损 板块\n" 
      @reserves.each do |r|
        @allportfolios = @allportfolios + "(#{i}). " 
        @allportfolios = @allportfolios + r.quotation.code + ' ' 
        @allportfolios = @allportfolios + r.quotation.name + ' ' 
        @allportfolios = @allportfolios + format('%0.1f', r.plratio).to_s + '倍 ' 
        @allportfolios = @allportfolios + format('%0.1f', (100 * r.profit)).to_s + '% '
        @allportfolios = @allportfolios + format('%0.2f', r.quotation.close).to_s + ' ' 
        @allportfolios = @allportfolios + format('%0.2f', r.hhv).to_s + ' ' 
        @allportfolios = @allportfolios + format('%0.2f', r.llv).to_s + ' ' 
        @allportfolios = @allportfolios + r.quotation.plate + "\n"

				i = i + 1
      end
      logger.info @allportfolios
      @allportfolios

  end
	
	def shouyi
		u = User.find_by(openid: '123')
		a = u.accounts.find_by(name: 'wenjian')
		unless u.nil? || a.nil?
			g = Gruff::Line.new(800)
			g.title = 'shouyi'		
			#g.labels = { 0 => '5/6', 1 => '5/15', 2 => '5/24', 3 => '5/30', 4 => '6/4', 5 => '6/12', 6 => '6/21', 7 => '6/28' }
			keys = []
			values = []
			ms = Account.where("marketdate <= ?", tradedate).order(marketdate: :desc).limit(8).pluck(:marketdate)
			ms.reverse!.each_index do |i|
				keys << i
				values << ms[i].strftime("%m-%d")
			end
			g.labels = Hash[*keys.zip(values).flatten]
			logger.info g.labels.inspect

			g.data :test, Account.order(:marketdate).limit(8).pluck(:profit)
			#g.data :Arthur, [5, 10, 13, 11, 6, 16, 22, 32]
			#g.write("/downloads/png/" + tradedate.strftime("%Y-%m-%d") + "_" + a.id.to_s + ".png")
			#g.write(a.avatar.path)
			g.write("#{Rails.root}/public/downloads/1.png")
			a.update(avatar: File.open("#{Rails.root}/public/downloads/1.png"))
		end
	end		

	def valid_attributes(attributes={})
    { name: "usertest",
      email: generate_unique_email,
      password: '12345678',
      password_confirmation: '12345678' }.update(attributes)
  end	

	def generate_unique_email
    @@email_count ||= 0
    @@email_count += 1
    "test#{@@email_count}@example.com"
  end

  def resumeinfo
    resumeinfo = "本模型认为交易盈利的三元素包括交易胜率、交易盈亏比及交易笔数，其中以选股模型保证交易胜率、以盈亏分析系统保证盈亏比率，依托量化分析在胜率及盈亏比上确保每笔交易都能有明确的进出场操作点，而最终的盈利往往是由时间及市场行情共同作用产生的。\n跟随本模型来进行交易将会培养投资者科学的可持续盈利方式，良好的操作习惯以便于从万千散户中脱颖而出，取得良好的投资收益。"
    resumeinfo
  end

  def everydaytip
    n = Everydaytip.count
    Everydaytip.find_by(id: rand(n) + 1).tip
  end

  def helpinfo
    helpinfo = "输入数字 1 【简介】查看模型介绍。\n"
    helpinfo = helpinfo + "输入数字 2 【心得】获得每日一帖。\n"
    helpinfo = helpinfo + "输入数字 3 【组合】可以获得当前的股票组合信息。\n"
    helpinfo = helpinfo + "输入数字 4 【推广】通过二维码把我们介绍给您的朋友。\n"
    helpinfo
  end


  def qrcodegen
    #Sysconfig.find_by(cfgname: 'qrcode').imgfile.path(:thumb)
    'http://115.29.186.47/system/sysconfigs/imgfiles/000/000/031/thumb/qrcode_for_gh_dcd284e0cb4a_1280.jpg?1409886793'
  end

  def qrcode_url size='thumb'
    Sysconfig.find_by(cfgname: 'qrcode').imgfile.url(size)
  end

end
