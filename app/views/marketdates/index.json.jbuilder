json.array!(@marketdates) do |marketdate|
  json.extract! marketdate, :id, :tradedate, :daystate
  json.url marketdate_url(marketdate, format: :json)
end
