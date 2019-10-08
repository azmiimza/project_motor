class Motor

  attr_accessor :name, :fuel_left, :fuel_capacity, :speed, :total_dist, :total_time
  WHEELS = 2

  def initialize(name: "Honda", fuel_capacity: 100, speed: 20)
    @name = name
    @fuel_capacity = fuel_capacity
    @total_dist = 0
    @total_time = 0
    @speed = speed
    # @distance  = 0
    @fuel_consumed = 0
    @fuel_left = fuel_capacity

    puts "Motor #{name} dengan kapasitas bensin #{fuel_capacity} liter telah dibuat"
  end

  def run(time)
    distance = self.speed * time
    fuel_consumption = distance/100
    if fuel_consumption>fuel_left
      puts "bensin tidak cukup"
      return
    # elsif fuel_left<=0
    #   puts "Bensin sudah habis"
    #   return
    else
     
      self.fuel_left -= fuel_consumption
      puts "Kecepatan saat ini adalah #{self.speed} m/s"
      puts "Waktu yang ditempuh adalah #{time} detik"
      puts "Jarak yang ditempuh adalah #{distance} meter"
      puts "Bensin yang tersisa ada #{self.fuel_left} liter"
      self.total_time += time
      self.total_dist += distance
    end
  end

  # def check_fuel
  #   distance = self.speed * time
  #   fuel_consumption = distance/100
  #   if fuel_consumption>fuel_left
  #     puts "bensin tidak cukup"
  #     return
  #   elsif fuel_left<=0
  #     puts "Bensin sudah habis"
  #     return
  #   else
     
  #     self.fuel_left -= fuel_consumption
  #     puts "Kecepatan saat ini adalah #{self.speed} m/s"
  #     puts "Waktu yang ditempuh adalah #{self.time} detik"
  #     puts "Jarak yang ditempuh adalah #{distance} meter"
  #     puts "Bensin yang tersisa ada #{self.fuel_left} liter"
  #     self.total_time += self.time
  #     self.total_dist += distance
  #   end
  # end

  

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
    self.total_dist = 0
    self.total_time = 0
    puts "Reset jumlah bensin, jarak tempuh, dan waktu tempuh jadi 0"
  end

end