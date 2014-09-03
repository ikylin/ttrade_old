json.array!(@everydaytips) do |everydaytip|
  json.extract! everydaytip, :id, :tip
  json.url everydaytip_url(everydaytip, format: :json)
end
