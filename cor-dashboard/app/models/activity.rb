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
    alias_attribute :sedentary_minutes, :Sedentary_minutes
    alias_attribute :lightly_active_minutes, :Lightly_Active_minutes
    alias_attribute :fairly_active_minutes, :Fairly_Active_minutes
    alias_attribute :steps, :Steps
    alias_attribute :date, :Date
    alias_attribute :sleep_efficiency, :Sleep_efficiency
    alias_attribute :number_of_awakenings, :Number_of_Awakenings
    alias_attribute :minutes_asleep, :Minutes_Asleep
  end

  #scope :last_week, -> {where(date: DateTime.now.beginning_of_week(start_day = :sunday) .. Time.now)}
  #scope :last_week, -> {where(date: DateTime.now.beginning_of_week(start_day = :sunday)..Time.now-1.day)}
  #scope :last_week, -> {where(date: DateTime.now.beginning_of_week(start_day = :sunday)..Time.now-3.days).order(date: :asc)}
  scope :last_week, -> {where(date: 1.week.ago..Time.now).order(date: :asc)}

end
