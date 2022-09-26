require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "relationships" do
  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients)}

  end
  before :each do
    @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
    @patient_2 = Patient.create!(name: "Denny Duquette", age: 39)
    @patient_3 = Patient.create!(name: "Rebecca Pope", age: 32)
    @patient_4 = Patient.create!(name: "Zola Shepherd", age: 2)
    @patient_5 = Patient.create!(name: "John Johnshon", age: 4)
    @patient_6 = Patient.create!(name: "Timmy Timmyson", age: 6)

  end
  describe 'class methods' do
    describe 'lists patients over 18 and in alphabetical order' do
      it '#adults' do
        expect(Patient.adult_patients).to eq([@patient_2, @patient_1, @patient_3])
      end
    end
  end
end
