class HeartRateReading < ActiveRecord::Base
  attr_accessible :patient_id, :hr_sensor_id, :heart_rate, :heart_rate_variability, :reading_time
  belongs_to :patient

  if Rails.env.production?
    self.table_name = "heart_rate"
  end

  scope :last_week, -> {where(:reading_time, 1.week.ago .. Time.now)}
end
