#!/usr/bin/env ruby

require 'swineherd'
require 'swineherd/script/r_script' ; include Swineherd::Script

Settings.define :width,  :default => 1200, :description => "Plot width in pixels"
Settings.define :x,      :default => 1,    :description => "Column to use as x values"
Settings.define :y,      :default => 2,    :description => "Column to use as y values"
Settings.define :xlab,   :default => "X",  :description => "X label"
Settings.define :ylab,   :default => "Y",  :description => "Y label"
Settings.resolve!

raise "No input data!" unless Settings.rest.first

plotter = RScript.new('templates/xyplot.R.erb')
plotter.output << File.basename(Settings.rest.first).gsub(File.extname(Settings.rest.first), ".png")
plotter.attributes = {
  :data => Settings.rest.first,
  :plot => plotter.output,
  :x    => Settings.x,
  :y    => Settings.y,
  :xlab => Settings.xlab,
  :ylab => Settings.ylab,
  :width  => Settings.width
}
plotter.run true
