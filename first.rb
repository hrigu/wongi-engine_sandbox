require 'rubygems'
require 'bundler/setup'

require 'wongi-engine'

engine = Wongi::Engine.create

engine << [ "Alice", "friend", "Bob" ]
engine << [ "Bob", "friend", "John" ]
engine << [ "Alice", "age", 35 ]


engine.each "Alice", :_, :_ do |item|
    puts "Alice's #{item.predicate} is #{item.object}"
end