print "a: "
a = gets.to_i

print "b: "
b = gets.to_i

print "c: "
c = gets.to_i

D = b ** 2 - 4 * a * c

puts "D = #{D}"
if D > 0
    root1 = (-b + (D ** 0.5)) / 2 * a
    root2 = (-b - (D ** 0.5)) / 2 * a
    puts "roots: #{root1}, #{root2}"
elsif D == 0
    root = -b / 2 / a
    puts "root #{root}"
else
    puts "imaginary roots"
end