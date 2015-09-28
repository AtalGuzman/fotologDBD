class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.references :usuario, index: true
      t.references :foto, index: true
      t.text :TEXTO
      t.date :FECHA

      t.timestamps null: false
    end
    add_foreign_key :comentarios, :usuarios
    add_foreign_key :comentarios, :fotos
  end
end
