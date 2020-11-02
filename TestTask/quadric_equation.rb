def main
    print "a: "
    a = gets.to_i

    print "b: "
    b = gets.to_i

    print "c: "
    c = gets.to_i

    d = b ** 2 - 4 * a * c

    puts "D = #{d}"
    if d > 0
        root1 = (-b + (d ** 0.5)) / 2 * a
        root2 = (-b - (d ** 0.5)) / 2 * a
        puts "roots: #{root1}, #{root2}"
    elsif d == 0
        root = -b / 2 / a
        puts "root #{root}"
    else
        puts "imaginary roots"
    end
end

main