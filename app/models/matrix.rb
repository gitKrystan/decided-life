Hash.include CoreExtensions::Hash::Attributes::CleanOrEmpty

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
  accepts_nested_attributes_for :criteria,
                                allow_destroy: true,
                                reject_if: proc { |attributes|
                                  attributes.clean_or_empty?(:criterium)
                                }

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

  def options_by_score
    options_by('total_score', 'desc', nil)
  end

  def total_criteria_importance
    criteria.reduce(0) { |a, e| a + e.importance }
  end

  def winning_option
    options_by_score.first
  end
end
