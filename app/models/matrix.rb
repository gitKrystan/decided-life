class Matrix < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  # owner(force_reload = false)
  # owner=(associate)
  # build_owner(attributes = {})
  # create_owner(attributes = {})
  # create_owner!(attributes = {})
  validates :owner, presence: true

  has_many :criteria, dependent: :destroy
  # criteria(force_reload = false)
  # criteria<<(object, ...)
  # criteria.delete(object, ...)
  # criteria.destroy(object, ...)
  # criteria=(objects)
  # criterium_ids
  # criterium_ids=(ids)
  # criteria.clear
  # criteria.empty?
  # criteria.size
  # criteria.find(...)
  # criteria.where(...)
  # criteria.exists?(...)
  # criteria.build(attributes = {}, ...)
  # criteria.create(attributes = {})
  # criteria.create!(attributes = {})
  accepts_nested_attributes_for :criteria, allow_destroy: true

  has_many :options, dependent: :destroy
  # options(force_reload = false)
  # options<<(object, ...)
  # options.delete(object, ...)
  # options.destroy(object, ...)
  # options=(objects)
  # option_ids
  # option_ids=(ids)
  # options.clear
  # options.empty?
  # options.size
  # options.find(...)
  # options.where(...)
  # options.exists?(...)
  # options.build(attributes = {}, ...)
  # options.create(attributes = {})
  # options.create!(attributes = {})
  accepts_nested_attributes_for :options, allow_destroy: true

  validates :name, presence: true, uniqueness: { scope: :owner_id }
end
