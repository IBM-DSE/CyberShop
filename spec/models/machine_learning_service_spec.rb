require 'rails_helper'

RSpec.describe MachineLearningService, type: :model do
  it 'fails if username & password are invalid' do
    expect {
      MachineLearningService.create username: 'foo', password: 'bar'
    }.to raise_error RuntimeError, 'Net::HTTPUnauthorized'
  end
end
