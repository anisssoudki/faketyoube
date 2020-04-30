class CreateVideosTable < ActiveRecord::Migration[6.0]
  def change

      create_table :videos do |t|
        t.string :name
        t.string :link
        t.integer :user_id
      end
  end
end
