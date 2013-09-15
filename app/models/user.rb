class User < ActiveRecord::Base
 
  devise :database_authenticatable, :registerable, :omniauthable,
         :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]
 
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name
  validates :name, presence: true
  has_many :assets, dependent: :destroy
  has_many :activities

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
      end
    end
  end
end
