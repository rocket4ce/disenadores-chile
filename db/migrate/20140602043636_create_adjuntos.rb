class CreateAdjuntos < ActiveRecord::Migration
  def change
    create_table :adjuntos do |t|
      t.integer :portafolio_id
      t.string :imagen
      t.integer :user_id

      t.timestamps
    end
  end
end
