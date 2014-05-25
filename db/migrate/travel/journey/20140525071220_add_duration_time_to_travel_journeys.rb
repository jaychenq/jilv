class AddDurationTimeToTravelJourneys < ActiveRecord::Migration
  def change
    add_column :travel_journeys, :duration_time, :string
  end
end
