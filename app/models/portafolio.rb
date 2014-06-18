class Portafolio < ActiveRecord::Base
  belongs_to :user
  has_many :comentarios
  validates :titulo, presence: true
  has_many :adjuntos, :dependent => :destroy
  accepts_nested_attributes_for :adjuntos
  acts_as_liker
  acts_as_likeable
  is_impressionable
  extend FriendlyId
  friendly_id :titulo, use: [:slugged, :finders]
end
