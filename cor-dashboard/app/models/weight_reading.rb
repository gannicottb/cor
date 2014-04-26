class WeightReading < ActiveRecord::Base

	attr_accessible  :patient_id, :weight, :hydration, :reading_time, :created_date, :weight_monitor_id
	belongs_to :patient

  if Rails.env.production?
    self.table_name = "weight_table"
  end

	def current
		#return most current reading

  end
  scope :last_week, -> {where(reading_time: 1.weeks.ago .. Time.now)}
	scope :last_2_weeks, -> {where(reading_time: 2.weeks.ago .. Time.now)}
  scope :last_month, -> {where(reading_time: 1.month.ago .. Time.now)}
  scope :three_months, -> {where(reading_time: 3.months.ago .. Time.now)}
  scope :six_months, -> {where(reading_time: 6.months.ago .. Time.now)}
end
