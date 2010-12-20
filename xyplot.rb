#!/usr/bin/env ruby

require 'swineherd'
require 'swineherd/script/r_script' ; include Swineherd::Script

Settings.define :plot, :required => true
Settings.define :height, :default => 40
Settings.define :width,  :default => 60
Settings.define :x,      :default => 1
Settings.define :y,      :default => 2
Settings.define :xlab,   :default => "X"
Settings.define :ylab,   :default => "Y"
Settings.resolve!

raise "No input data!" unless Settings.rest.first

plotter = RScript.new('templates/xyplot.R.erb')
plotter.attributes = {
  :data => Settings.rest.first,
  :plot => Settings.plot,
  :x    => Settings.x,
  :y    => Settings.y,
  :xlab => Settings.xlab,
  :ylab => Settings.ylab,
  :height => Settings.height,
  :width  => Settings.width
}
plotter.run
