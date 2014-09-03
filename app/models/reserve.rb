class Reserve < ActiveRecord::Base
	include QuotationdatafilesHelper
	belongs_to	:quotation
	belongs_to	:analyst
	resourcify
	scope	:daydata, ->(marketdate) { where("marketdate == ?", marketdate) }
	
	class << self
		def refresh(close)
			unless close <= 0
         profit = (hhv - close)/close
         loss = (close - llv)/close
         plratio = profit / loss
         optadvise = 'buy' unless plratio < 2
         stockstatus = 1
       end
		end
	end
end
