module Task_Commonality
	extend ActiveSupport::Concern

	included do
		# associations
  	belongs_to :user
  	# validations
  	validates :description, presence: true
  	# callbacks
	end
end