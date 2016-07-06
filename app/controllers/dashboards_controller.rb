class DashboardsController < ApplicationController

  def index
    @my_dashboards = []
    if current_user
      @my_dashboards = current_user.dashboards
      not_mine = Dashboard.where.not(user_id: current_user.id)
      @dashboards = not_mine.where(public: true)
    else
      @dashboards = Dashboard.where(public: true)
    end
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    stop_ids = @dashboard.stop_id_str.strip.split
    @predictions = []
    @stops = []
    stop_ids.each do |stop|
      # @predictions << Wmata.new(ENV['wmata_api_key']).get_predictions(stop)
      @predictions << Wmata.new.get_predictions(stop)
      @stops << Stop.find_by('StopID' => stop)
    end
  end

  def new
    # @lat = 38.9049836
    # @lon =  -77.0336719
    @dashboard = Dashboard.new
    @stops = Wmata.new.get_bus_stops(38.9049836, -77.0336719, 500)


  end

  def edit
    @dashboard = Dashboard.find(params[:id])
    # stop_ids = @dashboard.stop_id_str.strip.split
    # # @stops = Wmata.new.get_bus_stops(@dashboard.lat, @dashboard.lon, 400)
    # @stops = []
    # stop_ids.each do |stop|
    #   # @predictions << Wmata.new.get_predictions(stop)
    #   @stops << Stop.find_by('StopID': stop)
    # end
    @stops = Wmata.new.get_bus_stops(@dashboard.lat, @dashboard.lon, 500)
  end

  def create
    dashboard = Dashboard.new(dashboard_params.merge(user: current_user))
    if dashboard.save
      #notice?
      redirect_to dashboard
    else
      render 'new'
    end
  end

  def update
    dashboard = Dashboard.find(params[:id])
    if dashboard.update(dashboard_params)
      #could this generate a 'notice'?
      redirect_to dashboard_path(dashboard)
    else
      render 'edit'
    end
  end

  def destroy
    @dashboard = Dashboard.find(params[:id])
    @dashboard.destroy
    redirect_to dashboards_path
  end

  private
    def dashboard_params
      params.require(:dashboard).permit(:title, :address, :desc, :public, :lat, :lon, :stop_id_str)
    end

end
