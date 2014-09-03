json.array!(@odsreserves) do |odsreserf|
  json.extract! odsreserf, :id, :code, :name, :plate, :open, :high, :low, :close, :dprofit, :duration
  json.url odsreserf_url(odsreserf, format: :json)
end
