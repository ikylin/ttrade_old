json.array!(@syslogs) do |syslog|
  json.extract! syslog, :id, :role, :time, :opt, :curstate
  json.url syslog_url(syslog, format: :json)
end
