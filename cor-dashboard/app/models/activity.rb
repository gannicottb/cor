class Activity < ActiveRecord::Base

	attr_accessible :patient_id, :date, 
									:minutes_asleep, :number_of_awakenings,
									:sleep_efficiency, :steps,
      						:sedentary_minutes, :lightly_active_minutes,
      						:fairly_active_minutes, :very_active_minutes,
      						:created_date
	belongs_to :patient

	if Rails.env.production?
    self.table_name = "activity_daily_data"
  end

  scope :last_week, -> {where(date: 1.week.ago .. Time.now)}

end
