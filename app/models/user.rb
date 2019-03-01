class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,  
         :omniauthable, :omniauth_providers =>[:facebook, :google_oauth2]
  has_many :orders       

 def self.from_omniauth(auth)
      where(email: auth.info.email).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
 end
end