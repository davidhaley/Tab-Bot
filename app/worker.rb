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

  def initialize(team, interval)
    @running = true
    @team = team
    @interval = interval
  end

  def start
    while @team.timer.running
      puts DateTime.now
      if DateTime.now < Log.last.notified_at + @team.timer.interval.seconds
        sleep(2)
        puts "sleeping for 2 seconds"
      else
        puts "performing message at #{Time.now}"
        Message.perform_in(1)
        Timer.create(interval: @interval)
        Log.create(notified_at: DateTime.now)
      end
      @team.timer.reload
    end
  end

  def stop
    @running = false
  end
end

# Worker.new

# loop over every timer and find out when each one ran and whether you should do another one.

