require 'json'

module Import

def self.included(base)
    base.extend(EventClassHelpers)
end

  module EventClassHelpers

    def import_geojson(geojson)
      upload = JSON.parse(geojson)
      upload["features"].each do |feature|
        event_data = { geometry: feature["geometry"] }
        feature["properties"].keys.each do |property|
          import_property(feature, property, event_data)
        end
		return Event.new(event_data)
      end
    end

    def import_property(feature, property, event)
      if property =~ /date/
        import_date_property(feature, property, event)
      else
        event[property.to_sym] = feature["properties"][property]
      end
    end

    def import_date_property(feature, property, event)
      event[property.to_sym] = DateTime.iso8601(feature["properties"][property].to_s)
    end


  end

end