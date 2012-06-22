class Quadrant < ActiveRecord::Base
  attr_accessible :character_data_id, :density

  belongs_to :character_data
end
