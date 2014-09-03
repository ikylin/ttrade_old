json.array!(@portfoliologs) do |portfoliolog|
  json.extract! portfoliolog, :id, :opt, :time
  json.url portfoliolog_url(portfoliolog, format: :json)
end
