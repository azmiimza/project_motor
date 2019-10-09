class Motor

  attr_accessor  :name, :fuel_left, :fuel_capacity, :speed, :total_dist, :total_time
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
    Motor.new(name: name , fuel_capacity: fuel_capacity, speed: speed)
    puts "Object #{name} berhasil ditambahkan dalam list"
  end

  def self.all
    puts @@motors.map {|x| x.name}.join(",")
    @@motors # to return array of objects
  end

  def self.find(name)
    @@motors.find {|x| x.name==name}  
  end

  def self.destroy(name)
    @@motors -= @@motors.select {|x| x.name==name}
    puts "Object berhasil dihapus dari list"
  end

  def run(time)
    distance = @speed * time
    fuel_consumption = distance/100
    if fuel_consumption>fuel_left
      puts "bensin tidak cukup"
      return

    else
      @fuel_left -= fuel_consumption
      puts "Kecepatan saat ini adalah #{@speed} m/s"
      puts "Waktu yang ditempuh adalah #{time} detik"
      puts "Jarak yang ditempuh adalah #{distance} meter"
      puts "Bensin yang tersisa ada #{@fuel_left} liter"
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
        p "Bensin terisi sebanyak #{fuel_capacity - fuel_left} liter"
        @fuel_left += (fuel_capacity - fuel_left)
      else
        p "Bensin terisi sebanyak #{fill} liter"
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