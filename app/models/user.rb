class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  # before_action :authenticate_user!
  # user_signed_in?
  # current_user
  # user_session

  has_many :matrices, dependent: :destroy
  # matrices(force_reload = false)
  # matrices<<(object, ...)
  # matrices.delete(object, ...)
  # matrices.destroy(object, ...)
  # matrices=(objects)
  # matrices_singular_ids
  # matrices_singular_ids=(ids)
  # matrices.clear
  # matrices.empty?
  # matrices.size
  # matrices.find(...)
  # matrices.where(...)
  # matrices.exists?(...)
  # matrices.build(attributes = {}, ...)
  # matrices.create(attributes = {})
  # matrices.create!(attributes = {})

  validates :name, presence: true
end
