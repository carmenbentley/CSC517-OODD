require 'rails_helper'

RSpec.describe Hunter, type: :model do
  context 'validation tests' do
    it 'ensure first_name presence' do
      expect( Hunter.new( last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', password: '123456',
                          phone: '9108971234', preferred: 1)).to be_invalid
    end

    it 'ensure last_name presence' do
      expect( Hunter.new( first_name: 'Carmen',
                           email: 'cnaiken@ncsu.edu', password: '123456',
                          phone: '9108971234', preferred: 1)).to be_invalid
    end

    it 'ensure email presence' do
      expect( Hunter.new( first_name: 'Carmen', last_name: 'Bentley',
                           password: '123456', phone: '9108971234', preferred: 1)).to be_invalid
    end

    it 'ensure password presence' do
      expect( Hunter.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', phone: '9108971234', preferred: 1)).to be_invalid
    end

    it 'ensure phone_number presence' do
      expect( Hunter.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', password: '123456', preferred: 1)).to be_invalid
    end

    it 'ensure email formatting' do
      expect( Hunter.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaikenncsu.edu', password: '123456',
                          phone: '9108971234', preferred: 1)).to be_invalid
    end

    it 'ensure phone length' do
      expect( Hunter.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', password: '123456',
                          phone: '91089712340', preferred: 1)).to be_invalid
    end

    it 'ensure preferred presence' do
      expect( Hunter.new( first_name: 'Carmen', last_name: 'Bentley',
                          email: 'cnaiken@ncsu.edu', password: '123456',
                          phone: '91089712340')).to be_invalid
    end

    it 'should save successfully' do
      expect( Hunter.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', password: '123456',
                          phone: '9108971234', preferred: 1)).to be_valid
    end

    it 'is databse authenticable' do
      hunter_good = Hunter.create( email: 'hunter@email.com', password: 'realPassword',
                                password_confirmation: 'realPassword')
      expect(hunter_good.valid_password?('realPassword')).to be_truthy
    end

    it 'is databse not authenticable' do
      hunter_bad = Hunter.create( email: 'hunter@email.com', password: 'realPassword',
                                password_confirmation: 'realPassword')
      expect(hunter_bad.valid_password?('12345')).to be_falsy
    end
  end
end
