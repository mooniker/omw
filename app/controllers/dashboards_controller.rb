class DashboardsController < ApplicationController

  def index
    @dashboards = Dashboard.all
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    stop_ids = @dashboard.stop_id_str.strip.split
    @predictions = []
    stop_ids.each do |stop|
      @predictions << Wmata.new(ENV['wmata_api_key']).get_predictions(stop)
    end # why does this nest like this?
  end

  def new
    @dashboard = Dashboard.new
  end

  def edit
    @dashboard = Dashboard.find(params[:id])
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)
    puts params, dashboard_params
    if @dashboard.save
      redirect_to @dashboard
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
    @dashboard = Dashboard.find(params[:id])
    @dashboard.destroy
    redirect_to dashboards_path
  end

  private
    def dashboard_params
      params.require(:dashboard).permit(:title, :desc, :stop_id_str)
    end

end
