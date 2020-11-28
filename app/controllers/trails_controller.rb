class TrailsController < ApplicationController
  before_action :set_trail, only: %i[show]

  def show
    @markers = build_markers
  end

  private

  def set_trail
    @trail = Trail.find(params[:id])
  end

  def assign_icon(category)
    category == "Hut" ? 'marker-enabled-hut.png' : 'marker-enabled-campsite.png'
  end

  def build_markers
    {
      accomodation: @trail.accomodations.map do |accomodation|
        {
          lat: accomodation.latitude,
          lng: accomodation.longitude,
          infoWindow: render_to_string(
            partial: "info_window",
            locals: { accomodation: accomodation }
          ),
          image_url: helpers.asset_url(assign_icon(accomodation.category))
        }
      end,
      trailstages: @trail.trail_stages.map do |trailstage|
        {
          lat: trailstage.latitude,
          lng: trailstage.longitude,
          num: trailstage.stage_number
        }
      end
    }
  end
end
