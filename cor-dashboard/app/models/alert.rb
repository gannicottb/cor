class Alert < ActiveRecord::Base
	attr_accessible :patient_id, :resolved_physician, :resolved_patient, :urgent, :reading_id, :created_date, :text
	belongs_to :patient
	
	def unresolved_and_not_urgent
		exists?({resolved_physician: false, urgent: false})
	end

	def unresolved_and_urgent
		exists?({resolved_physician: false, urgent: true})
	end


end
