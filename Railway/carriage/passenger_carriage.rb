# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_reader :seats_num, :reserved_seats_num

  def initialize(seats_num)
    super(:passenger)
    @seats_num = seats_num
    @reserved_seats_num = 0
  end

  def reserve_seat
    raise 'Not enough seats' if reserved_seats_num == seats_num

    self.reserved_seats_num += 1
  end

  def free_seats_num
    seats_num - reserved_seats_num
  end

  private

  attr_writer :seats_number, :reserved_seats_num
end
