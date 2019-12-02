class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.datetime :date_posted
      t.string :link
      t.string :content
      t.string :city

      t.timestamps
    end
  end
end
