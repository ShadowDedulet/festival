require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe 'GET /index' do
    before(:all) do
      @date = DateTime.now + 2.day
      @event = Event.create(name: 'Rock', date_start: @date, date_end: @date + 3.hour)
      2.times { |n| @event.tickets.create(ticket_type: :fan_zone, status: :accessed, start_price: 1000, user_id: 1) }
    end

    after(:all) do
      @event.destroy
    end

    it 'should present available tickets' do
      get :index, params: { user_id: 1 }
      expect(JSON.parse(response.body)[0].keys).to contain_exactly('id', 'type', 'status', 'start_price', 'event')
    end

    it 'should present user tickets' do
      get :index, params: { event_id: @event.id }
      expect(JSON.parse(response.body).keys).to contain_exactly('fan_zone')
    end
  end

  describe 'POST /reserve' do
    before(:all) do
      date = DateTime.now + 2.day
      @event = Event.create(name: 'Rock', date_start: date, date_end: date + 3.hour)
      @ticket = @event.tickets.create(ticket_type: :fan_zone, status: :accessed, start_price: 1000)
    end

    after(:all) do
      @event.destroy
    end

    it 'should reserve ticket' do
      post :reserve, params: { id: @ticket.id }
      expect(response.status).to eq(200)
    end

    it 'should raise exception and return false result' do
      @ticket.reserved!
      post :reserve, params: { id: @ticket.id }
      expect(response.status).to eq(406)
    end
  end

  describe 'POST /cancel_reservation' do
    before(:all) do
      date = DateTime.now + 2.day
      @event = Event.create(name: 'Rock', date_start: date, date_end: date + 3.hour)
      ticket = @event.tickets.create(ticket_type: :fan_zone, status: :reserved, start_price: 1000)
      @reserve = Reserve.create(ticket: ticket, time_start: date, time_end: date + 5.minute)
    end

    after(:all) do
      @event.destroy
      @reserve.destroy
    end

    it 'should cancel ticket reservation' do
      get :cancel_reservation, params: { reservation_id: @reserve.id }
      expect(response.status).to eq(200)
    end

    it 'should raise exception and return false result' do
      get :cancel_reservation, params: { reservation_id: @reserve.id + 1 }
      expect(response.status).to eq(406)
    end
  end

  describe 'POST /block_ticket' do
    before(:all) do
      date = DateTime.now + 2.day
      @event = Event.create(name: 'Rock', date_start: date, date_end: date + 3.hour)
      @ticket = @event.tickets.create(ticket_type: :fan_zone, status: :reserved, start_price: 1000)
      @reserve = Reserve.create(ticket: @ticket, time_start: date, time_end: date + 5.minute)
    end

    after(:all) do
      @event.destroy
      @reserve.destroy
    end

    it 'should block ticket of user' do
      post :block_ticket, params: { user_role: 'admin', ticket_id: @ticket.id, document_number: '1223103841' }
      expect(response.status).to eq(200)
    end

    it 'should not find ticket with id and return status 406' do
      post :block_ticket, params: { user_role: 'admin', ticket_id: @ticket.id + 1, document_number: '1223103841' }
      expect(response.status).to eq(406)
    end

    it 'should not block ticket by no admin and return status 403' do
      post :block_ticket, params: { user_role: 'user', ticket_id: @ticket.id, document_number: '1223103841' }
      expect(response.status).to eq(403)
    end
  end
end