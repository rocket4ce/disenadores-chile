class AddSlugToPortafolios < ActiveRecord::Migration
  def change
    add_column :portafolios, :slug, :string
  end
end
