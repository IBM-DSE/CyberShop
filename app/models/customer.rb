class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable #, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, length: { maximum: 50 }
  has_many :messages

  def conversation_context
    {
      name:     self.name,
      interest: self.interest
    }
  end
  
  def get_twitter_data
    [
      'This menu is hard to read and I could really use some assistance'
    ]
  end
  
end
