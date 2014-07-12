class AddChildLevelToJourney < ActiveRecord::Migration
  def up
  	add_column :travel_journeys,:child_level,:string
  end
  def down
  	remove_column :travel_journeys,:child_level,:string
  end
end
