class CreateCharacterData < ActiveRecord::Migration
  def change
    create_table :character_data do |t|
      t.string :character
      t.string :quadrants_quantity

      t.timestamps
    end
    add_index :character_data, :quadrants_quantity
  end
end
