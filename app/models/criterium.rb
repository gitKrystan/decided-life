class Criterium < ActiveRecord::Base
  after_initialize :generate_bins

  belongs_to :matrix
  # matrix(force_reload = false)
  # matrix=(associate)
  # build_matrix(attributes = {})
  # create_matrix(attributes = {})
  # create_matrix!(attributes = {})
  validates :matrix, presence: true

  has_many :bins, dependent: :destroy
  # bins(force_reload = false)
  # bins<<(object, ...)
  # bins.delete(object, ...)
  # bins.destroy(object, ...)
  # bins=(objects)
  # bin_ids
  # bin_ids=(ids)
  # bins.clear
  # bins.empty?
  # bins.size
  # bins.find(...)
  # bins.where(...)
  # bins.exists?(...)
  # bins.build(attributes = {}, ...)
  # bins.create(attributes = {})
  # bins.create!(attributes = {})
  accepts_nested_attributes_for :bins,
                                allow_destroy: true

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

  has_many :options, through: :scores
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

  validates :name, presence: true, uniqueness: { scope: :matrix_id }

  def weight
    importance.to_f / matrix.total_criteria_importance * 100
  end

  private

  def generate_bins
    if bins.empty?
      default_bins = { 0 => 'poor', 1 => 'pretty good', 2 => 'really good',
                       3 => 'better', 4 => 'even better', 5 => 'best' }
      default_bins.each do |score, description|
        bins.new(score: score, description: description)
      end
    end
  end
end
