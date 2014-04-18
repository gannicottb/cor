class Alert < ActiveRecord::Base
	attr_accessible :patient_id, :resolved, :reading_id, :created_date, :text
	belongs_to :patient

end
