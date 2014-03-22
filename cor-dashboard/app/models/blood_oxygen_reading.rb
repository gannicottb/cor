class BloodOxygenReading < ActiveRecord::Base
	
	attr_accessible :patient_id, :bo_sensor_id, :bo_perc, :reading_time, :created_date
	belongs_to :patient

	def current
		#return most current reading

	end

	def last_week		#return an array of readings from past 7 days
		bloodOxygenReadings = current_user.patient.blood_oxygen_readings.select("bo_perc, reading_time").where(:reading_time, 1.week.ago .. Time.now)
		bloodOxygenThreshold = current_user.patient.threshold_values.bo_perc
		result = {}
		result[:threshold] = bloodOxygenThreshold
		result[:data] = bloodOxygenReadings

		return result
		

		#MySQL Query: select from bo_perc, reading_time where reading_time is in range blah\
		#{
		#:threshold -> 90
		#:data -> [[timestamp, reading],[timestamp, reading]..]
	  #}
	end
end
