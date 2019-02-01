require 'rails_helper'

RSpec.describe Realtor, type: :model do
  context 'validation tests' do
    it 'ensure first_name presence' do
      expect( Realtor.new( last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', password: '123456',
                           phone_number: '9108971234')).to be_invalid
    end

    it 'ensure last_name presence' do
      expect( Realtor.new( first_name: 'Carmen',
                           email: 'cnaiken@ncsu.edu', password: '123456',
                           phone_number: '9108971234')).to be_invalid
    end

    it 'ensure email presence' do
      expect( Realtor.new( first_name: 'Carmen', last_name: 'Bentley',
                           password: '123456', phone_number: '9108971234')).to be_invalid
    end

    it 'ensure password presence' do
      expect( Realtor.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', phone_number: '9108971234')).to be_invalid
    end

    it 'ensure phone_number presence' do
      expect( Realtor.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', password: '123456')).to be_invalid
    end

    it 'ensure email formatting' do
      expect( Realtor.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaikenncsu.edu', password: '123456',
                           phone_number: '9108971234')).to be_invalid
    end

    it 'ensure phone length' do
      expect( Realtor.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'cnaiken@ncsu.edu', password: '123456',
                           phone_number: '91089712340')).to be_invalid
    end

    it 'should save successfully' do
      expect( Realtor.new( first_name: 'Carmen', last_name: 'Bentley',
                           email: 'test@email.edu', password: '123456',
                           phone_number: '9108971234')).to be_valid
    end

    it 'is databse authenticable' do
      realtor = Realtor.create( email: 'realtor@email.com', password: 'goodPassword',
                                password_confirmation: 'goodPassword')
      expect(realtor.valid_password?('goodPassword')).to be_truthy
    end

    it 'is databse not authenticable' do
      realtor = Realtor.create( email: 'realtor@email.com', password: 'goodPassword',
                                password_confirmation: 'goodPassword')
      expect(realtor.valid_password?('12345')).to be_falsy
    end
  end
end
