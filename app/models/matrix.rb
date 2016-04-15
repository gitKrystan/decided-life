Hash.include CoreExtensions::Hash::Attributes::CleanOrEmpty

class Matrix < ActiveRecord::Base
  amoeba do
    enable
    prepend name: 'Copy of '
    include_association :criteria
    include_association :options
  end

  belongs_to :owner, class_name: 'User'
  # owner(force_reload = false)
  # owner=(associate)
  # build_owner(attributes = {})
  # create_owner(attributes = {})
  # create_owner!(attributes = {})
  validates :owner, presence: true

  has_many :criteria, dependent: :destroy, inverse_of: :matrix
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
  accepts_nested_attributes_for :criteria,
                                allow_destroy: true,
                                reject_if: proc { |attributes|
                                  attributes.clean_or_empty?(:criterium)
                                }

  has_many :options, dependent: :destroy, inverse_of: :matrix
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
  accepts_nested_attributes_for :options,
                                allow_destroy: true,
                                reject_if: :all_blank

  validates :name, presence: true, uniqueness: { scope: :owner_id }

  def options_by(options_sort_method, options_sort_direction,
                 options_sort_argument)
    sorted_options = options.sort_by do |option|
      if options_sort_argument
        option.send(options_sort_method, options_sort_argument)
      else
        option.send(options_sort_method)
      end
    end
    return sorted_options.reverse if options_sort_direction == 'desc'
    sorted_options
  end

  def total_criteria_importance
    criteria.reduce(0) { |a, e| a + e.importance }
  end

  def option_ranks
    sorted_options = options_by('total_score', 'desc', nil)
    score_hash = {}
    latest_score = 0
    latest_rank = 0
    sorted_options.each do |option|
      latest_rank += 1 unless option.total_score == latest_score
      latest_score = option.total_score
      score_hash[option.id] = latest_rank
    end
    score_hash
  end

  def winning_options
    winners = []
    option_ranks.each do |option_id, rank|
      winners << Option.find(option_id) if rank == 1
    end
    winners
  end

  def tie?
    winning_options.length > 1
  end

  def winner?
    winning_options.length == 1
  end

  def winner_name
    winning_options.first.name
  end
end
