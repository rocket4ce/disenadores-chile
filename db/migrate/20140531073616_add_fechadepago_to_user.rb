class AddFechadepagoToUser < ActiveRecord::Migration
  def change
    add_column :users, :fechapago, :date
  end
end
