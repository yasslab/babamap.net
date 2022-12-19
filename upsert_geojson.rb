#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'

MARKERS_YAML = 'markers.yaml'
marker_data  = YAML.unsafe_load_file(MARKERS_YAML, symbolize_names: true)

features    = []
marker_data.each do |marker|
  next if marker[:title].eql? '404_Not_Found'

  features << {
    type: "Feature",
    geometry: {
      type: "Point",
      coordinates: [marker[:lng], marker[:lat]]
    },
    properties: {
      'marker-size'   => 'small',
      'marker-symbol' => 'minkei',
      'marker-color'  => 'rgba(45, 105, 176, 0.7)', # BabaKeizai Blue
      #'marker-color' => 'rgba(237, 208, 70, 0.8)', # BabaKeizai Yellow
      description: "<a target='_blank' rel='noopener' href='#{marker[:link]}'>#{marker[:title]}</a> <small>(#{marker[:date]})</small>"
    }
  }
end

geojson = {
  "type": "FeatureCollection",
  "features": features
}

File.open("markers.geojson", "w") do |file|
  JSON.dump(geojson, file)
end

