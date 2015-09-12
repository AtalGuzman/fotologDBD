class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.string :DESCRIPCION
      t.date :FECHA
      t.string :TITULO

      t.timestamps null: false
    end
  end
end
