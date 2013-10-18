require 'rubygems'
require 'bundler/setup'

require 'wongi-engine'

engine = Wongi::Engine.create

engine << [ "Alice", "friend", "Bob" ]
engine << [ "Bob", "friend", "John" ]
engine << [ "John", "friend", "Alice" ]

engine << [ "Alice", "age", 35 ]


###
# Simple iteration
###
#:_ matches anithing
#'each' takes three arguments for every field of a triple and tries to match the resulting template against the known facts.
engine.each "Alice", :_, :_ do |item|
    puts "Alice's #{item.predicate} is #{item.object}"
end


###
# Simple rules
###

# A rule, generally speaking, consists of a number of conditions the dataset needs to meet;
# those are defined in the 'forall' section.
# 'has' (or fact) specifies that there needs to be a fact that matches the given pattern; in this case, one with the predicate "friend".

friends = engine.rule "friends" do
  forall {
    has :PersonA, "friend", :PersonB
  }
end


# When a pattern contains a symbol that starts with an uppercase letter, it introduces a variable which will be bound to an actual triple field.
# Their values can be retrieved from the result set:

# A token represents all facts that passed the rule's conditions.
# If you think of the dataset as of a long SQL table being joined with itself, then a token is like a row in the resulting table.
friends.tokens.each do |token|
 #puts token
    puts "%s and %s are friends" % [ token[:PersonA], token[:PersonB ]]
end
