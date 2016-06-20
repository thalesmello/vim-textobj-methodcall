range = 1..Float::INFINITY

range.lazy
     .collect { |x| x * x }
     .first(10)
     .each do |x|
       puts x
     end
