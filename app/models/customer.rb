class Customer < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  has_many :messages

  # Returns the hash digest of the given string.
  # def Customer.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #            BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end
  
end
