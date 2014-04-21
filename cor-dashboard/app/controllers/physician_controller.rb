class PhysicianController < ApplicationController

	respond_to :html, :js

	def roster	
		@physician = Physician.take
		@patients = @physician.patients

	end 

	def critical_patients
		
	end

	def alerts
		
	end

	def patients
		
	end

	def settings
		
	end

	def summary
		@physician = Physician.take
		patient = @physician.patients.take
		@bundle = {}
		@bundle[:blood_oxygen] = patient.blood_oxygen
		@bundle[:heart_rate] = patient.heart_rate
		@bundle[:weight] = patient.weight
		@bundle[:sodium] = patient.sodium
		@bundle[:blood_pressure] = patient.blood_pressure
	end

	def detail
	end
		
end