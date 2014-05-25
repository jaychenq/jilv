class AddStartTimeToTravelJourneys < ActiveRecord::Migration
  def change
    add_column :travel_journeys, :start_time, :string
  end
end
