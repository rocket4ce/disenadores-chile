class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
    self.pago ||= false
  end
  has_many :comentarios, :through => :portafolios, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_one :perfil, dependent: :destroy
  has_many :portafolios, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {
     minimum: 3,
     maximum: 20,
     too_short: "debe tener minimo %{count} letras",
     too_long: "nombre de usuario demaciado largo, max %{count} letras"
   }
  validates :name, format: { with: /\A[0-9a-zA-Z]+\z/,
     message: "solo numeros y letras" }

  validates :fechapago, presence: { if: 'pago.present?', message: "necesitas introducir fecha de pago" }


  acts_as_follower
  acts_as_followable

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
