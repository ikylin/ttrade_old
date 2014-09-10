class AboutController < ApplicationController
  include QuotationdatafilesHelper
  def help
    render layout: 'weixinmsg' 
  end
end
