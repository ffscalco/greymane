class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :omniauthable
end
