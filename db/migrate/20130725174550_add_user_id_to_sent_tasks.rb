class AddUserIdToSentTasks < ActiveRecord::Migration
  def change
  	change_table :sent_tasks do |t|
  		t.references :user, index: true
  	end
  end
end
