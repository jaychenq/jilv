class AddTimestampsToTravelJourneys < ActiveRecord::Migration
  def change
    add_timestamps :travel_journeys
  end
end
