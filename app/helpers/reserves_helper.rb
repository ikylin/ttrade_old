module ReservesHelper
	def reserve_update_hhv_llv(reserve)
    unless reserve.quotation.nil? || reserve.hhv.nil? || reserve.llv.nil? || reserve.quotation.close <= 0
   	  reserve.profit = (reserve.hhv - reserve.quotation.close)/reserve.quotation.close
      reserve.loss = (reserve.quotation.close - reserve.llv)/reserve.quotation.close
      reserve.plratio = reserve.profit / reserve.loss
			if reserve.plratio >= 2
				reserve.optadvise = 'buy'
			else 
				if reserve.optadvise == 'buy'
      		reserve.optadvise = ''
				end
			end
      reserve.stockstatus = 1
      reserve.save
    end
  end
end
