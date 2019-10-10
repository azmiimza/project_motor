load 'motor.rb'

@selected_motor = nil

def check_motor
  if @selected_motor != nil
    true
  else
    puts "Pilih motor terlebih dahulu"
    false
  end
end

loop do
  puts "\n1. Buat Motor\n2. Pilih Motor\n3. Hapus Motor\n4. Tampilkan Semua Motor\n5. Detail Motor\n6. Isi Bensin Motor\n7. Jalankan Motor\n8. Reset Status Motor\n9. Ubah Nama Motor\n10. Ubah Kecepatan Motor\n11. Ubah Kapasitas Bensin Motor\n12. Press Horn\nTulis exit untuk keluar dari program"
  puts "\nInput pilihan anda"
  input = gets.chomp
 
  case input
  when "1"
    puts "Input nama motor"
    name_input = gets.chomp
    puts "Input fuel capacity motor"
    fuel_input = gets.chomp.to_i
    puts "Input kecepatan motor"
    speed_input = gets.chomp.to_i
    @selected_motor = Motor.create(name: name_input, fuel_capacity: fuel_input, speed: speed_input)

  when "2"
    puts "Input nama motor yang ingin dipilih"
    name_input = gets.chomp
    @selected_motor = Motor.find(name_input)
   
  when "3"
    if check_motor
      puts "Input nama motor yang ingin dihapus"
      name_input = gets.chomp

      if @selected_motor.name == name_input
        Motor.destroy(name_input)
        @selected_motor = nil
      else
        Motor.destroy(name_input)
      end
    end
  
  when "4"
    Motor.all
  
  when "5"
    if check_motor
      puts "\nNama motor adalah #{@selected_motor.name}"
      puts "Kapasitas bensin motor adalah #{@selected_motor.fuel_capacity} liter"
      puts "Kecepatan motor adalah #{@selected_motor.speed} m/s"
      puts "Total waktu yang ditempuh adalah #{@selected_motor.total_time} detik"
      puts "Total jarak yang ditempuh adalah #{@selected_motor.total_dist} meter"
      puts "Bensin yang tersisa ada #{@selected_motor.fuel_left} liter"
    end

  when "6"
    if check_motor
      puts "Input bensin yang ingin diisi"
      gas_input = gets.chomp.to_i
      @selected_motor.fill_gas(gas_input)
    end

  when "7"
    if check_motor
      puts "Input waktu perjalanan"
      time_input = gets.chomp.to_i
      @selected_motor.run(time_input)
    end

  when "8"
    if check_motor
      @selected_motor.reset
    end

  when "9"
    if check_motor
      puts "Input nama motor baru"
      name_input = gets.chomp
      @selected_motor.name = name_input
    end

  when "10"
    if check_motor
      puts "Input kecepatan baru"
      speed_input = gets.chomp.to_i
      @selected_motor.speed = speed_input
    end

  when "11"
    if check_motor
      puts "Input kapasitas bensin baru"
      fuel_input = gets.chomp.to_i
      @selected_motor.fuel_capacity = fuel_input
      @selected_motor.fuel_left = fuel_input
    end

  when "12"
    if check_motor
      @selected_motor.horn
    end
  
  when "exit"
    puts "\nAnda keluar dari program"
    return
  
  else puts "Invalid command\n"
  end
end

