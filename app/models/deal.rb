class Deal < ActiveRecord::Base
  belongs_to :product
  belongs_to :trigger_product, class_name: 'Product'

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  after_initialize :set_defaults

  def set_defaults
    self.special = false if self.special.nil?
  end
  
  def src
    trigger_product ? trigger_product : product
  end
end
