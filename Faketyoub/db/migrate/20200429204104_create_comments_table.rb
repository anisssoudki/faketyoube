class CreateCommentsTable < ActiveRecord::Migration[6.0]
  def change
    

      create_table :comments do |t|
        t.string  :content
        t.date    :date 
        t.integer :video_id
        t.integer :user_id
      end



  end
end
