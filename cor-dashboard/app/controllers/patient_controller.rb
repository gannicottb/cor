class PatientController < ApplicationController

  respond_to :html
  def index
    #Fetch the correct Patient by patient_id    

  end

  def metrics
    #Fetch summary data by patient_id 
    #THE PATIENT ID IS HARD CODED FOR NOW, CHANGE TO WHATEVER PATIENT YOU HAVE LOCALLY
    #redirect to metrics
  end

  def blood_oxygen
    @patient = Patient.find(2)
    @threshold = @patient.threshold_values.bo_perc  
    @values = []    
    readings = @patient.blood_oxygen_readings
    readings.each do |reading|
      @values << [reading.reading_time.utc.to_i*1000, reading.bo_perc]     
    end   

  end

  def weight
    @patient = Patient.find(2)    
    @threshold = [@patient.threshold_values.weight, 7]  #hard coded number of days for now      
    @values = []
    readings = @patient.weight_readings
    readings.each do |reading|
      @values << [reading.reading_time.utc.to_i*1000, reading.weight]     
    end    

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
