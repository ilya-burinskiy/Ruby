require 'matrix'

def read_matrix
    empty_row_cnt = 0
    col_num = 0
    rows = []

    until empty_row_cnt == 2 do
        print ">>> "
        row = gets.chomp
        if row != ""
            row = row.split(",").map{|c| c.to_f}

            if col_num == 0
                col_num = row.length
            elsif row.length != col_num
                raise "Wrong row length. Expected #{col_num}, given #{row.length}"
            end

            rows << row
            empty_row_cnt = 0
        else
            empty_row_cnt += 1
        end
    end

    if rows.length != col_num
        raise "Matrix is not square"
    end

    return rows
end



def main
    begin
        m = read_matrix
    rescue StandardError => e
        puts e.message
    else
        puts "det(A) = #{Matrix[*m].determinant()}"
    end
end

main