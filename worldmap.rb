#!/usr/bin/env ruby

require 'swineherd'
require 'swineherd/script/r_script' ; include Swineherd::Script

Settings.define :width,  :default => 84,    :description => "Plot width in inches"
Settings.define :height, :default => 48,    :description => "Plot height in inches"
Settings.define :lat,    :default => 1,     :description => "Latitude field"
Settings.define :lon,    :default => 2,     :description => "Longitude field"
Settings.define :title,  :default => "",    :description => "Title of the plot"
Settings.resolve!

raise "No input data!" unless Settings.rest.first

plotter = RScript.new('templates/worldmap.R.erb')
plotter.output << File.basename(Settings.rest.first).gsub(File.extname(Settings.rest.first), ".pdf")
plotter.attributes = {
  :data      => Settings.rest.first,
  :plot      => plotter.output,
  :latitude  => Settings.lat,
  :longitude => Settings.lon,
  :width     => Settings.width,
  :title     => Settings.title,
  :height    => Settings.height
}
plotter.run true
