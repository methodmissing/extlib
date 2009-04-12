#!/usr/bin/env ruby
require "rubygems"
require "rbench"

class Object
  
  CALLSITE_SAMPLE = 1..10
  
  def callsite_with_constant_append( *signature ) 
    ( caller[CALLSITE_SAMPLE] << signature ).hash
  end
  
  def callsite_without_constant_append( *signature ) 
    ( caller[1..10] << signature ).hash
  end  
  
  def callsite_with_constant_concat( *signature ) 
    ( caller[CALLSITE_SAMPLE].concat( signature ) ).hash
  end  

  def callsite_without_constant_concat( *signature ) 
    ( caller[1..10].concat( signature ) ).hash
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

=begin
213-138-231-57:extlib lourens$ jruby benchmarks/callsite.rb
                                                Results |
---------------------------------------------------------
Object#callsite_with_constant_append              0.747 |
Object#callsite_without_constant_append           0.726 |
Object#callsite_with_constant_concat              0.674 |
Object#callsite_without_constant_concat           0.724 |
213-138-231-57:extlib lourens$ jruby --fast benchmarks/callsite.rb
                                                Results |
---------------------------------------------------------
Object#callsite_with_constant_append              0.336 |
Object#callsite_without_constant_append           0.289 |
Object#callsite_with_constant_concat              0.290 |
Object#callsite_without_constant_concat           0.288 |
213-138-231-57:extlib lourens$ ruby -v
ruby 1.8.7 (2008-08-11 patchlevel 72) [i686-darwin9.5.1]
213-138-231-57:extlib lourens$ ruby benchmarks/callsite.rb
                                                Results |
---------------------------------------------------------
Object#callsite_with_constant_append              0.356 |
Object#callsite_without_constant_append           0.343 |
Object#callsite_with_constant_concat              0.322 |
Object#callsite_without_constant_concat           0.338 |
213-138-231-57:extlib lourens$ ruby19
213-138-231-57:extlib lourens$ ruby -v
ruby 1.9.1p0 (2009-01-30 revision 21907) [i386-darwin9.5.1]
213-138-231-57:extlib lourens$ ruby benchmarks/callsite.rb
/opt/local/ruby19/lib/ruby/gems/1.9.1/gems/rbench-0.2.3/lib/rbench/group.rb:4: warning: undefining `object_id' may cause serious problem
/opt/local/ruby19/lib/ruby/gems/1.9.1/gems/rbench-0.2.3/lib/rbench/report.rb:4: warning: undefining `object_id' may cause serious problem
                                                Results |
---------------------------------------------------------
Object#callsite_with_constant_append              0.345 |
Object#callsite_without_constant_append           0.337 |
Object#callsite_with_constant_concat              0.322 |
Object#callsite_without_constant_concat           0.330 |
=end