require 'sucker_punch'
require 'httparty'

class Message
  include SuckerPunch::Job

  def perform
    HTTParty.post("https://hooks.slack.com/services/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", 
    :body => { "channel": "#general", "username": "webhookbot", "text": "You've been working for a while! Make sure you take a break! [This is posted to #general and comes from a bot named tab-bot] Message Time: #{DateTime.now}", "icon_emoji": ":ghost:"}.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
  end
end