class Motor

  attr_accessor :name, :fuel_left, :fuel_capacity, :speed, :time, :distance, :total_dist, :total_time, :fuel_consumption
  WHEELS = 2

  def initialize(name, fuel_capacity)
    @name = name
    @fuel_capacity = fuel_capacity
    @total_dist = []
    @total_time = []
    @fuel_consumed = 0
    @fuel_consumption = 0
    @fuel_left = fuel_capacity

    puts "Motor #{name} dengan kapasitas bensin #{fuel_capacity} liter telah dibuat"
  end

  def run(distance, speed)
    @distance = distance
    @speed = speed
    
    check_fuel
  end

  def check_fuel
    self.fuel_consumption = distance/100
    if fuel_consumption>fuel_left 
      puts "Bensin tidak cukup untuk perjalanan ini"
      return

      if fuel_left<=0
        puts "Bensin sudah habis"
        return
      end

    else
      time_consumed
      fuel_consumed
      travelled
    end
  end

  def fuel_consumed
    self.fuel_left -= (distance/100)
  end

  def time_consumed
    self.time = distance/speed
    total_time.push(time)
    total_dist.push(distance)
  end

  def travelled
    puts "Kecepatan saat ini adalah #{self.speed} m/s"
    puts "Waktu yang ditempuh adalah #{self.time} detik"
    puts "Bensin yang tersisa ada #{fuel_left} liter"
    puts "Jarak yang ditempuh selama ini adalah #{total_dist.sum} meter"
    puts "Waktu yang ditempuh selama ini adalah #{total_time.sum} detik"
  end

  def fill_gas(fill)
    if fuel_left>=fuel_capacity
      puts "Bensin sudah terisi penuh"
      return
    else 
      if (fuel_capacity - fuel_left) < fill
        p "Bensin terisi sebanyak #{fuel_capacity - fuel_left} liter"
        self.fuel_left += (fuel_capacity - fuel_left)
      else
        p "Bensin terisi sebanyak #{fill} liter"
        self.fuel_left += fill
      end
    end
  end

  def reset
    self.fuel_left = 0
    self.distance = 0
    self.time = 0
    puts "Reset jumlah bensin, jarak tempuh, dan waktu tempuh jadi 0"
  end

  def wheels
    puts "Motor #{name} punya #{WHEELS} roda"
  end

end