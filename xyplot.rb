#!/usr/bin/env ruby

require 'swineherd'
require 'swineherd/script/r_script' ; include Swineherd::Script

Settings.define :width,      :default => 1200,  :description => "Plot width in pixels"
Settings.define :x,          :default => 1,     :description => "Column to use as x values"
Settings.define :y,          :default => 2,     :description => "Column to use as y values"
Settings.define :points,     :default => false, :description => "Plot defaults to line, use points instead"
Settings.define :xlab,       :default => "X",   :description => "X label"
Settings.define :ylab,       :default => "Y",   :description => "Y label"
Settings.define :title,      :default => "",    :description => "Title of the plot"
Settings.define :point_size, :default => 1,     :description => "Width of line in pixels or size of points in pixels"
Settings.resolve!

raise "No input data!" unless Settings.rest.first

plotter = RScript.new('templates/xyplot.R.erb')
plotter.output << File.basename(Settings.rest.first).gsub(File.extname(Settings.rest.first), ".png")
plotter.attributes = {
  :data   => Settings.rest.first,
  :plot   => plotter.output,
  :x      => Settings.x,
  :y      => Settings.y,
  :xlab   => Settings.xlab,
  :ylab   => Settings.ylab,
  :title  => Settings.title,
  :width  => Settings.width,
  :size   => Settings.point_size,
  :points => Settings.points
}
puts File.read(plotter.script)
plotter.run true
