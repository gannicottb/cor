class PatientController < ApplicationController

  respond_to :html, :js
  
  def metrics
    #Fetch summary data by patient_id 
    @patient = Patient.take
    #THE PATIENT ID IS HARD CODED FOR NOW, CHANGE TO WHATEVER PATIENT YOU HAVE LOCALLY
    #redirect to metrics
  end

  def blood_oxygen
    @patient = Patient.take
    @threshold = @patient.threshold_values.bo_perc
    @values = []    
    readings = @patient.blood_oxygen_readings
    readings.each do |reading|
      @values << [reading.reading_time.utc.to_i*1000, reading.bo_perc]     
    end
  end
    #redirect to metrics

  def heart_rate
     #Fetch summary data by patient_id
     #THE PATIENT ID IS HARD CODED FOR NOW, CHANGE TO WHATEVER PATIENT YOU HAVE LOCALLY
     @patient = Patient.take
     @threshold = @patient.threshold_values.heart_rate
     @values = []
     readings = @patient.heart_rate_readings
     readings.each do |reading|
       @values << [reading.reading_time.utc.to_i*1000, reading.heart_rate]
     end
  end

  def weight
    @patient = Patient.take  
    @threshold = {weight: @patient.threshold_values.weight, time: 7}  #hard coded number of days for now      
    @values = []
    readings = @patient.weight_readings
    readings.each do |reading|
      @values << [reading.reading_time.utc.to_i*1000, reading.weight]     
    end 
  end

  def sodium
    @patient = Patient.take
    @threshold = @patient.threshold_values.sodium
    @values = []
    readings = @patient.emas
    readings.each do |reading|
      @values << [reading.reading_time.utc.to_i*1000, reading.sodium]     
    end  

  end

  def blood_pressure
    @patient = Patient.take
    @threshold = {:systolic => {high: @patients.threshold_values.systolic_bp, low: 90}, 
                  :diastolic =>{high: @patient.threshold_values.diastolic_bp, low: 60}}
    @values = []
    readings = @patient.blood_pressure_readings
    readings.each do |reading|
      @values << [reading.reading_time.utc.to_i*1000, reading.systolic_bp, reading.diastolic_bp]     
    end 
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
