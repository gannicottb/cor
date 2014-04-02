class BloodPressureReading < ActiveRecord::Base
	attr_accessible :patient_id, :bp_sensor_id, :systolic_bp, :diastolic_bp, :reading_time, :created_date
	belongs_to :patient

  if Rails.env.production?
    self.table_name = "blood_pressure_raw"
    alias_attribute :systolic_bp, :systolic
    alias_attribute :diastolic_bp, :diastolic
  end

	def current
		BloodPressureReading.take
	end

end
