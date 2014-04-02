namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    [Patient, BloodOxygenReading, HeartRateReading, WeightReading, ThresholdValues].each(&:delete_all)

    patient = Patient.create()
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 96.8, :reading_time => Time.now)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 90.4, :reading_time => Time.now - 1.day)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 89.9, :reading_time => Time.now - 2.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 86.4, :reading_time => Time.now - 3.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 98.2, :reading_time => Time.now - 4.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 97.5, :reading_time => Time.now - 5.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 50.6, :reading_time => Time.now - 6.days)

    HeartRateReading.create(:patient_id => patient.id, :hr_sensor_id => 123456789, :heart_rate => 120, :heart_rate_variability => 0.1, :reading_time => Time.now)
    HeartRateReading.create(:patient_id => patient.id, :hr_sensor_id => 123456789, :heart_rate => 105, :heart_rate_variability => 0.3, :reading_time => Time.now - 1.day)
    HeartRateReading.create(:patient_id => patient.id, :hr_sensor_id => 123456789, :heart_rate => 110, :heart_rate_variability => 0.2, :reading_time => Time.now - 2.days)
    HeartRateReading.create(:patient_id => patient.id, :hr_sensor_id => 123456789, :heart_rate => 140, :heart_rate_variability => 0.09, :reading_time => Time.now - 3.days)
    HeartRateReading.create(:patient_id => patient.id, :hr_sensor_id => 123456789, :heart_rate => 150, :heart_rate_variability => 0.6, :reading_time => Time.now - 4.days)
    HeartRateReading.create(:patient_id => patient.id,:hr_sensor_id => 123456789, :heart_rate => 139, :heart_rate_variability => 0.5, :reading_time => Time.now - 5.days)
    HeartRateReading.create(:patient_id => patient.id, :hr_sensor_id => 123456789, :heart_rate => 141, :heart_rate_variability => 0.4, :reading_time => Time.now - 6.days)

    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 114, :reading_time => Time.now)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 115, :reading_time => Time.now - 1.day)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 114, :reading_time => Time.now - 2.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 115, :reading_time => Time.now - 3.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 116, :reading_time => Time.now - 4.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 117, :reading_time => Time.now - 5.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 118, :reading_time => Time.now - 6.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 115, :reading_time => Time.now - 7.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 116, :reading_time => Time.now - 8.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 114, :reading_time => Time.now - 9.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 140, :reading_time => Time.now - 10.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 145, :reading_time => Time.now - 11.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 144, :reading_time => Time.now - 12.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 145, :reading_time => Time.now - 13.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 146, :reading_time => Time.now - 14.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 144, :reading_time => Time.now - 15.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 145, :reading_time => Time.now - 16.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 144, :reading_time => Time.now - 17.days)
    WeightReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :weight => 146, :reading_time => Time.now - 18.days)

    ThresholdValues.create(:patient_id =>patient.id, :bo_perc => 90, :weight => 5, :heart_rate => 140, :heart_rate_variability => 0.5)
    
  end
end