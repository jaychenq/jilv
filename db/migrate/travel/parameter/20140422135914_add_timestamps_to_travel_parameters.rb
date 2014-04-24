class AddTimestampsToTravelParameters < ActiveRecord::Migration
  def change
    add_timestamps :travel_parameters
  end
end
