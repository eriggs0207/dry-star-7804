require 'rails_helper'
RSpec.describe 'patient index page' do
  before :each do
    @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    @hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")
    @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
    @doctor_2 = @hospital_2.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "Johns Hopkins University")

    @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
    @patient_2 = Patient.create!(name: "Denny Duquette", age: 39)
    @patient_3 = Patient.create!(name: "Rebecca Pope", age: 32)
    @patient_4 = Patient.create!(name: "Zola Shepherd", age: 2)
    @patient_5 = Patient.create!(name: "John Johnshon", age: 4)
    @patient_6 = Patient.create!(name: "Timmy Timmyson", age: 6)

    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_5.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_6.id)
  end

  # As a visitor
  # When I visit the patient index page
  # I see the names of all adult patients (age is greater than 18),
  # And I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)
  describe 'user story 3' do
    it 'I see the names of all adult patients (age is greater than 18)' do
      visit patients_path

      within("#adult-patients") do
        expect(page).to have_content(@patient_1.name)
        expect(page).to have_content(@patient_2.name)
        expect(page).to have_content(@patient_3.name)
        expect(page).to_not have_content(@patient_4.name)
        expect(page).to_not have_content(@patient_5.name)
        expect(page).to_not have_content(@patient_6.name)
      end
    end
  end
end
