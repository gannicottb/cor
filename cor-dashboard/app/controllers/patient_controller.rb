class PatientController < ApplicationController

  respond_to :html
  def index
    #Fetch the correct Patient by patient_id    

  end

  def metrics
    #Fetch summary data by patient_id 
    @patient = Patient.find(2)
    #@bloodOxygen = @patient.BloodOxygenReading.last_week
    #bloodOxygenReadings = @patient.blood_oxygen_readings.select("bo_perc, reading_time").where(:reading_time, 1.week.ago .. Time.now)
    #bloodOxygenThreshold = @patient.threshold_values.bo_perc
    @threshold = @patient.threshold_values.bo_perc   
    #@timestamps = []
    #@data = @patient.blood_oxygen_readings.select("bo_perc").where(:reading_time, 1.week.ago .. Time.now)
    @values = []
    @dates = []
    readings = @patient.blood_oxygen_readings
    readings.each do |reading|
      @values << reading.bo_perc
      @dates << reading.reading_time.utc.to_i*1000
    end
    #@timestamps = @patient.blood_oxygen_readings..select("reading_time").where(:reading_time, 1.week.ago .. Time.now)
    #@result[:threshold] = @patient.threshold_values.bo_perc
    #@result[:data] = @patient.blood_oxygen_readings.select("bo_perc, reading_time").where(:reading_time, 1.week.ago .. Time.now)
    

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
