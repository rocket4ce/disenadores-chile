class AddPagoToUser < ActiveRecord::Migration
  def change
    add_column :users, :pago, :boolean
  end
end
