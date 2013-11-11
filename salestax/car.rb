class Car
  @@count = 0

  def initialize
    @@count += 1
  end

  def self.count
    @@count
  end
end

Car.new
Car.new
Car.new
Car.new

puts Car.count