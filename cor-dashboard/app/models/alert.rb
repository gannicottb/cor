class Alert < ActiveRecord::Base
	attr_accessible :patient_id, :resolved, :reading_id, :created_date
	belongs_to :patient

end
