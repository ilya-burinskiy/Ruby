def main
    bucket = {}

    loop do
        print "purchase: "
        purchase = gets.chomp
        
        break if purchase == "stop"

        print "price: "
        price = gets.to_f

        print "count: "
        count = gets.to_i

        bucket[purchase] = {price: price, count: count}


    end

    psums = []
    bucket.each do |name, prop|
        price = prop[:price]
        count = prop[:count]
        sum = price * count
        psums << sum

        puts "purchase: #{name}, price: #{price}, count: #{count}, sum: #{sum}"
    end

    puts

    total_psum = psums.inject(0, :+)
    puts "total sum: #{total_psum}"
end

main