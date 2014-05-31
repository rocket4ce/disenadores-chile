json.array!(@portafolios) do |portafolio|
  json.extract! portafolio, :id, :titulo, :descripcion, :user_id
  json.url portafolio_url(portafolio, format: :json)
end
