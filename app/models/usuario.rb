class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	has_many :fotos	#Un usuario tiene muchas fotos

	has_many :comentarios #un usuario hace muchos comentarios

	has_many :calificacions
	#Se agregan las relaciones, de modo que estás sean en ambas direcciones, es decir, desde un 
	#usuario-a a un usuario-b
	has_many :amigos, :foreign_key => "usuario_id", :dependent => :destroy	
	has_many :es_amigo, :class_name => "Amigo", :foreign_key => "amigo_id", :dependent => :destroy

	def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    	where("NOMBRE_PHOTOLOG like ?", "%#{query}%") 
  	end

end
