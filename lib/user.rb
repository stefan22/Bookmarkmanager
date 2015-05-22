require 'bcrypt'

<<<<<<< HEAD
  include DataMapper::Resource



  property :id, Serial
  property :email, String
  property :password_token, String
  property :password_token_timestamp, Time
  
  # this will store both the password and the salt
  # It's Text and not String because String holds
  # 50 characters by default
  # and it's not enough for the hash and salt

  property :password_digest, Text


  # when assigned the password, we don't store it directly
  # instead, we generate a password digest, that looks like this:
  # "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"
  # and save it in the database. This digest, provided by bcrypt,
  # has both the password hash and the salt. We save it to the
  # database instead of the plain password for security reasons.

=======
class User

  include DataMapper::Resource

>>>>>>> 15b3a0e8ee794a3e05316a626c06d062982e2800
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
