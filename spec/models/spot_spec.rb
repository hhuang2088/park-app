require 'rails_helper'

RSpec.describe Spot, :type => :model do
  
  describe Spot do 
    it "should be created with required parameters" do 
      spot = Spot.create(longitude:5.1235, latitude:5.1235, description:"testing")
      spot.should be_valid 
    end
    
    it "must be created with longitude" do 
      spot = Spot.create(longitude:nil, latitude:5.1235, description:"testing")
      spot.should_not be_valid
    end

    it "must be created with latitude" do 
      spot = Spot.create(longitude:5.1235, latitude:nil, description:"testing")
      spot.should_not be_valid 
    end

    it "description attribute is optional" do 
      spot = Spot.create(longitude:5.1235, latitude:5.1235, description:nil)
      spot.should be_valid 
    end
  end
end
