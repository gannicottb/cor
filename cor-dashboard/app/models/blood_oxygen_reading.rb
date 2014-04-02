class BloodOxygenReading < ActiveRecord::Base
	
	attr_accessible :patient_id, :bo_sensor_id, :bo_perc, :reading_time, :created_date
	belongs_to :patient

  if Rails.env.production?
    self.table_name = "blood_oxygen_raw"
  end

	def current
		#return most current reading

	end
	scope :last_week, -> {where(:reading_time, 1.week.ago .. Time.now)}
	
end
