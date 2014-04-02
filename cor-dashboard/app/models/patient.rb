class Patient < ActiveRecord::Base
    has_many :blood_oxygen_readings
    has_many :heart_rate_readings
    has_many :weight_readings
    has_many :blood_pressure_readings   
    has_many :emas
    has_one :threshold_values

    if Rails.env.production?
      self.table_name = "patient_info"
    end
end
