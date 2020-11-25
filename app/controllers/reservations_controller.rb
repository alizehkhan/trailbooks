class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user: current_user)
  end

  def new
    @accomodation = Accomodation.find(params[:accomodation_id])
    @reservation = Reservation.new
  end

  def create
    @accomodation = Accomodation.find(params[:accomodation_id])
    @reservation = reservation.new(reservation_params)
    start_date = Date.parse(params[:reservation][:start_date])
    end_date = Date.parse(params[:reservation][:end_date])
    total_price = (end_date - start_date).to_i * @accomodation.total_price
    @reservation.total_price = total_price
    @reservation.itinerary = current_itinerary
    @reservation.accomodation = @accomodation
    if @reservation.save
      redirect_to reservations_path
    else
      render "new"
    end
  end

  def destroy
    @accomodation.destroy

    redirect_to reservations_path
  end
end
