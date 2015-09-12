ActiveAdmin.register Comentario do
	permit_params :usuario_id,:foto_id,:TEXTO,:FECHA,:created_at,:updated_at
	index do 
		selectable_column
		column "Autor comentario" do |comentario|
			link_to comentario.usuario.NOMBRE_PHOTOLOG, usuario_path(comentario.usuario)
		end
		column "Foto comentada" do |comentario|
			link_to comentario.foto.TITULO, foto_path(comentario.foto)
		end
		column :TEXTO
		column :FECHA
		column "Creado en",:created_at
		actions
	end
end