require 'sucker_punch'
require 'httparty'

class Message
  include SuckerPunch::Job

  def perform(greeting=nil, team=nil, interval=nil)
    if greeting == "start"
      message = "...TaB-bot ONLINE!\n\nWelcome #{team}! Get to work.. You'll be hearing from me in #{interval / 60} minutes!"
    elsif greeting == "stop"
      message = "...TaB-bot OFFLINE!"
    elsif greeting == "help"
      message = "Welcome to help!\n\n_'tab-bot: [start|stop|help] [team-name] [break-interval-in-minutes]_'\n\nteam-name is optional:default=Team1\nbreak-interval is optional:default=2\n\nexample: _*tab-bot: start team-amazing 60*_\n\nstarts 'tab-bot' for 'team-amazing' with a break-timer of '60 minutes'"
    else
      message = "Hey team! You've been working for a while! Have a break!\n\n#{(Time.now + 18*60*60).strftime("%Y-%m-%d %H:%M:%S")}"
    end
    puts "performing message at #{Time.now}"
    HTTParty.post("https://hooks.slack.com/services/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", 
    :body => { "channel": "#demo", "username": "TaB-bot", "text": "#{message}"}.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
  end
end