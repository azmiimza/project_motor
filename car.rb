require_relative "spedo_meter_engine"
require_relative "motor"

class Car < Motor
  include SpedoMeterEngine

  WHEELS = 4
  @@cars = []

  def spedo
    display_velocity_in_kmph
    display_velocity_in_mph
    display_distance_in_km
    display_distance_in_mile
  end

  def initialize(name:, fuel_capacity:, speed:, space:, price:)
    @name = name
    @fuel_capacity = fuel_capacity
    @total_dist = 0
    @total_time = 0
    @speed = speed
    @fuel_consumed = 0
    @fuel_left = fuel_capacity
    @space = space
    @price = price
    @@cars << self

    puts "Mobil #{name} dengan kapasitas bensin #{fuel_capacity} liter telah dibuat"
  end

  def self.create(name: , fuel_capacity: , speed: , space: , price: )
    car = Car.new(name: name , fuel_capacity: fuel_capacity, speed: speed, space: space, price: price)
    car
  end

  def self.all
    car = @@cars.map {|x| x.name}

    if car.any?
      puts car.join(", ")
      @@cars # to return array of objects
    else
      puts "List car kosong"
    end
  end

  def self.find(name)
    car = @@cars.find {|x| x.name==name}
    if car != nil
      puts "Car #{name} dipilih"
      car
    else
      puts "Car #{name} tidak ada dalam list"
    end
  end

  def self.destroy(name)
    selected = @@cars.select {|x| x.name==name}
    if selected.any?
      @@cars -= selected
      puts "car #{name} berhasil dihapus dari list"
    else
      puts "car #{name } tidak ada dalam list"
    end
  end

  def run(time)
    distance = @speed * time
    fuel_consumption = distance/100
    if fuel_consumption>fuel_left
      puts "Bensin tidak cukup"
      return

    else
      @fuel_left -= fuel_consumption
      @total_time += time
      @total_dist += distance
    end
  end
  
  def fill_gas(fill)
    if fuel_left>=fuel_capacity
      puts "Bensin sudah terisi penuh"
      return
    else 
      if (fuel_capacity - fuel_left) < fill
        puts "Bensin terisi hanya sebanyak #{fuel_capacity - fuel_left} liter"
        @fuel_left += (fuel_capacity - fuel_left)
      else
        puts "Bensin terisi sebanyak #{fill} liter"
        @fuel_left += fill
      end
    end
  end

  def reset
    @fuel_left = 0
    @total_dist = 0
    @total_time = 0
    puts "Reset jumlah bensin, jarak tempuh, dan waktu tempuh jadi 0"
  end

end