class Message
  include SuckerPunch::Job
  # workers 1

  # SuckerPunch.shutdown_timeout = 30

  def perform
    HTTParty.post("https://hooks.slack.com/services/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", 
    :body => { "channel": "#general", "username": "webhookbot", "text": "You've been working for a while! Make sure you take a break! [This is posted to #general and comes from a bot named tab-bot]", "icon_emoji": ":ghost:"}.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
    # if working
    #   Timer.perform_in(1, false)
    # else
    #   Timer.perform_in(10, true)
    # end
  end
end