json.array!(@accounts) do |account|
  json.extract! account, :id, :setdate, :name, :tradenum, :winratio, :plratio, :profitmax, :lossmax
  json.url account_url(account, format: :json)
end
