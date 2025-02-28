require 'rails_helper'
RSpec.describe 'doctor show page' do
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
  # When I visit a doctor's show page
  # I see all of that doctor's information including:
  #  - name
  #  - specialty
  #  - university where they got their doctorate
  # And I see the name of the hospital where this doctor works
  # And I see the names of all of the patients this doctor has
  describe 'user story 1' do
    it 'I see all of the the doctors attributes' do
      visit doctor_path(@doctor_1)

      within("#doctor-info") do
        expect(page).to have_content(@doctor_1.name)
        expect(page).to have_content(@doctor_1.specialty)
        expect(page).to have_content(@doctor_1.university)
      end
      expect(page).to_not have_content(@doctor_2.name)

      visit doctor_path(@doctor_2)

      within("#doctor-info") do
        expect(page).to have_content(@doctor_2.name)
        expect(page).to have_content(@doctor_2.specialty)
        expect(page).to have_content(@doctor_2.university)
      end
      expect(page).to_not have_content(@doctor_1.name)
    end

    it 'I see the name of the hospital where this doctor works' do
      visit doctor_path(@doctor_1)

      expect(page).to have_content(@hospital_1.name)
      expect(page).to_not have_content(@hospital_2.name)

      visit doctor_path(@doctor_2)

      expect(page).to have_content(@hospital_2.name)
      expect(page).to_not have_content(@hospital_1.name)
    end

    it 'I see the names of all of the patients this doctor has' do
      visit doctor_path(@doctor_1)

      within("#doctor-patients") do
        expect(page).to have_content(@patient_1.name)
        expect(page).to have_content(@patient_2.name)
        expect(page).to have_content(@patient_3.name)
        expect(page).to_not have_content(@patient_4.name)
        expect(page).to_not have_content(@patient_5.name)
        expect(page).to_not have_content(@patient_6.name)
      end
      visit doctor_path(@doctor_2)

      within("#doctor-patients") do
        expect(page).to have_content(@patient_4.name)
        expect(page).to have_content(@patient_5.name)
        expect(page).to have_content(@patient_6.name)
        expect(page).to_not have_content(@patient_1.name)
        expect(page).to_not have_content(@patient_2.name)
        expect(page).to_not have_content(@patient_3.name)
      end
    end
  end
#   As a visitor
# When I visit a Doctor's show page
# Next to each patient's name, I see a button to remove that patient from that doctor's caseload
# When I click that button for one patient
# I'm brought back to the Doctor's show page
# And I no longer see that patient's name listed
  describe 'user story 2' do
    it 'Next to each patients name, I see a button to remove that patient' do
      visit doctor_path(@doctor_1)

      expect(page).to have_button("Remove #{@patient_1.id}")
      expect(page).to_not have_button("Remove #{@patient_5.id}")

      visit doctor_path(@doctor_2)

      expect(page).to have_button("Remove #{@patient_4.id}")
      expect(page).to_not have_button("Remove #{@patient_2.id}")

    end

    it "When I click that button for one patient I no longer see that patients name listed" do
      visit doctor_path(@doctor_1)

      click_button("Remove #{@patient_1.id}")

      expect(page).to_not have_content(@patient_1.id)

      visit doctor_path(@doctor_2)

      click_button("Remove #{@patient_5.id}")

      expect(page).to_not have_content(@patient_5.id)
    end
  end
end
