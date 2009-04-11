#!/usr/bin/env ruby
require "rubygems"
require "rbench"

require 'set'
require File.join( File.dirname( __FILE__ ), '..', 'lib', 'extlib', 'simple_set' )

RBench.run(10_000) do

  report "Set#initialize" do
    Set.new( [:one, :two, :three, :four] )
  end
  
  report "Extlib::SimpleSet#initialize" do
    Extlib::SimpleSet.new( [:one, :two, :three, :four] )
  end  
  
  report "Set#merge" do
    s = Set.new( [:one, :two, :three, :four] )
    s.merge( [:five, :six] )
  end
  
  report "Extlib::SimpleSet#merge" do
    s = Extlib::SimpleSet.new( [:one, :two, :three, :four] )
    s.merge( [:five, :six] )
  end  
  
  report "Set#to_a" do
    Set.new( [:one, :two, :three, :four] ).to_a
  end
  
  report "Extlib::SimpleSet#to_a" do
    Extlib::SimpleSet.new( [:one, :two, :three, :four] ).to_a
  end  
  
  report "Set#<<" do
    s = Set.new
    s << :one
    s << [:two]
    s << :three
  end
  
  report "Extlib::SimpleSet#<<" do
    s = Extlib::SimpleSet.new
    s << :one
    s << [:two]
    s << :three
  end  
  
end  

=begin
213-138-235-46:extlib lourens$ ruby benchmarks/simple_set.rb
                                     Results |
----------------------------------------------
Set#initialize                         0.068 |
Extlib::SimpleSet#initialize           0.062 |
Set#merge                              0.096 |
Extlib::SimpleSet#merge                0.113 |
Set#to_a                               0.106 |
Extlib::SimpleSet#to_a                 0.036 |
Set#<<                                 0.079 |
Extlib::SimpleSet#<<                   0.037 |
=end