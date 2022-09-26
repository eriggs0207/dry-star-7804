class DoctorsController < ApplicationController

  def show
    @doctor = Doctor.find(params[:id])
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.patients.delete
    redirect_to doctor_path(@doctor)
  end

end
