#!/usr/bin/env ruby

require 'swineherd'
require 'swineherd/script/r_script' ; include Swineherd::Script

Settings.define :width,  :default => 1200,    :description => "Plot width in pixels"
Settings.define :x,      :default => 1,       :description => "Column to compute histogram of"
Settings.define :weight,                      :description => "Column to use as histogram weight"
Settings.define :xlab,   :default => "X",     :description => "X label"
Settings.define :ylab,   :default => "Count", :description => "Y label"
Settings.define :title,  :default => "",      :description => "Title of the plot"
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
  :width  => Settings.width,
  :title  => Settings.title
}
plotter.run true
