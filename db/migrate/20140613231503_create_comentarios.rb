class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.text :comentario
      t.integer :portafolio_id
      t.integer :user_id

      t.timestamps
    end
  end
end
