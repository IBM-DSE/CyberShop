
class Util
  def self.handle_score_error(input)
    puts
    p 'Backup...'
    if input.is_a?(Customer) && input.name == 'Matt'
      MATT_SCORE
    elsif input.is_a?(Customer) && input.name == 'David'
      DAVID_SCORE
    end
  end
  
  def self.extract(score, cloud=false)
    key = cloud ? 'values' : 'records'
    {
      probability: score[key][0][score['fields'].index('probability')][1],
      prediction: score[key][0][score['fields'].index('prediction')]
    }
  end
end

private

MATT_SCORE = JSON.parse(File.read('db/example/matt_score.json'))

DAVID_SCORE = JSON.parse(File.read('db/example/david_score.json'))