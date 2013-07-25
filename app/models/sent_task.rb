class SentTask < ActiveRecord::Base
	include Task_Commonality

	validates :sender_id, presence: true
end
