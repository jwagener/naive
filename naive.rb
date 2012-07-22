#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
#require 'sinatra/compass'
require 'sprockets-sass'
require 'haml'
require 'uri'

MAX_AGE = 60
before do
  cache_control :public, :max_age => MAX_AGE
end

set :static_cache_control, [:public, :max_age => MAX_AGE]

configure do
  Compass.configuration do |config|
    config.sprite_load_path = "assets/images"
    config.generated_images_path = "public/images"
    config.images_path = "assets/images"
    config.images_dir = "images"
  end
end

get '/' do
  haml :index
end
