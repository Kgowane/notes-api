class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :note
      t.string :created_by
      
      t.timestamps
    end
  end
end
