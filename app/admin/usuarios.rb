ActiveAdmin.register Usuario do
	permit_params :NOMBRE_US,:NOMBRE_PHOTOLOG,:CORREO_US
	config.sort_order = "NOMBRE_PHOTOLOG_asc"
	index  do |usuario|
		selectable_column
		column "Nombre", :NOMBRE_US
		column "Apellido", :APELLIDO_US
		column "Nickname" do |usuario|
			link_to usuario.NOMBRE_PHOTOLOG, usuario_path(usuario)
		end
		column "Correo", :email
		column "Creado en", :created_at
		column do 
		end
	end
end