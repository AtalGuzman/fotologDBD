json.array!(@comentarios) do |comentario|
  json.extract! comentario, :id, :usuario_id, :foto_id, :TEXTO, :FECHA
  json.url comentario_url(comentario, format: :json)
end
