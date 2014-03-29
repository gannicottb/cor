class Patient < ActiveRecord::Base
    has_many :blood_oxygen_readings, :weight_readings
    has_one :threshold_values
end
