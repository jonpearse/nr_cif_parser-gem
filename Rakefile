require 'rubygems'
require 'rake/testtask'

desc 'Run unit tests'
Rake::TestTask.new( :test ) do |t|
  
  t.libs.concat( %w{ lib test } )
  t.pattern = 'test/tests/*.rb'
  t.warning = false
  
end