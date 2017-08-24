
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
  
  def self.extract(score)
    {
      probability: score['records'][0][score['fields'].index('probability')][1],
      prediction: score['records'][0][score['fields'].index('prediction')]
    }
  end
end

private

MATT_SCORE = JSON.parse(File.read('db/example/matt_score.json'))

DAVID_SCORE = JSON.parse(File.read('db/example/david_score.json'))