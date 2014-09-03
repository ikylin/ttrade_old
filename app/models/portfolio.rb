class Portfolio < ActiveRecord::Base
	belongs_to	:account
	belongs_to	:quotation
	resourcify
	scope :daydata, ->(marketdate) { where("marketdate == ?", marketdate) }
end
