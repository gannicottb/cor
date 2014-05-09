#The controller class for the patient dashboard
class PatientController < ApplicationController

  respond_to :html, :js

  #Fetch summary data by patient_id by default
  def metrics
    #@patient = Patient.find(params[:id]) 
    @patient = Patient.take
    #Have to get this data here too, since we start with health summary
    @values = @patient.health_summary
  end

  #Fetch summary data by patient_id
  def health_summary
    patient = Patient.take
    @values = patient.health_summary
  end

  #Fetch blood oxygen data by patient_id over default time period
  def blood_oxygen
    patient = Patient.take  
    bundle = patient.blood_oxygen
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  #Fetch heart rate data by patient_id over default time period
  def heart_rate   
    patient = Patient.take        
    bundle = patient.heart_rate
    @threshold = bundle[:threshold]
    @values = bundle[:values]
    @variability = bundle[:variability]
  end

  #Fetch weight data by patient_id over default time period
  def weight
    patient = Patient.take      
    bundle = patient.weight
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  #Fetch sodium data by patient_id over default time period
  def sodium
    patient = Patient.take 
    bundle = patient.sodium
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  #Fetch blood pressure data by patient_id over default time period
  def blood_pressure
    patient = Patient.take         
    bundle = patient.blood_pressure
    @threshold = bundle[:threshold]
    @values = bundle[:values]
  end

  #Fetch medication data by patient_id over default time period -- To be implemented
  def medication    
  end

  #Fetch cough data by patient_id over default time period -- To be implemented
  def cough
  end

  #Fetch alerts data by patient_id
  def alerts
    @patient = Patient.take
    @alerts = @patient.scanForAlerts
    #redirect to alerts
  end

  #Fetch patient_plan data by patient_id -- To be implemented
  def patient_plan
    #redirect to patient_plan
  end

  #Fetch activity log data by patient_id over default time period
  def activity_log
    #redirect to activity_log
    @patient = Patient.take
    @exercise_log = @patient.activity_log[:exercise]
  end

  #Fetch exercise log data by patient_id over default time period
  def exercise_log
    @patient = Patient.take
    @exercise_log = @patient.activity_log[:exercise]
  end

  #Fetch settings data by patient_id -- To be implemented
  def settings
    #redirect to settings
    @patient = Patient.take
  end
end
