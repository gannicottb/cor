class Patient < ActiveRecord::Base

    attr_accessible :physician_id
    
		belongs_to :physician

    has_many :blood_oxygen_readings
    has_many :heart_rate_readings
    has_many :weight_readings
    has_many :blood_pressure_readings   
    has_many :emas
    has_many :alerts
    has_one :threshold_values

    if Rails.env.production?
      self.table_name = "patient_info"
    end

  def blood_oxygen  	     
    return {threshold: threshold_values.bo_perc, 
    				values: blood_oxygen_readings.last_week.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}  	
  end

  def heart_rate    
    r = heart_rate_readings.first
  	return {threshold: eval(threshold_values.heart_rate), 
    				values: [r.reading_time.utc.to_i*1000, r.heart_rate] }  
  end

  def weight
  	return {threshold: eval(threshold_values.weight),
    				values: weight_readings.last_2_weeks.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}  	  
  end

	def blood_pressure
		r = blood_pressure_readings.first
		return {threshold: {:systolic => eval(threshold_values.systolic_bp), 
                  			:diastolic =>eval(threshold_values.diastolic_bp)} ,
    				values: [r.reading_time.utc.to_i*1000, r.systolic_bp, r.diastolic_bp] }
	end

  def scanForAlerts
    #Check all recent readings with threshold values and create Alerts
    #for each blood oxygen reading, compare with threshold 
    blood_oxygen_readings.each do |r|
      if !alerts.exists?(reading_id: r.id)
        if r.bo_perc < threshold_values.bo_perc
          #create a new alert for this patient
          Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Blood Oxygen is under threshold")
        end  
      end
    end

    heartRateThreshValues = eval(threshold_values.heart_rate)
    heart_rate_readings.each do |r|      
      if !alerts.exists?(reading_id: r.id)
        if r.heart_rate >= heartRateThreshValues[:high] 
          #create a new alert for this patient
          Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Heart Rate above threshold")
        end  
        if r.heart_rate <= heartRateThreshValues[:low]
          #create a new alert for this patient
          Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Heart Rate below threshold")        
        end
      end
    end

    blood_oxygen_readings.each do |r|
      if !alerts.exists?(reading_id: r.id)
        if r.bo_perc < threshold_values.bo_perc
          #create a new alert for this patient
          Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Blood Oxygen is under threshold")
        end  
      end
    end
    return alerts
  end

end
