class EventsController < ApplicationController
  def index
    @events = JSON.parse(HTTParty.get("http://data:3000/events").body).map do |event|
      { 
        name: event['name'], 
        date_start: DateTime.parse(event['date_start']).to_formatted_s(:long), 
        date_end: DateTime.parse(event['date_end']).to_formatted_s(:long),
        tickets: event['tickets']
      }
    end
  end
end