require 'rails_helper'
require 'rspec'

describe HousesController do
  describe 'creating a new house' do
    login_realtor

    it 'creates a new house and fetches the form for a new house' do
      expect(House).to receive(:new)
      get :new
      expect(response).to render_template('new')
    end

    #it 'receives the data from the realtor' do
      #house = double('house')
     # house = House.new
      #house = create(:house)
     # allow(house).to receive(:save).and_return(true)
     # allow(house).to receive('permit').and_return(house)
      #post :create, :params => { :house => house }
     # expect(response).to render('houses')
     # expect(House).to receive(:save)
      #allow(house).to receive(:save).and_return(false)
     # post :create
      #expect(response).to render('new')
   # end

   # it 'saves it to the database' do

   # end

  end
end