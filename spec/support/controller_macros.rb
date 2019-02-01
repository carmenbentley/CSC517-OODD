#require 'factory-bot'

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin)
    end
  end

  def login_realtor
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:realtor]
      sign_in FactoryBot.create(:realtor)
    end
  end

  def login_hunter
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:hunter]
      sign_in FactoryBot.create(:hunter)
    end
  end
end