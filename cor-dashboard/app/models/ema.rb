class Ema < ActiveRecord::Base
	attr_accessible :patient_id, :temperature, :sodium_level, :quality_of_sleep, :reading_time

	scope :last_week, -> {where(:reading_time, 1.week.ago .. Time.now)}
end
