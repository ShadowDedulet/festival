require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET /index' do
    before(:all) do
      time = DateTime.new(2022, 4, 15, 19)
      10.times { |it| Event.create(name: "event_#{it}", date_start: ( time + it.day ).to_s, date_end: (time + it.day + 4 .hour).to_s ) }
    end

    after(:all) do
      Event.destroy_all
    end

    it 'should return all events not ended for this moment' do
      get :index
      JSON.parse(response.body).each do |event|
        expect(DateTime.parse(event['date_start'])).to be > DateTime.now
      end
    end
  end

  describe 'GET /show/:id' do
    before(:all) do
      time = DateTime.new(2022, 4, 20, 19)
      @event = Event.create(name: 'event', date_start: time, date_end: time + 4.hour)
      5.times { |n| @event.tickets.create(ticket_type: :fan_zone, status: :accessed, start_price: 1000) }
    end

    after(:all) do
      Ticket.destroy_all
      Event.delete_all
    end
    
    it 'should return some event tickets' do
      get :show, params: { id: @event.id }
      JSON.parse(response.body).each do |ticket|
        expect(ticket['status']).to eq 'accessed'
      end
    end

    it 'should not find event with id' do
      expect { get :show, params: { id: @event.id + 1 } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST /create' do
    before(:all) do
      @date = DateTime.now + 2.day
    end

    it 'should create new event' do
      post :create, params: { event: { name: 'Rock', date_start: @date, date_end: @date + 3.hour } }
      expect(response.status).to eq(201) 
    end

    it 'should not create new event and return status 406' do
      post :create, params: { event: { name: 'Rock', date_start: @date - 10.day, date_end: @date + 3.hour } }
      # p response
      expect(response.status).to eq(422) 
    end
  end

  describe 'POST /update' do
    before(:all) do
      @date = DateTime.now + 2.day
      @event = Event.create(name: 'Rock', date_start: @date, date_end: @date + 3.hour)
    end

    after(:all) do
      @event.destroy
    end

    it 'should update some event' do
      put :update, params: { id: @event.id, event: { name: 'Rock', date_start: @date, date_end: @date + 3.hour } }
      expect(response.status).to eq(200)
    end

    it 'should not update event and return status 406' do
      put :update, params: { id: @event.id, event: { name: 'Rock', date_start: @date - 10.day, date_end: @date + 3.hour } }
      expect(response.status).to eq(422)
    end
  end
end