class Score < ActiveRecord::Base
  belongs_to :criterium
  # criterium(force_reload = false)
  # criterium=(associate)
  # build_criterium(attributes = {})
  # create_criterium(attributes = {})
  # create_criterium!(attributes = {})

  belongs_to :option
  # option(force_reload = false)
  # option=(associate)
  # build_option(attributes = {})
  # create_option(attributes = {})
  # create_option!(attributes = {})

  belongs_to :bin
  # bin(force_reload = false)
  # bin=(associate)
  # build_bin(attributes = {})
  # create_bin(attributes = {})
  # create_bin!(attributes = {})

  validates :criterium, :option, presence: true
  validates :amount, presence: true, on: :create
  validates :amount, numericality: { only_integer: true }
end
