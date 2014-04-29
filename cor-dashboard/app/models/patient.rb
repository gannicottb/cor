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

    def health_summary      
      # # Basic premise: Average the readings for last two weeks. 
      # # Compare to an ideal "green" value if possible. 
      # # Value to send to summary graph is mapped from [-1, 1] to [0,6] (generally)

      #Blood Oxygen Summary
      bo_avg = blood_oxygen_readings.last_2_weeks.average(:bo_perc)

        # Constrain the values to not go off the graph
      bo_dev = map(bo_avg, 0.0, 100.0, 0, 3)

      
      #Blood Pressure Summary
        # Get the average values for both systolic and diastolic
      bp_sys_avg = blood_pressure_readings.last_2_weeks.average(:systolic_bp)
      bp_dia_avg = blood_pressure_readings.last_2_weeks.average(:diastolic_bp)

        # The value would be perfectly in the green zone if it was between the high and low thresholds
      green_sys = avg(eval(threshold_values.systolic_bp)[:high] , eval(threshold_values.systolic_bp)[:low])
      green_dia = avg(eval(threshold_values.diastolic_bp)[:high], eval(threshold_values.diastolic_bp)[:low])

        # What's the % difference between the average reading and the ideal value?
      bp_sys_change = change(bp_sys_avg, green_sys)
      bp_dia_change = change(bp_dia_avg, green_dia)

        # Whichever change is bigger (because we consider the "worst" bp value)      
      bp_change = max(bp_sys_change, bp_dia_change)


      #Heart Rate Summary
      hr_avg = heart_rate_readings.last_2_weeks.average(:heart_rate)

      green_hr = avg(eval(threshold_values.heart_rate)[:high], eval(threshold_values.heart_rate)[:low])

      hr_change = change(hr_avg, green_hr)

      #Sodium Summary
      so_ints = emas.last_2_weeks.map {|r| sodiumStringToInt(r.sodium_level)}
      # Inject is a way to compute the average value of the contents of this array
      so_avg = so_ints.inject(0.0) {|sum, el| sum + el} / so_ints.size

      
      # The map function converts a value from one range to another (see at foot of file)
      # TODO: Figure out some way to represent how the patient's weight is doing
      return {weight: weight_readings.last_2_weeks.average(:weight), 
              heart_rate: map(hr_change, -1.0, 1.0, 0, 6), 
              blood_oxygen: bo_dev, 
              blood_pressure: map(bp_change, -1.0, 1.0, 0, 6),  
              sodium: map(so_avg, 0, 3, 0, 6)}

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

    def activity_log_last_2_weeks
      #Package up the data for the activity log page
      return  {exercise: {sedentary: activities.last_2_weeks.map {|r| r.sedentary_minutes},
                          lightly_active: activities.last_2_weeks.map {|r| r.lightly_active_minutes},
                          fairly_active: activities.last_2_weeks.map {|r| r.fairly_active_minutes},
                          very_active: activities.last_2_weeks.map {|r| r.very_active_minutes},
                          steps: activities.last_2_weeks.map {|r| r.steps},
                          days: activities.last_2_weeks.map{|r| r.date.strftime("%B %d")}
      },
               sleep: {sleep_efficiency: activities.last_2_weeks.map {|r| r.sleep_efficiency},
                       number_of_awakenings: activities.last_2_weeks.map {|r| r.number_of_awakenings},
                       minutes: activities.last_2_weeks.map {|r| r.minutes_asleep}
               }
      }
    end

    def activity_log_last_month
      #Package up the data for the activity log page
      return  {exercise: {sedentary: activities.last_month.map {|r| r.sedentary_minutes},
                          lightly_active: activities.last_month.map {|r| r.lightly_active_minutes},
                          fairly_active: activities.last_month.map {|r| r.fairly_active_minutes},
                          very_active: activities.last_month.map {|r| r.very_active_minutes},
                          steps: activities.last_month.map {|r| r.steps},
                          days: activities.last_month.map{|r| r.date.strftime("%B %d")}
      },
               sleep: {sleep_efficiency: activities.last_month.map {|r| r.sleep_efficiency},
                       number_of_awakenings: activities.last_month.map {|r| r.number_of_awakenings},
                       minutes: activities.last_month.map {|r| r.minutes_asleep}
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
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Blood Oxygen is under threshold")
          end
        end
      end

      heartRateThreshValues = eval(threshold_values.heart_rate)
      heart_rate_readings.each do |r|
        if !alerts.exists?(reading_id: r.id)
          if r.heart_rate >= heartRateThreshValues[:high]
            #create a new alert for this patient
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Heart Rate above threshold")
          end
          if r.heart_rate <= heartRateThreshValues[:low]
            #create a new alert for this patient
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Heart Rate below threshold")
          end
        end
      end

      thresholdSystolic = eval(threshold_values.systolic_bp)
      thresholdDiastolic = eval(threshold_values.diastolic_bp)

      blood_pressure_readings.each do |r|
        if !alerts.exists?(reading_id: r.id)
          if r.systolic_bp >= thresholdSystolic[:high]
            #create a new alert for this patient
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Blood Pressure (Systolic) is HIGH")
          end
          if r.systolic_bp <= thresholdSystolic[:low]
            #create a new alert for this patient
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Blood Pressure (Systolic) is LOW")
          end
          if r.diastolic_bp >= thresholdDiastolic[:high]
            #create a new alert for this patient
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Blood Pressure (Diastolic) is HIGH")
          end
          if r.diastolic_bp <= thresholdDiastolic[:low]
            #create a new alert for this patient
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Blood Pressure (Diastolic) is LOW")
          end
        end
      end

      emas.each do |r|
        if !alerts.exists?(reading_id: r.id)
          if r.sodium_level == "High"
            #create a new alert for this patient
            Alert.create(patient_id: id, urgent: true, reading_id: r.id, text: "Sodium Level is high")
          end
        end
      end

      relevant_weight_readings = weight_readings.where(reading_time: eval(threshold_values.weight)[:time].days.ago .. Time.now)
      if(relevant_weight_readings.maximum(:weight) - relevant_weight_readings.minimum(:weight)>=eval(threshold_values.weight)[:weight])
        #create a new alert for this patient
        Alert.create(patient_id: id, urgent: true, reading_id: relevant_weight_readings.where(weight: relevant_weight_readings.maximum(:weight)).first().id, text: "Change in weight has exceeded the threshold")
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

    #more or less copied from Arduino library
  def map(x, in_min, in_max, out_min, out_max)  
      (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
  end

  def avg(val1, val2)
    (val1 + val2) / 2
  end

  def change(val1, val2)
    (val1 - val2)/val2
  end

  def max(val1, val2)
    if val1.abs > val2.abs
      val1
    else
      val2
    end
  end
end
