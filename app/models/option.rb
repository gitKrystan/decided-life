class Option < ActiveRecord::Base
  belongs_to :matrix
  # matrix(force_reload = false)
  # matrix=(associate)
  # build_matrix(attributes = {})
  # create_matrix(attributes = {})
  # create_matrix!(attributes = {})
  validates :matrix, presence: true

  has_many :scores
  # scores(force_reload = false)
  # scores<<(object, ...)
  # scores.delete(object, ...)
  # scores.destroy(object, ...)
  # scores=(objects)
  # score_ids
  # score_ids=(ids)
  # scores.clear
  # scores.empty?
  # scores.size
  # scores.find(...)
  # scores.where(...)
  # scores.exists?(...)
  # scores.build(attributes = {}, ...)
  # scores.create(attributes = {})
  # scores.create!(attributes = {})
  accepts_nested_attributes_for :scores

  has_many :criteria, through: :scores
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

  validates :name, presence: true, uniqueness: { scope: :matrix_id }
end
