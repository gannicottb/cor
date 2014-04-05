class Patient < ActiveRecord::Base
		belongs_to :physician

    has_many :blood_oxygen_readings
    has_many :heart_rate_readings
    has_many :weight_readings
    has_many :blood_pressure_readings   
    has_many :emas
    has_one :threshold_values

    if Rails.env.production?
      self.table_name = "patient_info"
    end

  def get_blood_oxygen  	     
    return {threshold: threshold_values.bo_perc, 
    				values: blood_oxygen_readings.last_week.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}  	
  end

  def get_heart_rate
    reading = heart_rate_readings.first
  	return {threshold: {high: threshold_values.heart_rate, low: 50}, 
    				values: [reading.reading_time.utc.to_i*1000, reading.heart_rate] }  
  end

  

end
