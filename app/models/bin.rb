class Bin < ActiveRecord::Base
  belongs_to :criterium
  has_many :scores, dependent: :destroy

  def select_description
    score_description = ": #{description}" unless description.empty?
    "#{score}#{score_description}"
  end
end
