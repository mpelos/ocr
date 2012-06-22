class CreateQuadrants < ActiveRecord::Migration
  def change
    create_table :quadrants do |t|
      t.integer :character_data_id
      t.float :density

      t.timestamps
    end
  end
end
