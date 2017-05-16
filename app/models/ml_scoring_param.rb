class MlScoringParam < ApplicationRecord
  has_many :ml_scoring_param_options, dependent: :destroy
  accepts_nested_attributes_for :ml_scoring_param_options, allow_destroy: true
  validates :name, presence: true
  before_save :upcase_name

  def upcase_name
    self.name.upcase!
  end

  def self.import(file)

    csv = CSV.read(file.path, headers: true)

    csv.headers.each do |name|
      param = self.find_or_initialize_by name: name
      csv[name].each do |val|
        param.ml_scoring_param_options.build value: val if val
      end
      param.save
    end

  end
end
