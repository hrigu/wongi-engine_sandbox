require 'ruby-prolog'

c = RubyProlog::Core.new
c.instance_eval do
  father['R', 'C'].fact
  father['R', 'W'].fact
  father['C', 'B'].fact
  father['W', 'M'].fact
  father['W', 'F'].fact

  grandfather[:X, :Z] <<= [father[:X, :Y], father[:Y, :Z]]

  sibling[:X, :Y] <<[father[:Z, :X], father[:Z, :Y], noteq[:X, :Y]]
  cousin[:A, :B] <<[ father[:F, :A], father[:G, :B], father[:H, :F], father[:H, :G], noteq[:A, :B]]

  puts "Wer ist Grossvater von Wem?"
  p query(grandfather[:X, :Z])
  puts "Wer sind Geschwister"
  p query(sibling[:X, :Z])
  puts "Wer sind Cousinen?"
  p query(cousin[:X, :Z])



end
