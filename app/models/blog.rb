class Blog < ActiveRecord::Base
	belongs_to :user
	include Bootsy::Container
	validates :titulo, presence: true
	validates :cuerpo, presence: true
	extend FriendlyId
  	friendly_id :titulo, use: [:slugged, :finders]
end
