namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    [Patient, BloodOxygenReading, ThresholdValues].each(&:delete_all)

    patient = Patient.create()
    today = Time.now
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 96.8, :reading_time => Time.now)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 90.4, :reading_time => Time.now - 1.day)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 89.9, :reading_time => Time.now - 2.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 86.4, :reading_time => Time.now - 3.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 98.2, :reading_time => Time.now - 4.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 97.5, :reading_time => Time.now - 5.days)
    BloodOxygenReading.create(:patient_id => patient.id, :bo_sensor_id => 123456789, :bo_perc => 50.6, :reading_time => Time.now - 6.days)

    ThresholdValues.create(:patient_id =>patient.id, :bo_perc => 90)
    #Patient.populate 20 do |category|
    #  category.name = Populator.words(1..3).titleize
    #  Product.populate 10..100 do |product|
    #    product.category_id = category.id
    #    product.name = Populator.words(1..5).titleize
    #    product.description = Populator.sentences(2..10)
    #    product.price = [4.99, 19.95, 100]
    #    product.created_at = 2.years.ago..Time.now
    #  end
    #end
    #
    #Person.populate 100 do |person|
    #  person.name    = Faker::Name.name
    #  person.company = Faker::Company.name
    #  person.email   = Faker::Internet.email
    #  person.phone   = Faker::PhoneNumber.phone_number
    #  person.street  = Faker::Address.street_address
    #  person.city    = Faker::Address.city
    #  person.state   = Faker::Address.us_state_abbr
    #  person.zip     = Faker::Address.zip_code
    #end
  end
end