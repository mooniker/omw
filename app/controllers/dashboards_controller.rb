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
    @dashboard.find_by(params[:id])
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
      params.require(:dashboard).permit(:title, :desc)
    end

end
