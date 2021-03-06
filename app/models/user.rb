class User < ApplicationRecord
  scope :confirmed, -> {where('confirmed_at IS NOT NULL')}
  has_secure_password
  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, :minimum => 10, :allow_blank => false
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :email, :uniqueness => true


  before_create :generate_token
  
  def self.authenticate(email,password)
    confirmed.find_by_email(email).try(:authenticate, password)
  end


  def generate_token
    self.confirmation_token =  SecureRandom.urlsafe_base64
  end

  def confirm!
    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    self.confirmed_at.present?
  end

end
