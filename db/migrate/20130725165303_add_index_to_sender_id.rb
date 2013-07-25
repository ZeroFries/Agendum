class AddIndexToSenderId < ActiveRecord::Migration
  def change
  	add_index :sent_tasks, :sender_id
  end
end
