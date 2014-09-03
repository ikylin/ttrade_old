json.array!(@reserves) do |reserve|
  json.extract! reserve, :id, :stockstatus, :hhv, :llv, :hdate, :ldata, :profit, :loss, :plratio, :note
  json.url reserve_url(reserve, format: :json)
end
