class Portafolio < ActiveRecord::Base
	belongs_to :user
	validates :titulo, uniqueness: true
	validates :titulo, :descripcion, presence: true
	validates :descripcion, length: {
     minimum: 10,
     maximum: 2000,
     too_short: "debe tener minimo %{count} caracteres",
     too_long: "nombre de usuario demaciado largo, max %{count} caracteres"
   }
  extend FriendlyId
  friendly_id :titulo, use: :slugged
end
