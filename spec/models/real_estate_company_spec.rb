require 'rails_helper'

RSpec.describe RealEstateCompany, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      expect( RealEstateCompany.new( website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensures website presence' do
      expect( RealEstateCompany.new( name: 'Company', address: '123 South 10th Street', size: 500,
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensures address presence' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',size: 500,
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensures size presence' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street',
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensures founded presence' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensures revenue presence' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: 1998, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensures synopsis presence' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: 1998, revenue: 5000000)).to be_invalid
    end

    it 'ensures website format' do
      expect( RealEstateCompany.new( name: 'Company', website: 'www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensure size is numeric' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 'ten',
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensure size is > zero' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: -1,
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensure founded is numeric' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: 'ten', revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensure founded is > zero' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: -1, revenue: 5000000, synopsis: 'Test Company')).to be_invalid
    end

    it 'ensure revenue is numeric' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: 1998, revenue: 'a lot', synopsis: 'Test Company')).to be_invalid
    end

    it 'should save successfully' do
      expect( RealEstateCompany.new( name: 'Company', website: 'https://www.company.com',
                                     address: '123 South 10th Street', size: 500,
                                     founded: 1998, revenue: 5000000, synopsis: 'Test Company')).to be_valid
    end
  end
end
