class Foto < ActiveRecord::Base
	belongs_to :usuario #Una foto pertenece a un único usuario

	#####Relación foto recibe muchos comentarios###############
	has_many :comentarios
	#has_many :usuarios, through: :comentarios #Una foto tiene muchos usuario a través de los comentarios
	has_many :calificacions
  	has_attached_file :imagen, styles: { medium: '800x600>', thumb: '400x400>', mini:'48x48>' }
	validates_attachment :imagen, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
