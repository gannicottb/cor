class Physician < ActiveRecord::Base
    attr_accessible :name
    has_many :patients

    
end
