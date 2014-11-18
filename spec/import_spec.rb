require 'dm-core'
require 'data_mapper'
require 'import.rb'

class Event

  include DataMapper::Resource
  include Import

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

describe "import" do

  context "importing geoJSON data" do

    it "should have a method to import a geoJSON-Feature-ready hash object" do

      geojson = {
        type: "FeatureCollection",
        features: [
          {
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
          }
        ]
        }.to_json

        event = Event.new(
          title: "event",
          description: "event",
          short_description: "it's an event",
          startdate: DateTime.new(1900),
          enddate: DateTime.new(1900),
          geometry: { "type" => "Point",
                      "coordinates" =>[1.0, 1.0] }
      )

      expect(Event.import_geojson(geojson)).to eq(
        event
        )
    end
  end
end