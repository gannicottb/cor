class HeartRateReading < ActiveRecord::Base
  attr_accessible :patient_id, :hr_sensor_id, :heart_rate, :heart_rate_variability, :reading_time
  belongs_to :patient

  if Rails.env.production?
    self.table_name = "heart_rate"
  end

  scope :last_week, -> {where(reading_time: 1.week.ago .. Time.now)}
  scope :last_month, -> {where(reading_time: 1.month.ago .. Time.now)}
  scope :three_months, -> {where(reading_time: 3.months.ago .. Time.now)}
  scope :six_months, -> {where(reading_time: 6.months.ago .. Time.now)}
end
