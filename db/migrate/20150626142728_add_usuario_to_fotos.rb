class AddUsuarioToFotos < ActiveRecord::Migration
  def change
    add_reference :fotos, :usuario, index: true
    add_foreign_key :fotos, :usuarios
  end
end
