require 'rubygems'
require 'bundler/setup'

require 'wongi-engine'


=begin
In der Dorfstrasse stehen 4 Häuser nebeneinander.
In jedem wohnt ein Mann mit einem Beruf: Arzt, Elektriker, Schweisser oder Schlosser.
Jedes Haus hat eine andere Farbe: blau, grau, rot oder weiss.

Hinweise:

1. Der Schlosser und der Elektriker wohnen nicht nebeneinander.

2. Im weissen Haus wohnt der Arzt.
3. Der Arzt wohnt im 3-ten Haus.
4. Der Schlosser und der Arzt wohnen nicht nebeneinander.
5. Im blauen Haus wohnt der Elektriker.
6. Neben dem grauen Haus wohnt der Schlosser.
7. Neben dem blauen Haus wohnt nicht der Schlosser.
8. Neben dem weissen Haus wohnt nicht der Schlosser.


Beruf: [Arzt, Elektriker, Schweisser oder Schlosser]
Farbe: [blau, grau, rot oder weiss]
=end


def create_engine
  @engine = Wongi::Engine.create

end

def facts
  @engine << ["Farben", "sind", ["blau", "grau", "rot", "weiss"]]
  @engine << ["Berufe", "sind", ["Arzt", "Elektriker", "Schweisser", "Schlosser"]]

  @engine << ["Arzt", "haus_ist", "weiss"]
  @engine << ["Arzt", "wohnt_im", "2"]

  @engine << ["Elektriker", "haus_ist", "blau"]

  @engine << ["Schlosser", "neben", "grau"]
  @engine << ["Schlosser", "nicht_neben", "blau"]
  @engine << ["Schlosser", "nicht_neben", "weiss"]
end

###
# Simple rules
###
def rules
  farbe_des_hauses = @engine.rule "farbe_des_hauses" do
    forall {
      has :Person, "haus_ist", :Farbe
    }
  end


end



create_engine
facts
rules
