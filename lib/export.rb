module Export

	def export_geojson
		{
		type: "Feature",
		properties: {
			id: id,
			title: title,
			short_description: short_description,
			description: description,
			startdate: startdate,
			enddate: enddate,
			timescale: timescale
			},
			geometry: geometry
		}
	end

end