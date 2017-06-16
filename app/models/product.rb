# noinspection ALL
class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand
  has_many :features
  has_one :deal
  has_many :trigger_deals, :class_name => 'Deal', :foreign_key => 'trigger_product_id'
  has_one :deployment
  
  serialize :color_options, Array
  serialize :storage_options, Array
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  attr_accessor :discount_price
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  
  # Check for Machine Learning Model-based special offers 
  def check_special_offer(customer)
    
    # Check for potential deals
    potential_deals = trigger_deals.where(special: true)
    unless potential_deals.empty?
      potential_deal = potential_deals.first
      
      # Find the deployment for the the model of this deal's product
      if potential_deal.product.deployment
        
        # Get the score from the given deployment
        score = potential_deal.product.deployment.get_score customer
        
        # Offer the deal if the probability is greater than 80%
        return potential_deal if score > 0.8
      end
      
    end
  end
  
end
