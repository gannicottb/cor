class BloodPressureReading < ActiveRecord::Base
	attr_accessible :patient_id, :bp_sensor_id, :systolic_bp, :diastolic_bp, :reading_time, :created_date
	belongs_to :patient

	def current
		BloodPressureReading.take
	end

end
