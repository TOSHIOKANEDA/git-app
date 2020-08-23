class PowersController < ApplicationController

  def new
  end

  def index
  end

  def create
    @power = Power.new(power_params)
    redirect_to powers_path
  end

  private

  def power_params
    params.permit(:login_switch, :update_switch)
  end


end
