class Timer
  include SuckerPunch::Job
  # workers 1

  SuckerPunch.shutdown_timeout = 30

  def perform(working=true)
    while working == true
      HTTParty.post("https://hooks.slack.com/services/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", 
      :body => { "channel": "#general", "username": "webhookbot", "text": "Take a break!", "icon_emoji": ":ghost:"}.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    end
  end
end