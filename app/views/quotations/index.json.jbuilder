json.array!(@quotations) do |quotation|
  json.extract! quotation, :id, :code, :name, :plate, :open, :high, :low, :close
  json.url quotation_url(quotation, format: :json)
end
