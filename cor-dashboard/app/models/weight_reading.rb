class WeightReading < ActiveRecord::Base

	attr_accessible  :patient_id, :weight, :hydration, :reading_time, :created_date, :weight_monitor_id
	belongs_to :patient

  if Rails.env.production?
    self.table_name = "weight_table"
  end

	def current
		#return most current reading

	end
	scope :last_week, -> {where(:reading_time, 1.week.ago .. Time.now)}
	
end
