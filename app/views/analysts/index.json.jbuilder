json.array!(@analysts) do |analyst|
  json.extract! analyst, :id, :name, :lvl, :fan
  json.url analyst_url(analyst, format: :json)
end
