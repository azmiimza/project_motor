require_relative "motor"
require_relative "spedo_meter_engine"

class SportMotor < Motor
  attr_accessor :type, :gear

  include SpedoMeterEngine

  def initialize(name: , type: )
    
    if check_type(type)
      @type = type
      @gear = 1
      fuel_capacity = type/10
  
      super(name: name, fuel_capacity: fuel_capacity , speed: @speed)
    end
  end

  def spedo
    display_velocity_in_kmph
    display_velocity_in_mph
    display_distance_in_km
    display_distance_in_mile
  end

  def check_max_gear
    if type<150
      if @gear<4
        true
      else
        puts "Gear sudah maksimal"
        false
      end
    else
      if @gear<5 
        true
      else
        puts "Gear sudah maksimal"
        false
      end
    end
  end

  def check_min_gear
    if type<150
      if @gear<=4 && @gear>1
        true
      else
        puts "Gear sudah paling rendah"
        false
      end
    else
      if @gear<=5 && @gear>1
        true
      else
        puts "Gear sudah paling rendah"
        false
      end
    end
  end


  def up_gear
    if check_max_gear
        @gear+=1
        puts "Saat ini ada naik ke gear #{@gear}"
        @gear
        @speed+=(5*1000/3600)
    end
  end

  def down_gear
    if check_min_gear
      @gear-=1
      puts "Saat ini ada turun ke gear #{@gear}"
      @gear
      @speed-=(5*1000/3600)
    end
  end

  def check_type(type) # check type with INTEGER input
    if type == 110
      @speed = (20*1000/3600)
      true
    elsif type == 120
      @speed = (40*1000/3600)
      true
    elsif type == 250
      @speed = (60*1000/3600)
      true
    elsif type == 300
      @speed = (70*1000/3600)
      true
    else
      puts "Motor sport dengan tipe #{type} cc tidak tersedia"
      false
    end
  end
end