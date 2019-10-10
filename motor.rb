class Motor
  include Horn

  attr_accessor  :name,  :fuel_left, :fuel_capacity, :speed, :total_dist, :total_time
  WHEELS = 2
  @@motors = []


  def initialize(name: "Honda", fuel_capacity: 100, speed: 20)
    @name = name
    @fuel_capacity = fuel_capacity
    @total_dist = 0
    @total_time = 0
    @speed = speed
    @fuel_consumed = 0
    @fuel_left = fuel_capacity
    @@motors << self

    puts "Motor #{name} dengan kapasitas bensin #{fuel_capacity} liter telah dibuat"
  end

  def self.create(name: , fuel_capacity: , speed: )
    motor = Motor.new(name: name , fuel_capacity: fuel_capacity, speed: speed)
    motor
  end

  def self.all
    motor = @@motors.map {|x| x.name}

    if motor.any?
      puts motor.join(", ")
      @@motors # to return array of objects
    else
      puts "List motor kosong"
    end
  end

  def self.find(name)
    motor = @@motors.find {|x| x.name==name}
    if motor != nil
      puts "Motor #{name} dipilih"
      motor
    else
      puts "Motor #{name} tidak ada dalam list"
    end
  end

  def self.destroy(name)
    selected = @@motors.select {|x| x.name==name}
    if selected.any?
      @@motors -= selected
      puts "Motor #{name} berhasil dihapus dari list"
    else
      puts "Motor #{name } tidak ada dalam list"
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