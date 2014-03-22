class PatientController < ApplicationController

  respond_to :html
  def index
    #Fetch the correct Patient by patient_id    

  end

  def metrics
    #Fetch summary data by patient_id 
    @patient = Patient.find(1)
    #@bloodOxygen = @patient.BloodOxygenReading.last_week
    #bloodOxygenReadings = @patient.blood_oxygen_readings.select("bo_perc, reading_time").where(:reading_time, 1.week.ago .. Time.now)
    #bloodOxygenThreshold = @patient.threshold_values.bo_perc
    @result = {}
    @result[:threshold] = @patient.threshold_values.bo_perc
    @result[:data] = @patient.blood_oxygen_readings.select("bo_perc, reading_time").where(:reading_time, 1.week.ago .. Time.now)
  

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
