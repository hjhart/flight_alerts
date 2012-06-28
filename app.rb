# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'awesome_print'

require './db/models'

set :database, 'sqlite:///flights.db'

f = Flight.create!(:takeoff => Time.now(), :length_in_minutes => 120)
ap f

post '/flight_api' do
  ap params
end
