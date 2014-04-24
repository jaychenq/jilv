class AddTimestampsToTravelSpeakings < ActiveRecord::Migration
  def change
    add_timestamps :travel_speakings
  end
end
