
class Util
  def self.initialize_score(customer)
    if customer.is_a?(Customer) && customer.name == 'Matt'
      MATT_SCORE
    elsif customer.is_a?(Customer) && customer.name == 'David'
      DAVID_SCORE
    end
  end
  
  def self.extract(score)
    key = score.has_key?('values') ? 'values' : 'records'
    {
      probability: score[key][0][score['fields'].index('probability')][1],
      prediction: score[key][0][score['fields'].index('prediction')]
    }
  end
end

private

MATT_SCORE = JSON.parse(File.read('db/example/matt_score.json'))

DAVID_SCORE = JSON.parse(File.read('db/example/david_score.json'))