class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, :minimum => 10, :allow_blank => false
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :email, :uniqueness => true
end
