class PatientController < ApplicationController
  def index
    #Fetch the correct Patient by patient_id    

  end

  def metrics
    #Fetch summary data by patient_id 
    @bloodOxygen = BloodOxygenReading.last_week

  
    #redirect to metrics

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
