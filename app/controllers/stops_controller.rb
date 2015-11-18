class StopsController < ApplicationController

  def index
    @stops = Stop.all[0..20]
  end

end
