class AddGoldToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :GOLD, :boolean
  end
end
