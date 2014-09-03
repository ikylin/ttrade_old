class Account < ActiveRecord::Base
	has_attached_file :avatar, 
	:styles => { 
		:medium => {
			:processors =>[:watermark], 
			:geometry => '800x500',
			:watermark_path => "#{Rails.root}/public/1.jpg",
			:percentage => '20%',
			:position => 'Center'
		}
	}, 
	:path => ":rails_root/public/downloads/:id.:extension",
	:url => "/downloads/:id.:extension",
	:default_url => "/downloads/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	has_many	:portfolios
	#has_many	:follows
	#has_many	:analysts, through: :follows
	belongs_to :analyst
	belongs_to	:user
	resourcify
end
