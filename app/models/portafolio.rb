class Portafolio < ActiveRecord::Base
  extend FriendlyId
  friendly_id :titulo, use: [:slugged, :finders]
  belongs_to :user
  validates :titulo, presence: true
end
