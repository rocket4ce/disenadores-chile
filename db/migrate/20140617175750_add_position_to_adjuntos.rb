class AddPositionToAdjuntos < ActiveRecord::Migration
  def change
    add_column :adjuntos, :position, :integer
  end
end
