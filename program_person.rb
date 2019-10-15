load 'person.rb'

@selected_person = nil

# collect person.csv
table = CSV.parse(File.read("person.csv"), headers: true, header_converters: :symbol)
table.each{|x| @selected_person = Person.new(name: x[:name], money: x[:money].to_i, capacity: x[:garage_capacity].to_i)}

# collect list of vehicle in garage
vehicle_table = CSV.parse(File.read("motors_cars.csv"), headers: true, header_converters: :symbol)
vehicle_table.each do |x| 
  type = x[:type]
  if type == "motor"
    Motor.new(name: x[:name], fuel_capacity: x[:fuel_capacity].to_i, speed: x[:speed].to_i, space: x[:space].to_i, price: x[:price].to_i)
  else
    Car.new(name: x[:name], fuel_capacity: x[:fuel_capacity].to_i, speed: x[:speed].to_i, space: x[:space].to_i, price: x[:price].to_i)
  end
end

# collect list of person
file = File.read("person.json")
persons = JSON.parse(file)
persons.collect do |x| 
  Person.new(name: x["name"] , money: x["money"].to_i , capacity:  x["capacity"].to_i)
  garage =  x["list_garage"]
  garage.collect do |x| 
    type = x["type"]
    if type == "motor"
      Motor.new(name: x["name"], fuel_capacity: x["fuel_capacity"].to_i, speed: x["speed"].to_i, space: x["space"].to_i, price: x["price"].to_i)
    elsif type == "car"
      Car.new(name: x["name"], fuel_capacity: x["fuel_capacity"].to_i, speed: x["speed"].to_i, space: x["space"].to_i, price: x["price"].to_i)
    end
  end
end

# collect list of motor
file = File.open("motor.json")
file_data = file.read
json = JSON.parse(file_data)

json.collect{|x| Motor.new(name: x["name"], fuel_capacity: x["fuel_capacity"].to_i, speed: x["speed"].to_i, space: x["space"].to_i, price: x["price"].to_i)}

def check_person
  if @selected_person != nil
    true
  else
    puts "Pilih person terlebih dahulu"
    false
  end
end

loop do

  if @selected_person!=nil
    puts "\nSaat ini person adalah #{@selected_person.name} dengan uang #{@selected_person.money}"
  end

  puts "\n1. Buat Person\n2. Update Person\n3. Hapus Person\n4. Pilih Person\n5. Lihat Semua Person\n6. Tambah Kendaraan ke garage\n7. Pilih Kendaraan dari garage\n8. Hapus Kendaraan dari garage\n9. Lihat Semua Kendaraan di garage\n10. Buat list person ke JSON\n11. Buat list motor ke CSV\n12. Delivery package\nTulis exit untuk keluar dari program"
  puts "\nInput pilihan anda"
  input = gets.chomp
 
  case input
  when "1"
    puts "Input nama person"
    name_input = gets.chomp
    
    if name_input == nil 
      puts "Masukkan nama person"
    else
      @selected_person = Person.new(name_input)
    end

  when "2"
    puts "Input nama person yang ingin diupdate"
    name_input = gets.chomp
    Person.name = name_input
   
  when "3"
    if check_person
      puts "Input nama person yang ingin dihapus"
      name_input = gets.chomp

      if @selected_person.name == name_input
        @selected_person.destroy(name_input)
        @selected_person = nil
      else
        @selected_person.destroy(name_input)
      end
    end
  
  when "4"
    if check_person
      puts "Input nama person yang ingin dipilih"
      name_input = gets.chomp
      selected = @selected_person.select_person(name_input)
      @selected_person = selected
    end
  
  when "5"
    Person.all

  when "6"
    if check_person
      puts "Input kendaraan yang ingin ditambah ke garage"
      motor_input = gets.chomp
      @selected_person.buy(motor_input)
    end

  when "7"
    if check_person
      if @selected_person.show_garage
        puts "Pilih kendaraan dari garage"
        select_input = gets.chomp
      
        @selected_motor = @selected_person.select_motor(select_input)
        @selected_motor.fill_gas(1000) #isi bensin supaya bisa delivery
        @selected_motor
      end
    end

  when "8"
    if check_person
      if @selected_person.show_garage
        puts "Input kendaraan yang ingin dihapus dari garage"
        select_input = gets.chomp
        @selected_person.remove(select_input)
      end
    end

  when "9"
    if check_person
      @selected_person.show_garage
    end

  when "10"
    if check_person
      j = Person.all.map do |x|
        {:name => "#{x.name}", :money => "#{x.money}", :capacity => "#{x.garage.capacity}"}
      end
        
      File.open("list_person.json","w") do |f|
        f << j.to_json
      end

      puts "List person berhasil disimpan dalam list_person.json"
    end


  when "11"
    if check_person
      motors = Motor.all.map{|x| [x.name,x.fuel_capacity,x.speed,x.space,x.price]}

      CSV.open("list_motor.csv","w") do |csv|
        csv << ["name","fuel_capacity","speed","space","price"]
        motors.each do |motor|
          csv << [motor.name, motor.fuel_capacity, motor.speed, motor.space, motor.price]
        end
      end

      puts "CSV file list motor berhasil dibuat dalam list_motor.csv"
    end

  when "12"
    if check_person
      if @selected_motor!=nil
        duration = rand(10..120)
        puts "Durasi perjalanan yang akan ditempuh adalah #{duration} detik"
        if @selected_motor.run(duration) !=false
          wage = duration*10
          @selected_person.money+=wage
          puts "Setelah delivery selama #{duration} detik, uang bertambah menjadi $#{@selected_person.money}"
        end
      else
        puts "Pilih motor dulu"
      end
    end
  
  when "exit"
    puts "\nAnda keluar dari program"
    return
  
  else puts "Invalid command\n"
  end
end

