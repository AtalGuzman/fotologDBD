ActiveAdmin.register Foto do
	permit_params :DESCRIPCION,:FECHA,:TITULO,:created_at,:updated_at,:imagen_file_name,
				:imagen_content_type,:imagen_file_size,:imagen_updated_at,:usuario_id
	index do
		selectable_column
		column "Título",:TITULO
		column "Descripción",:DESCRIPCION
		column "Creada", :created_at
		column "Imagen" do |foto|
			image_tag foto.imagen.url(:medium)
		end
		actions
	end
end