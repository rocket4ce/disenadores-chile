class Comentario < ActiveRecord::Base
	belongs_to :portafolio
	belongs_to :user
end
