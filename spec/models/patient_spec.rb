require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "relationships" do
  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients)}

  end
  before :each do
    # @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    # @hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")
    # @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
    # @doctor_2 = @hospital_2.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "Johns Hopkins University")

    @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
    @patient_2 = Patient.create!(name: "Denny Duquette", age: 39)
    @patient_3 = Patient.create!(name: "Rebecca Pope", age: 32)
    @patient_4 = Patient.create!(name: "Zola Shepherd", age: 2)
    @patient_5 = Patient.create!(name: "John Johnshon", age: 4)
    @patient_6 = Patient.create!(name: "Timmy Timmyson", age: 6)

    # DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
    # DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
    # DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_3.id)
    # DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)
    # DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_5.id)
    # DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_6.id)
  end
  describe 'class methods' do
    describe 'lists patients over 18 and in alphabetical order' do
      it '#adults' do
        expect(Patient.adult_patients).to eq([@patient_2, @patient_1, @patient_3])
      end
    end
  end
end
