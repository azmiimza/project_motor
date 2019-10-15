require_relative "motor"
require_relative "car"

class Garage
  attr_accessor :motors_cars, :capacity

  def initialize
    @motors_cars = []
    @capacity = 10
  end

  def add(name)
    vehicle = Motor.find(name)
    if vehicle == nil
      vehicle = Car.find(name)
    end
    space = vehicle.space
    if vehicle!=nil
      if @capacity>=space
        @motors_cars.push(vehicle)
        @capacity -= space
        puts "Space parkir anda terpakai sebanyak #{space} space, menjadi #{@capacity}"
        true
      else
        puts "Space tidak cukup"
        false
      end
    else
      return
    end
  end

  def destroy(name,type)
    if type == "motor"
      vehicle = Motor.find(name)
      
    elsif type == "car"
      vehicle = Car.find(name)
      
    end
    space = motor.space
    selected = @motors_cars.select {|motor| motor.name==name}
    if selected.any?
      @motors_cars -= selected
      @capacity+=space
    else
      puts "Kendaraan #{name } tidak ada dalam garage"
    end
  end

  def find(name)
    selected = @motors_cars.find {|motor| motor.name==name}

    if selected!=nil
      selected
      # true
    else
      nil
    end
  end
end

m1=Motor.new(name: 'Ninja', fuel_capacity:1000, speed:200, space: 5, price: 50)
m2=Motor.new(name: 'CBR', fuel_capacity:900, speed:180, space: 4, price: 35)
m3=Motor.new(name: 'Vario', fuel_capacity:500, speed:150, space: 3, price: 20)
m4=Motor.new(name: 'Mio', fuel_capacity:300, speed:120, space: 2, price: 18)
m5=Motor.new(name: 'Supra', fuel_capacity:250, speed:100, space: 1, price: 15)


