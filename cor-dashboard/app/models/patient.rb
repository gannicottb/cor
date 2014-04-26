class Patient < ActiveRecord::Base

    attr_accessible :physician_id, :name
    
		belongs_to :physician

    has_many :blood_oxygen_readings
    has_many :heart_rate_readings
    has_many :weight_readings
    has_many :blood_pressure_readings   
    has_many :emas
    has_many :alerts
    has_many :activities
    has_one :threshold_values

    if Rails.env.production?
      self.table_name = "patient_info"
      alias_attribute :name, :patient_name
    end

    def summary

    end
    #Blood oxygen
    def blood_oxygen
      return {threshold: threshold_values.bo_perc,
              values: blood_oxygen_readings.last_week.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}
    end

    def blood_oxygen_last_2_weeks
      return {threshold: threshold_values.bo_perc,
              values: blood_oxygen_readings.last_2_weeks.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}
    end

    def blood_oxygen_last_month
      return {threshold: threshold_values.bo_perc,
              values: blood_oxygen_readings.last_month.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}
    end

    def blood_oxygen_last_three_months
      return {threshold: threshold_values.bo_perc,
              values: blood_oxygen_readings.last_three_months.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}
    end

    def blood_oxygen_last_six_months
      return {threshold: threshold_values.bo_perc,
              values: blood_oxygen_readings.last_six_months.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}
    end

    def blood_oxygen_last_year
      return {threshold: threshold_values.bo_perc,
              values: blood_oxygen_readings.last_year.map {|r| [r.reading_time.utc.to_i*1000, r.bo_perc] }}
    end

    #Heart Rate
    def heart_rate    
      r = heart_rate_readings.first
    	return {threshold: eval(threshold_values.heart_rate), 
      				values: [r.reading_time.utc.to_i*1000, r.heart_rate],
              variability: r.heart_rate_variability }  
    end

    def heart_rate_last_week
      return {threshold: eval(threshold_values.heart_rate),
              values: heart_rate_readings.last_week.map {|r| [r.reading_time.utc.to_i*1000, r.heart_rate] }}
    end


    def heart_rate_last_2_weeks
      return {threshold: eval(threshold_values.heart_rate),
              values: heart_rate_readings.last_2_weeks.map {|r| [r.reading_time.utc.to_i*1000, r.heart_rate] }}
    end

    def heart_rate_last_month
      return {threshold: eval(threshold_values.heart_rate),
              values: heart_rate_readings.last_month.map {|r| [r.reading_time.utc.to_i*1000, r.heart_rate] }}
    end

    def heart_rate_last_three_months
      return {threshold: eval(threshold_values.heart_rate),
              values: heart_rate_readings.last_three_months.map {|r| [r.reading_time.utc.to_i*1000, r.heart_rate] }}
    end

    def heart_rate_last_six_months
      return {threshold: eval(threshold_values.heart_rate),
              values: heart_rate_readings.last_six_months.map {|r| [r.reading_time.utc.to_i*1000, r.heart_rate] }}
    end

    def heart_rate_last_year
      return {threshold: eval(threshold_values.heart_rate),
              values: heart_rate_readings.last_year.map {|r| [r.reading_time.utc.to_i*1000, r.heart_rate] }}
    end
    # Weight
    def weight
      return {threshold: eval(threshold_values.weight),
              values: weight_readings.last_2_weeks.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}

    end

    def weight_last_week
      return {threshold: eval(threshold_values.weight),
              values: weight_readings.last_week.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}

    end

    def weight_last_month
      return {threshold: eval(threshold_values.weight),
              values: weight_readings.last_month.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}

    end

    def weight_last_three_months
      return {threshold: eval(threshold_values.weight),
              values: weight_readings.last_three_months.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}

    end

    def weight_last_six_months
      return {threshold: eval(threshold_values.weight),
              values: weight_readings.last_six_months.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}

    end

    def weight_last_year
      return {threshold: eval(threshold_values.weight),
              values: weight_readings.last_year.map {|r| [r.reading_time.utc.to_i*1000, r.weight] }}

    end

    # Sodium

    def sodium
        return {threshold: 0,
                values: emas.last_week.map {|r| [r.reading_time.utc.to_i*1000, sodiumStringToInt(r.sodium_level)] }}
    end

    def sodium_last_2_weeks
      return {threshold: 0,
              values: emas.last_2_weeks.map {|r| [r.reading_time.utc.to_i*1000, sodiumStringToInt(r.sodium_level)] }}
    end

    def sodium_last_month
      return {threshold: 0,
              values: emas.last_month.map {|r| [r.reading_time.utc.to_i*1000, sodiumStringToInt(r.sodium_level)] }}
    end

    def sodium_last_three_months
      return {threshold: 0,
              values: emas.last_three_months.map {|r| [r.reading_time.utc.to_i*1000, sodiumStringToInt(r.sodium_level)] }}
    end

    def sodium_last_six_months
      return {threshold: 0,
              values: emas.last_six_months.map {|r| [r.reading_time.utc.to_i*1000, sodiumStringToInt(r.sodium_level)] }}
    end

    def sodium_last_year
      return {threshold: 0,
              values: emas.last_year.map {|r| [r.reading_time.utc.to_i*1000, sodiumStringToInt(r.sodium_level)] }}
    end

    # Blood Pressure
    def blood_pressure
        r = blood_pressure_readings.last
        return {threshold: {:systolic => eval(threshold_values.systolic_bp),
                            :diastolic =>eval(threshold_values.diastolic_bp)} ,
        values: [r.reading_time.utc.to_i*1000, r.systolic_bp, r.diastolic_bp] }
    end

    def activity_log
      #Package up the data for the activity log page
      return  {exercise: {sedentary: activities.last_week.map {|r| r.sedentary_minutes},
                        lightly_active: activities.last_week.map {|r| r.lightly_active_minutes},
                        fairly_active: activities.last_week.map {|r| r.fairly_active_minutes},
                        very_active: activities.last_week.map {|r| r.very_active_minutes},
                        steps: activities.last_week.map {|r| r.steps},
                        days: activities.last_week.map{|r| r.date.strftime("%B %d")}
                        },
              sleep: {sleep_efficiency: activities.last_week.map {|r| r.sleep_efficiency},
                      number_of_awakenings: activities.last_week.map {|r| r.number_of_awakenings},
                      minutes: activities.last_week.map {|r| r.minutes_asleep}
                     }
              }
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

      thresholdSystolic = eval(threshold_values.systolic_bp)
      thresholdDiastolic = eval(threshold_values.diastolic_bp)

      blood_pressure_readings.each do |r|
        if !alerts.exists?(reading_id: r.id)
          if r.systolic_bp >= thresholdSystolic[:high]
            #create a new alert for this patient
            Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Blood Pressure (Systolic) is HIGH")
          end
          if r.systolic_bp <= thresholdSystolic[:low]
            #create a new alert for this patient
            Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Blood Pressure (Systolic) is LOW")
          end
          if r.diastolic_bp >= thresholdDiastolic[:high]
            #create a new alert for this patient
            Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Blood Pressure (Diastolic) is HIGH")
          end
          if r.diastolic_bp <= thresholdDiastolic[:low]
            #create a new alert for this patient
            Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Blood Pressure (Diastolic) is LOW")
          end
        end
      end

      emas.each do |r|
        if !alerts.exists?(reading_id: r.id)
          if r.sodium_level == "High"
            #create a new alert for this patient
            Alert.create(patient_id: id, resolved: false, reading_id: r.id, text: "Sodium Level is high")
          end
        end
      end

      relevant_weight_readings = weight_readings.where(reading_time: eval(threshold_values.weight)[:time].days.ago .. Time.now)
      if(relevant_weight_readings.maximum(:weight) - relevant_weight_readings.minimum(:weight)>=eval(threshold_values.weight)[:weight])
        #create a new alert for this patient
        Alert.create(patient_id: id, resolved: false, reading_id: relevant_weight_readings.where(weight: relevant_weight_readings.maximum(:weight)).first().id, text: "Change in weight has exceeded the threshold")
      end

      return alerts
    end

    def sodiumStringToInt(str)
      case str.downcase
      when "low"
        return 1
      when "medium"
        return 2
      when "high"
        return 3
      else
        return nil
      end
    end


end
