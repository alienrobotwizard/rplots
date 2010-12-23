#!/usr/bin/env ruby

require 'swineherd'
require 'swineherd/script/r_script' ; include Swineherd::Script

#
# Often it is the case you've got timeseries of the form:
#
# 201006 1234
# 201007 5678
# ...
#
# This transforms the month field into something R can understand and plots it
# with the right scaling.
#
Settings.define :width,      :default => 1200,  :description => "Plot width in pixels"
Settings.define :month,      :default => 1,     :description => "Column to use as the month field"
Settings.define :y,          :default => 2,     :description => "Column to use as y values"
Settings.define :points,     :default => false, :description => "Plot defaults to line, use points instead"
Settings.define :xlab,       :default => "X",   :description => "X label"
Settings.define :ylab,       :default => "Y",   :description => "Y label"
Settings.define :point_size, :default => 1,     :description => "Width of line in pixels or size of points in pixels"
Settings.resolve!

raise "No input data!" unless Settings.rest.first

plotter = RScript.new('templates/monthseries.R.erb')
plotter.output << File.basename(Settings.rest.first).gsub(File.extname(Settings.rest.first), ".png")
plotter.attributes = {
  :data   => Settings.rest.first,
  :plot   => plotter.output,
  :month  => Settings.month,
  :y      => Settings.y,
  :xlab   => Settings.xlab,
  :ylab   => Settings.ylab,
  :width  => Settings.width,
  :size   => Settings.point_size,
  :points => Settings.points
}
plotter.run true
