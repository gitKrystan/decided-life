class Matrix < ActiveRecord::Base
  has_many :criteria
  # criteria(force_reload = false)
  # criteria<<(object, ...)
  # criteria.delete(object, ...)
  # criteria.destroy(object, ...)
  # criteria=(objects)
  # criteria_singular_ids
  # criteria_singular_ids=(ids)
  # criteria.clear
  # criteria.empty?
  # criteria.size
  # criteria.find(...)
  # criteria.where(...)
  # criteria.exists?(...)
  # criteria.build(attributes = {}, ...)
  # criteria.create(attributes = {})
  # criteria.create!(attributes = {})

  has_many :options
  # options(force_reload = false)
  # options<<(object, ...)
  # options.delete(object, ...)
  # options.destroy(object, ...)
  # options=(objects)
  # options_singular_ids
  # options_singular_ids=(ids)
  # options.clear
  # options.empty?
  # options.size
  # options.find(...)
  # options.where(...)
  # options.exists?(...)
  # options.build(attributes = {}, ...)
  # options.create(attributes = {})
  # options.create!(attributes = {})

  validates :name, presence: true
end
