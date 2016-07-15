# require 'rubygems'
# require 'bundler/setup'
# APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
# require 'active_support/all'
# require 'sinatra'
# require 'sinatra/activerecord'
# require 'sinatra/contrib/all'
# require 'active_record'
# require_relative '../config/database'
# require 'json'
# require_relative 'models/message'
# require 'sucker_punch'

# Timer.create(interval: 20)
# Log.create(notified_at: DateTime.now)

# check for the next time to send message

class Worker
  def initialize
    @running = true

    while @running do
      puts "starting loop"
      if DateTime.now < Log.last.notified_at + Timer.last.interval.seconds
        sleep(5)
        puts "sleeping for 5 seconds"
      else
        puts "performing message"
        Message.perform_in(1)
        Timer.create(interval: 20)
        Log.create(notified_at: DateTime.now)
      end
    end
  end

  def stop
    @running = false
  end
end

# Worker.new

# loop over every timer and find out when each one ran and whether you should do another one.
