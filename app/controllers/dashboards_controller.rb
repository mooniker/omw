class DashboardsController < ApplicationController

  def index
    @dashboards = Dashboard.all
  end

  def show
    @dashboard = Dashboard.find(params[:id])
  end

  def new
    @dashboard = Dashboard.new
  end

  def edit
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)
    puts params, dashboard_params
    if @dashboard.save
      redirect_to @dashboard
    end
  end

  def update
  end

  def destroy
  end

  private
    def dashboard_params
      params.require(:dashboard).permit(:title, :desc)
    end

end
