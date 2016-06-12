$x = 1

def hello(direction)
 print direction
end



def run()
    while $x
      dir = gets.downcase.chomp
      send :hello, dir
    end
end

run()