class Task < ActiveRecord::Base
	# associations
  belongs_to :user
  # validations
  validates :description, presence: true
  # callbacks
end
