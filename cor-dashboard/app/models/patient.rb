class Patient < ActiveRecord::Base
    has_many :blood_oxygen_readings
    has_many :weight_readings
    has_many :blood_pressure_readings   
    has_many :emas
    has_one :threshold_values    
end
