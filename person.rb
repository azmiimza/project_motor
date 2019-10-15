require_relative "garage"
require "csv"
require "json"

class Person
  attr_accessor :name, :garage, :money, :selected_motor
  @@persons = []


  def initialize(name: , money: , capacity: )
    @name =  name
    @garage = Garage.new
    @@persons.push(self)
    @money = money
    @garage.capacity = capacity
  end

  def add(name)
    @garage.add(name)
  end

  def buy(name)
    vehicle = Motor.find(name)
    if vehicle == nil
      vehicle = Car.find(name)
      
      if vehicle!=nil
        price = vehicle.price
        space = vehicle.space
        
        if @money>=price
          if self.add(name)
            @money-=price
            puts "Uang anda berkurang menjadi #{@money}"
          end
        else
          puts "Uang tidak cukup"
        end
      end
    else
      puts "Kendaraan tidak ada dalam list"
      return
    end
  
  end

  def sell(name)
    motor = self.find_motor(name)
    if motor!=nil
      sell_price = (motor.price)/2
      @money+=sell_price
      @garage.destroy(name)
      puts "Uang #{@name} bertambah menjadi #{money} dan space garage menjadi #{@garage.capacity}"
    else
      puts "Motor tidak ada dalam garage"
    end
  end

  def select_person(name)
    selected = @@persons.find {|person| person.name==name}
    if selected != nil
      puts "Person #{selected.name} dipilih"
      selected
    else
      puts "Person #{name} tidak ada dalam list"
    end
  end

  def show_garage
    # selected = self.find_person(@selected_person)
    motor = self.garage.motors_cars.collect {|motor| motor.name}

    if motor.any?
      puts "Kendaraan dalam garage : "
      puts motor.join(", ")
      true
    else
      puts "Garage #{@name} masih kosong"
      false
    end
  end

  def self.all
    person = @@persons.collect {|person| person.name}

    if person.any?
      puts person.join(", ")
      @@persons # to return array of objects
    else
      puts "List person kosong"
    end
  end

  def find_motor(name)
    @garage.find(name)
  end

  def destroy(name)
    selected = @@persons.find {|person| person.name==name}
    if selected!=nil
      @@persons -= [selected]
      puts "#{name} berhasil dihapus dari list"
    else
      puts "#{name } tidak ada dalam list"
    end
  end

  def remove(motor_name)
    @garage.destroy(motor_name) 
    puts "Motor #{motor_name} berhasil dihapus dari garage" 
    # if name==@selected.name
    #   @selected = nil
    # end
  end

  def select_motor(name)
    selected = @garage.find(name)
    if selected != nil 
      puts "Motor #{selected.name} terpilih"
      @selected_motor = selected

    else
      puts "Belum ada motor #{name} dalam garage"
 
    end
  end


end



