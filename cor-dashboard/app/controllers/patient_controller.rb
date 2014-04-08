class PatientController < ApplicationController

  respond_to :html, :js
  
  def metrics
    #Fetch summary data by patient_id 
    @patient = Patient.take
    #THE PATIENT ID IS HARD CODED FOR NOW
  end

  def blood_oxygen
    patient = Patient.take  
    bundle = patient.blood_oxygen
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  def heart_rate   
    patient = Patient.take        
    bundle = patient.heart_rate
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  def weight
    patient = Patient.take      
    bundle = patient.weight
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  def sodium
    patient = Patient.take 
    bundle = patient.sodium
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  def blood_pressure
    patient = Patient.take         
    bundle = patient.blood_pressure
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  def medication    
  end

  def cough
  end

  def alerts
    #Fetch alert data by patient_id    
    #redirect to alerts
  end

  def patient_plan
    #Fetch patient_plan data by patient_id    
    #redirect to patient_plan
  end

  def activity_log
    #Fetch activity_log data by patient_id    
    #redirect to activity_log
  end

  def settings
    #Fetch settings data by patient_id    
    #redirect to settings
  end
end
