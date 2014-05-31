class AddOtherDescriptionToTravelJourneys < ActiveRecord::Migration
  def change
    add_column :travel_journeys, :other_description, :text
  end
end
