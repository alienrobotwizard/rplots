#!/usr/bin/env ruby

require 'swineherd'
require 'swineherd/script/r_script' ; include Swineherd::Script

Settings.define :width,  :default => 1200
Settings.define :x,      :default => 1
Settings.define :weight
Settings.define :xlab,   :default => "X"
Settings.define :ylab,   :default => "Y"
Settings.resolve!

raise "No input data!" unless Settings.rest.first

plotter = RScript.new('templates/histogram.R.erb')
plotter.output << File.basename(Settings.rest.first).gsub(File.extname(Settings.rest.first), ".png")
plotter.attributes = {
  :data   => Settings.rest.first,
  :plot   => plotter.output,
  :x      => Settings.x,
  :weight => Settings.weight,
  :xlab   => Settings.xlab,
  :ylab   => Settings.ylab,
  :width  => Settings.width
}
plotter.run true
