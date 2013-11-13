require 'rubylog'
module MyContext
  extend Rubylog::Context
  predicate_for String, ".is_father_of()", ".is_grandfather_of()", ".is_brother_of()"
  'R'.is_father_of!('C')
  'R'.is_father_of!('W')
  'C'.is_father_of!('B')
  X.is_grandfather_of!(Z) if X.is_father_of(Y) and Y.is_father_of(Z)
  X.is_brother_of!(Y) if Z.is_father_of(X) and Z.is_father_of(Y)


  puts "father yes" if 'R'.is_father_of?('C')
  puts "father yes" if 'R'.is_father_of?('W')
  puts "grandfather yes" if 'R'.is_grandfather_of?('B')
  puts "brother yes" if 'C'.is_brother_of?('W')
  puts "brother yes" if 'W'.is_brother_of?('C')

  B.is_father_of(A).each do
    puts "#{B} is father of #{A}"
  end

  #puts C.is_grandfather_of(D).map{C}

end