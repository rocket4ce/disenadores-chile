class CreatePerfiles < ActiveRecord::Migration
  def change
    create_table :perfiles do |t|
      t.integer :user_id
      t.string :nombre
      t.string :apellidos
      t.string :ocupacion
      t.string :compania
      t.string :web
      t.string :tw
      t.string :face
      t.string :dribble
      t.string :linkedin
      t.string :vimeo
      t.string :flickr
      t.string :youtube
      t.string :pinterest
      t.string :tumblr
      t.string :google
      t.text :bio

      t.timestamps
    end
  end
end
