require 'rails_helper'
require 'rspec'

describe RealtorsController do
  describe 'rendering the options' do
    login_realtor

    it 'renders the options view' do
      get :index
      expect(response).to render_template('index')
    end

    it 'shows the options view' do
      get :show
      expect(response).to render_template('index')
    end
  end
end