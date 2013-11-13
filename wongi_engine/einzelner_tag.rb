require 'rubygems'
require 'bundler/setup'

require 'wongi-engine'

def create_engine
  engine = Wongi::Engine.create

  engine << ["t1", "hat", "A"]
  engine << ["t1", "hat", "B"]
  engine << ["t1", "hat", "C"]
  engine << ["t1", "hat", "D"]

  engine << ["Z", "kann", "A"]
  engine << ["Z", "kann", "B"]
  engine << ["Y", "kann", "C"]
  engine << ["X", "kann", "C"]
  engine << ["X", "kann", "D"]
  engine << ["W", "kann", "D"]

  @engine = engine
end



def remote_rules
  #4-er Freundeskette, Kreise verhindert
  remote = @engine.rule "remote friends" do
    forall {
      has  :Tag, "hat", :Dienst
      has  :Person, "kann", :Dienst
    }
  end

  remote.tokens.each do |token|
    #puts token.to_s
    puts "#{token[:Tag]} -> #{token[:Dienst]} -> #{token[:Person]}"
    #puts "%s and %s are friends through %s" % [token[:PersonA], token[:PersonC], token[:PersonB]]
  end
end
create_engine
#simple_iteration
#simple_rules
remote_rules
#stored_queries
#with_action