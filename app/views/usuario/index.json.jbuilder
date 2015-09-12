json.array!(@fotos) do |foto|
  json.extract! foto, :id, :DESCRIPCION, :FECHA, :TITULO
  json.url foto_url(foto, format: :json)
end
