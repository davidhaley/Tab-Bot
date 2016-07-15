require 'rubygems'
require 'bundler/setup'
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
require 'active_support/all'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/contrib/all'
require 'active_record'
require_relative '../config/database'
require 'json'


# check for the next time to send message

class Worker
  def initialize
    loop do
      Log.create(notified_at: DateTime.now)
      # sleep
    end
  end
end

Worker.new

# loop over every timer and find out when each one ran and whether you should do another one.

