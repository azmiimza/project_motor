load 'car.rb'
require_relative "horn"
require_relative "spedo_meter_engine"

@selected_car = nil

def check_car
  if @selected_car != nil
    true
  else
    puts "Pilih mobil terlebih dahulu"
    false
  end
end

loop do
  puts "\n1. Buat Mobil\n2. Pilih Mobil\n3. Hapus Mobil\n4. Tampilkan Semua Mobil\n5. Detail Mobil\n6. Isi Bensin Mobil\n7. Jalankan Mobil\n8. Reset Status Mobil\n9. Ubah Nama Mobil\n10. Ubah Kecepatan Mobil\n11. Ubah Kapasitas Bensin Mobil\n12. Press Horn\n13. SpedoMeterEngine\nTulis exit untuk keluar dari program"
  puts "\nInput pilihan anda"
  input = gets.chomp
 
  case input
  when "1"
    puts "Input nama mobil"
    name_input = gets.chomp
    puts "Input fuel capacity mobil"
    fuel_input = gets.chomp.to_i
    puts "Input kecepatan mobil"
    speed_input = gets.chomp.to_i
    @selected_car = Car.create(name: name_input, fuel_capacity: fuel_input, speed: speed_input)

  when "2"
    puts "Input nama mobil yang ingin dipilih"
    name_input = gets.chomp
    @selected_car = Car.find(name_input)
   
  when "3"
    if check_car
      puts "Input nama mobil yang ingin dihapus"
      name_input = gets.chomp

      if @selected_car.name == name_input
        Car.destroy(name_input)
        @selected_car = nil
      else
        Car.destroy(name_input)
      end
    end
  
  when "4"
    Car.all
  
  when "5"
    if check_car
      puts "\nNama mobil adalah #{@selected_car.name}"
      puts "Kapasitas bensin adalah #{@selected_car.fuel_capacity} liter"
      puts "Kecepatan mobil adalah #{@selected_car.speed} m/s"
      puts "Total waktu yang ditempuh adalah #{@selected_car.total_time} s"
      puts "Total jarak yang ditempuh adalah #{@selected_car.total_dist} m"
      puts "Bensin yang tersisa ada #{@selected_car.fuel_left} liter"
    end

  when "6"
    if check_car
      puts "Input bensin yang ingin diisi"
      gas_input = gets.chomp.to_i
      @selected_car.fill_gas(gas_input)
    end

  when "7"
    if check_car
      puts "Input waktu perjalanan"
      time_input = gets.chomp.to_i
      @selected_car.run(time_input)
    end

  when "8"
    if check_car
      @selected_car.reset
    end

  when "9"
    if check_car
      puts "Input nama mobil baru"
      name_input = gets.chomp
      @selected_car.name = name_input
    end

  when "10"
    if check_car
      puts "Input kecepatan baru"
      speed_input = gets.chomp.to_i
      @selected_car.speed = speed_input
    end

  when "11"
    if check_car
      puts "Input kapasitas bensin baru"
      fuel_input = gets.chomp.to_i
      @selected_car.fuel_capacity = fuel_input
      @selected_car.fuel_left = fuel_input
    end

  when "12"
    if check_car
      @selected_car.press_horn
    end

  when "13"
    if check_car
      @selected_car.spedo
    end
  
  when "exit"
    puts "\nAnda keluar dari program"
    return
  
  else puts "Invalid command\n"
  end
end

