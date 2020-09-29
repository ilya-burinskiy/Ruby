def main
    bucket = Hash.new

    print "purchase: "
    purchase = gets.chomp
    while purchase != "stop"
        print "price: "
        price = gets.to_f

        print "count: "
        count = gets.to_i

        bucket[purchase] = {price => count}

        print "purchase: "
        purchase = gets.chomp
    end

    psums = []
    for name in bucket.keys()
        price = bucket[name].keys()[0]
        count = bucket[name][price]
        sum = price * count
        psums << sum
        puts "purchase: #{name}, price: #{price}, count: #{count}, sum: #{sum}"
    end

    puts

    total_psum = psums.inject(0, :+)
    puts "total sum: #{total_psum}"
end

main