json.array!(@quotationdatafiles) do |quotationdatafile|
  json.extract! quotationdatafile, :id, :filetype, :filestatus
  json.url quotationdatafile_url(quotationdatafile, format: :json)
end
