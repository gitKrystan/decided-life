class Bin < ActiveRecord::Base
  belongs_to :criterium
  has_many :scores
end
