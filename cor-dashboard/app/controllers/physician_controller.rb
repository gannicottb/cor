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
    @physician = Physician.take
    @patients = @physician.patients
    patient = Patient.take
    bundle = patient.weight
    @threshold_wt = bundle[:threshold]
    @values_wt = bundle[:values]
    bundle = patient.blood_oxygen
    @threshold_bo = bundle[:threshold]
    @values_bo = bundle[:values]
    bundle = patient.heart_rate
    @threshold_hr = bundle[:threshold]
    @values_hr = bundle[:values]
    #bundle = patient.sodium
    #@threshold_so = bundle[:threshold]
    #@values_so = bundle[:values]
    bundle = patient.blood_pressure
    @threshold_bp = bundle[:threshold]
    @values_bp = bundle[:values]
  end


end