require 'rubygems'
require 'bundler/setup'

require 'wongi-engine'

def create_engine
  engine = Wongi::Engine.create

  engine << ["Alice", "friend", "Bob"]
  engine << ["Bob", "friend", "John"]
  engine << ["John", "friend", "Alice"]
  engine << ["Bob", "friend", "Claire"]
  engine << ["Claire", "friend", "John"]

  engine << ["Alice", "age", 35]
  @engine = engine
end

###
# Simple iteration
###

def simple_iteration
#:_ matches anything
#'each' takes three arguments for every field of a triple and tries to match the resulting template against the known facts.
 @engine.each :_, :_, :_ do |item|
    puts "#{item.subject}: #{item.predicate} is #{item.object}"
  end
end


###
# Simple rules
###
def simple_rules
# A rule, generally speaking, consists of a number of conditions the dataset needs to meet;
# those are defined in the 'forall' section.
# 'has' (or fact) specifies that there needs to be a fact that matches the given pattern; in this case, one with the predicate "friend".

  friends = @engine.rule "friends" do
    forall {
      has :PersonA, "friend", :PersonB
    }
  end


# When a pattern contains a symbol that starts with an uppercase letter, it introduces a variable which will be bound to an actual triple field.
# Their values can be retrieved from the result set:

# A token represents all facts that passed the rule's conditions.
# If you think of the dataset as of a long SQL table being joined with itself, then a token is like a row in the resulting table.
  friends.tokens.each do |token|
    puts "#{token[:PersonA]} and #{token[:PersonB]} are friends" # The same: puts "%s and %s are friends" % [ token[:PersonA], token[:PersonB ]]   #
  end

end


def remote_rules
  #4-er Freundeskette, Kreise verhindert
  remote = @engine.rule "remote friends" do
    forall {
      has  :PersonA, "friend", :PersonB
      has  :PersonB, "friend", :PersonC
      has  :PersonC, "friend", :PersonD
      diff :PersonA, :PersonD
      #same :PersonA, :PersonD
    }
  end

  remote.tokens.each do |token|
    #puts token.to_s
    puts "#{token[:PersonA]} -> #{token[:PersonD]}"
    #puts "%s and %s are friends through %s" % [token[:PersonA], token[:PersonC], token[:PersonB]]
  end
end

def stored_queries
  q = @engine.query "friends" do
    search_on :Name
    forall {
      has :Name, "friend", :Friend
    }
  end

  @engine.execute "friends", { Name: "Bob" }

  q.tokens.each do |token|
    puts token.to_s
  end
end

def with_action
  @engine.rule "self-printer" do
    forall {
      has :PersonA, "friend", :PersonB
    }
    make {
      action { |token|
        puts "%s and %s are friends" % [ token[ :PersonA ], token[ :PersonB ] ]
      }
    }
  end
end



create_engine
#simple_iteration
#simple_rules
remote_rules
#stored_queries
#with_action