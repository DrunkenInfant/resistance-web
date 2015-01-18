class MissionsController < ApplicationController

  respond_to :json

  def show
    mission = Mission.find_by_id(params[:id])
    if mission
      respond_with(mission)
    else
      render json: {}, status: :not_found
    end
  end
end
