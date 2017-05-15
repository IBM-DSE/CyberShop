class MlScoringParam < ApplicationRecord
  has_many :ml_scoring_param_options
  accepts_nested_attributes_for :ml_scoring_param_options, allow_destroy: true
  validates :name, presence: true
  before_save :upcase_name

  def upcase_name
    self.name.upcase!
  end
end
