require 'dm-core'
require 'data_mapper'
require 'export.rb'

class Event

  include DataMapper::Resource
  include Export

  property :id,                Serial
  property :title,             String
  property :short_description, Text
  property :description,       Text
  property :geometry,          Object
  property :timescale,         String
  property :startdate,         DateTime
  property :enddate,           DateTime

end

DataMapper.finalize

describe "export" do

  context "exporting geoJSON data" do

    it "should have a method to export a geoJSON-Feature-ready hash object" do
      event = Event.new(
        title: "event",
        description: "event",
        short_description: "it's an event",
        startdate: DateTime.new(1900),
        enddate: DateTime.new(1900),
        geometry: { type: "Point",
                    coordinates: [1.0, 1.0] }
      )
      expect(event.export_geojson).to eq({
        type: "Feature",
        properties: {
          id: nil,
          title:"event",
          short_description: "it's an event",
          description:"event",
          startdate:DateTime.new(1900),
          enddate:DateTime.new(1900),
          timescale: nil
        },
        geometry: {
          type:"Point",
          coordinates:[1.0,1.0]
        }
      })
    end
  end
end