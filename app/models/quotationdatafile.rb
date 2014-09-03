class Quotationdatafile < ActiveRecord::Base
	has_attached_file :avatar,
  :path => ":rails_root/public/uploads/:class/:basename.:id.:extension",  
  #:path => ":rails_root/public/uploads/:filetype}/:marketdate_:id.:extension",  
  :url => "/uploads/:id.:extension",  
  :default_url => "/uploads/default.txt"

  validates_attachment :avatar, :presence => true,
  :content_type => { :content_type => ["application/vnd.ms-excel", "application/excel", "text/plain"] } ,
  :content_type_mappings => { xls: "text" },
  #:matches => [/xls\Z/],
  :size => { :in => 0..1000.kilobytes }
  #do_not_validate_attachment_file_type :avatar

	resourcify
end
