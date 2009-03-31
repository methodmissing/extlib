#!/usr/bin/env ruby
require "rubygems"
require "rbench"

class Object
  
  CALLSITE_SAMPLE = 1..3
  
  def callsite_with_constant_append( *signature ) 
    ( caller[CALLSITE_SAMPLE] << signature ).hash
  end
  
  def callsite_without_constant_append( *signature ) 
    ( caller[1..3] << signature ).hash
  end  
  
  def callsite_with_constant_concat( *signature ) 
    ( caller[CALLSITE_SAMPLE].concat( signature ) ).hash
  end  

  def callsite_without_constant_concat( *signature ) 
    ( caller[1..3].concat( signature ) ).hash
  end  
  
end

RBench.run(10_000) do
  
  report "Object#callsite_with_constant_append" do
    callsite_with_constant_append
    callsite_with_constant_append( :one, 'two' )
  end

  report "Object#callsite_without_constant_append" do
    callsite_without_constant_append
    callsite_without_constant_append( :one, 'two' )
  end

  report "Object#callsite_with_constant_concat" do
    callsite_with_constant_concat
    callsite_with_constant_concat( :one, 'two' )
  end

  report "Object#callsite_without_constant_concat" do
    callsite_without_constant_concat
    callsite_without_constant_concat( :one, 'two' )
  end
  
end  