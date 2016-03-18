class Matrix < ActiveRecord::Base
  validates :name, presence: true
end
