json.array!(@calificacions) do |calificacion|
  json.extract! calificacion, :id, :usuario_id, :foto_id, :nota
  json.url calificacion_url(calificacion, format: :json)
end
