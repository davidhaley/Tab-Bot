class Timer
  include SuckerPunch::Job
  # workers 1

  def perform
    HTTParty.post("https://hooks.slack.com/services/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", 
    :body => { "channel": "#general", "username": "webhookbot", "text": "This is posted to #general and comes from a bot named webhookbot.", "icon_emoji": ":ghost:"}.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
  end
end