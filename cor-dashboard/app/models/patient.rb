class Patient < ActiveRecord::Base
    has_many :blood_oxygen_readings
end
