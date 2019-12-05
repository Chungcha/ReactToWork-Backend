class CreateSaves < ActiveRecord::Migration[6.0]
  def change
    create_table :saves do |t|
      t.integer :saver_id
      t.integer :job_id

      t.timestamps
    end
  end
end
