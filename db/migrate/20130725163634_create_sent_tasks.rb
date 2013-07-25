class CreateSentTasks < ActiveRecord::Migration
  def change
    create_table :sent_tasks do |t|
      t.text :description
      t.integer :sender_id, index: true

      t.timestamps
    end
  end
end
