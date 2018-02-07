RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'app configured', shared_context: :metadata do

  before do
    FactoryBot.create :admin_user
    @category = FactoryBot.create :category, name: 'Smartphones'
    %w(Laptops Desktops).each do |name|
      FactoryBot.create :category, name: name
    end

    @brand = FactoryBot.create :brand, name: 'Apricot'
    %w(Gazillion Smithsong).each do |name|
      FactoryBot.create :brand, name: name
    end
    @nodeal_product = FactoryBot.create :product, name: 'X-Phone', category: @category, brand: @brand

    @product = FactoryBot.create :product, name: 'A-Phone 8', category: @category, brand: @brand
    @deal    = FactoryBot.create :deal, description: 'Get $100 off of this product!', product: @product
  end

  def app_name
    Rails.application.class.parent_name.titleize
  end

  # let(:shared_let) { {'arbitrary' => 'object'} }
  # subject do
  #   'this is the subject'
  # end
end

RSpec.configure do |rspec|
  rspec.include_context 'app configured', include_shared: true
end
