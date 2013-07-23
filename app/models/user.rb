class User < ActiveRecord::Base
	# associations
	# validations
	valid_email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_secure_password
	validates :email, presence: true, format: { with: valid_email }
	validates :password, presence: true, length: { minimum: 5 }
	# call backs
end
