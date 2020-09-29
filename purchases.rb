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

        bucket[purchase] = {price => count}

    end

    psums = []
    bucket.each { |name, price_and_count|
        price = price_and_count.keys().first
        count = price_and_count[price]
        sum = price * count
        psums << sum

        puts "purchase: #{name}, price: #{price}, count: #{count}, sum: #{sum}"
    }

    puts

    total_psum = psums.inject(0, :+)
    puts "total sum: #{total_psum}"
end

main