class User < ActiveRecord::Base
	# associations
	has_many :tasks, dependent: :destroy
	has_many :sent_tasks, dependent: :destroy
	has_many :notifications, dependent: :destroy
	# validations
	valid_email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_secure_password
	validates :email, presence: true, format: { with: valid_email }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 5 }
	# call backs
	before_create { |user| user.email.downcase! }
end
