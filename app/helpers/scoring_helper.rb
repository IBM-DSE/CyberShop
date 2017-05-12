module ScoringHelper
  def type in_type
    {
      'string' => 'text',
      'integer' => 'number'
    }[in_type]
  end
end
