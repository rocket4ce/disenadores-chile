class Adjunto < ActiveRecord::Base
mount_uploader :imagen, AdjuntosUploader
	belongs_to :portafolio
	validates :imagen, presence: true
end
