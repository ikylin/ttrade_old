json.array!(@weixinlogs) do |weixinlog|
  json.extract! weixinlog, :id, :time, :content
  json.url weixinlog_url(weixinlog, format: :json)
end
