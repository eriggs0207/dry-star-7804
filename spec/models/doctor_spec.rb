require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe "relationships" do
  it {should belong_to :hospital}
  it {should have_many :doctor_patients}
  it {should have_many(:patients).through(:doctor_patients)}
  end

  before :each do
    @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    @hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")

    @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
    @doctor_2 = @hospital_1.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "Johns Hopkins University")
    @doctor_5 = @hospital_1.doctors.create!(name: "Ivan Dragov", specialty: "ER", university: "St Petersburg University")
    @doctor_6 = @hospital_1.doctors.create!(name: "Clubber Lang", specialty: "Surgery", university: "School of Hard Knocks")
    @doctor_3 = @hospital_2.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
    # @doctor_4 = @hospital_2.doctors.create!(name: "Derek McDreamy Shepherd", specialty: "Attending Surgeon", university: "University of Pennsylvania")

    @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
    @patient_2 = Patient.create!(name: "Denny Duquette", age: 39)
    @patient_3 = Patient.create!(name: "Rebecca Pope", age: 32)
    @patient_4 = Patient.create!(name: "Zola Shepherd", age: 2)
    @patient_5 = Patient.create!(name: "John Johnshon", age: 4)
    @patient_6 = Patient.create!(name: "Timmy Timmyson", age: 6)

    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_4.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_4.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_5.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_6.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_3.id, patient_id: @patient_2.id)

  end

  describe 'class methods' do
    describe 'orders doctors by patient count' do
      it '#order_by_patient_count' do
        expect(Doctor.order_by_patient_count).to eq([@doctor_1, @doctor_5, @doctor_2, @doctor_3, @doctor_6])
      end
    end 
  end

  describe 'instance methods' do
    describe 'counts the number of patients for each doctor' do
      it '#patient_count' do
        expect(@doctor_1.patient_count).to eq(4)
        expect(@doctor_5.patient_count).to eq(3)
        expect(@doctor_2.patient_count).to eq(2)
        expect(@doctor_3.patient_count).to eq(1)
        expect(@doctor_6.patient_count).to eq(0)
      end
    end
  end
end
