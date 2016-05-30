class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :omniauthable
end
