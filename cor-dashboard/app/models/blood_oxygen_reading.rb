class BloodOxygenReading < ActiveRecord::Base
	
	def current
		#return most current reading
	end

	def last_week
		#return a hash of readings from past 7 days
	end
end
