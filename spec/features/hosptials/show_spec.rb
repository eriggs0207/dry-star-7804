require 'rails_helper'
RSpec.describe 'hosptial show page' do
  before :each do
    @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    @hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")

    @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
    @doctor_2 = @hospital_1.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "Johns Hopkins University")
    @doctor_3 = @hospital_2.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
    @doctor_4 = @hospital_2.doctors.create!(name: "Derek McDreamy Shepherd", specialty: "Attending Surgeon", university: "University of Pennsylvania")

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
  # When I visit a hospital's show page
  # I see the hospital's name
  # And I see the names of all doctors that work at this hospital,
  # And next to each doctor I see the number of patients associated with the doctor,
  # And I see the list of doctors is ordered from most number of patients to least number of patients
  # (Doctor patient counts should be a single query)
  describe 'extenstion' do
    it 'I see the hospitals name and the names of all their doctors' do
      visit hospital_path(@hospital_1)

      expect(page).to have_content(@hospital_1.name)

      within("#doctor-#{@doctor_1.id}") do
        expect(page).to have_content(@doctor_1.name)
        expect(page).to have_content(@doctor_1.specialty)
        expect(page).to have_content(@doctor_1.university)
      end

      within("#doctor-#{@doctor_2.id}") do
        expect(page).to have_content(@doctor_2.name)
        expect(page).to have_content(@doctor_2.specialty)
        expect(page).to have_content(@doctor_2.university)

      end

      expect(page).to_not have_content(@doctor_3.name)

      visit hospital_path(@hospital_2)

      expect(page).to have_content(@hospital_2.name)

      within("#doctor-#{@doctor_3.id}") do
        expect(page).to have_content(@doctor_3.name)
        expect(page).to have_content(@doctor_3.specialty)
        expect(page).to have_content(@doctor_3.university)
        expect(page).to_not have_content(@doctor_4.university)
      end

      within("#doctor-#{@doctor_4.id}") do
        expect(page).to have_content(@doctor_4.name)
        expect(page).to have_content(@doctor_4.specialty)
        expect(page).to have_content(@doctor_4.university)
        expect(page).to_not have_content(@doctor_3.name)
      end

      expect(page).to_not have_content(@doctor_2.name)
    end

    it 'next to each doctor I see the number of patients associated with the doctor' do
      visit hospital_path(@hospital_1)

      within("#doctor-#{@doctor_1.id}") do
        expect(page).to have_content(@doctor_1.patient_count)
      end

      within("#doctor-#{@doctor_2.id}") do
        expect(page).to have_content(@doctor_2.patient_count)
      end

    end
  end
end
