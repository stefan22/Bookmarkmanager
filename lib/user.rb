require 'bcrypt'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String
  property :password_digest, Text
  property :password_token, String
  property :password_token_timestamp, Time


  validates_confirmation_of :password

  # will check if a record with this email exists before trying to create a new one
  # validates_uniqueness_of :email

  property :email, String, unique: true, message: 'This email is already taken'


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end


  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      # return this user
      user
    else
      nil
    end
  end

  def send_recovery_email
    # send email via mailgun

  end
end
