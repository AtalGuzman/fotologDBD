class Amigo < ActiveRecord::Base
	belongs_to :usuario
   	belongs_to :amigo, :class_name => "Usuario", :foreign_key => "amigo_id" 

   def es_amigo
    Amigo.where('usuario_id = ? and amigo_id = ?', self.amigo_id, self.usuario_id).first
  end

end
