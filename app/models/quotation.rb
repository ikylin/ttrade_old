class Quotation < ActiveRecord::Base
	resourcify
	scope :daydata, ->(marketdate) { where("marketdate = ?", marketdate) }
	has_many	:portfolio
	has_many	:reserve
end
