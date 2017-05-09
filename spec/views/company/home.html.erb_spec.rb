require 'rails_helper'

RSpec.describe 'company/home.html.erb', type: :view do
  it 'displays the title' do
    render
    expect(rendered).to match Rails.application.class.parent_name
  end
end
