  class RouteIterator

      attr_reader :stations
      attr_accessor :p
      attr_accessor :c
      attr_accessor :n

      def initialize(route)
          @stations = [route.dispatch_station, 
                      *route.intermediate_stations,
                      route.terminal_station]
          @p = -1
          @c = @p + 1
          @n = @c + 1
      end

      def can_go_forward()
        return self.n < stations.length
      end

      def forward()
        if can_go_forward()
          self.p = self.c
          self.c = self.n
          self.n += 1
        else
          raise Exception.new
        end
      end

      def can_go_back()
        return self.p >= 0
      end

      def back()
        if can_go_back()
          self.n = self.c
          self.c = self.p
          self.p -= 1
        else
          raise Exception.new
        end
      end

      def prev()
        if self.p >= 0
          return self.stations[self.p]
        else
          return nil
        end
      end

      def curr()
        return self.stations[self.c]
      end

      def next()
        if self.n < self.stations.length 
          return self.stations[self.n]
        else
          return nil
        end
      end
  end