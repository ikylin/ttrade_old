json.array!(@sysconfigs) do |sysconfig|
  json.extract! sysconfig, :id, :marketdate, :batchstart, :batchend
  json.url sysconfig_url(sysconfig, format: :json)
end
