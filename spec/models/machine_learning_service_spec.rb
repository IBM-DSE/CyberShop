require 'rails_helper'

RSpec.describe MachineLearningService, type: :model do
  it 'fails if username & password are invalid' do
    foo_bar = MachineLearningService.create username: 'foo', password: 'bar'
    expect(foo_bar).not_to be_valid
    expect(foo_bar.errors[:username]).to eq(['Authorization failure'])
    expect(foo_bar.errors[:password]).to eq(['Authorization failure'])
  end
end
