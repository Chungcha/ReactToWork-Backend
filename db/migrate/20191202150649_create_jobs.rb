class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :description
      t.string :link
      t.string :position
      t.string :zipCode
      t.string :category
      t.datetime :date
      t.integer :poster_id
      
      t.timestamps
    end
  end
end
