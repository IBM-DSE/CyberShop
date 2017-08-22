class MlScoringParam < ActiveRecord::Base
  has_many :ml_scoring_param_options, dependent: :destroy
  accepts_nested_attributes_for :ml_scoring_param_options, allow_destroy: true
  validates :name, presence: true

  def self.import(file, aliases)

    csv = CSV.read(file.path, headers: true)

    csv.headers.each do |name|
      param = self.find_or_initialize_by name: name
      csv[name].each_with_index do |val, i|
        if i == 0 and aliases == 'on'
          param.alias = val
        else
          param.ml_scoring_param_options.build value: val if val
        end
      end
      param.save
    end

  end
end
