json.array!(@portfolios) do |portfolio|
  json.extract! portfolio, :id, :buydate, :buyprice, :profit, :volum, :option
  json.url portfolio_url(portfolio, format: :json)
end
