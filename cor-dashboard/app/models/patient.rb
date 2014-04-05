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

  def blood_oxygen  	     
    return {threshold: threshold_values.bo_perc, 
    				values: blood_oxygen_readings.last_week.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}  	
  end

  def heart_rate
    r = heart_rate_readings.first
  	return {threshold: {high: threshold_values.heart_rate, low: 50}, 
    				values: [r.reading_time.utc.to_i*1000, r.heart_rate] }  
  end

  def weight
  	return {threshold: {weight: threshold_values.weight, time: 4},
    				values: weight_readings.last_2_weeks.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}  	  
  end

	def sodium
		return {threshold: threshold_values.sodium,
    				values: emas.map {|r| [r.reading_time.utc.to_i*1000, r.sodium] }}		
	end

	def blood_pressure
		r = blood_pressure_readings.first
		return {threshold: {:systolic => {high: threshold_values.systolic_bp, low: 90}, 
                  			:diastolic =>{high: threshold_values.diastolic_bp, low: 60}} ,
    				values: [r.reading_time.utc.to_i*1000, r.systolic_bp, r.diastolic_bp] }
	end
end
