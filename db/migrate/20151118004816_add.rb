class Add < ActiveRecord::Migration
  def change
    add_reference :dashboards, :user, index: true
  end
end
