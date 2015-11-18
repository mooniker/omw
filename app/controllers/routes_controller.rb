class RoutesController < ApplicationController

  def index
    @route_attributes = ['LineDescription', 'Name', 'RouteID']
    @routes = Route.all
  end
end
