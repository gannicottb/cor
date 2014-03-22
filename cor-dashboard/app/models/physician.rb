class Physician < ActiveRecord::Base
    has_many :patients
end
