class AddFechaGoldToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :fechaGold, :date
  end
end
