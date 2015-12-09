class User < ActiveRecord::Base
  acts_as_authentic
  validates_presence_of :email, :password, :message => "missing"
  has_one :cart
end
