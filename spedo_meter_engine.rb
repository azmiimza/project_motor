module SpedoMeterEngine
  #   display_velocity_in_kmph return velocity in KM/h
  def display_velocity_in_kmph
    puts "Kecepatan saat ini adalah #{(self.speed)*3.6} km/h"
  end
  # display_velocity_in_mph return velocity in M/h
  def display_velocity_in_mph
    puts "Kecepatan saat ini adalah #{(self.speed)*3.6*1000} m/h"
  end
  # display_distance_in_km return distance_traveled in KM
  def display_distance_in_km
    puts "Total jarak yang ditempuh adalah #{(self.total_dist)/1000} km"
  end
  # display_distance_in_mile return distance_traveled in Mile
  def display_distance_in_mile
    puts "Total jarak yang ditempuh adalah #{(self.total_dist/1000/1.60934).floor(3)} mile"
  end
  # 1 mile = 1.60934 KM (source from google)
end