class CreateCalificacions < ActiveRecord::Migration
  def change
    create_table :calificacions do |t|
      t.references :usuario, index: true
      t.references :foto, index: true
      t.integer :nota

      t.timestamps null: false
    end
    add_foreign_key :calificacions, :usuarios
    add_foreign_key :calificacions, :fotos
  end
end
