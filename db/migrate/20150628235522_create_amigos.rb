class CreateAmigos < ActiveRecord::Migration
  def change
    create_table :amigos do |t|
      t.integer :usuario_id
      t.integer :amigo_id
      t.date :FECHA_AMISTAD

      t.timestamps null: false
    end
  end
end
