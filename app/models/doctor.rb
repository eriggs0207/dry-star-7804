class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients


  def patient_count
    patients.count
  end

  def self.order_by_patient_count
    order(self.patient_count)
  end
end
