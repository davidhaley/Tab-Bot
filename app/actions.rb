require 'httparty'

# Homepage (Root path)
get '/' do
  erb :index
end

# Receive Slack POST request, remove Slackbot trigger word, assign action word to variable.
post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  action, repo = message.split('_').map {|c| c.strip.downcase }

  # repo_url = "https://api.github.com/repos/#{repo}"

  case action
    # Start the timer.
    when 'start'
      # resp = HTTParty.get(repo_url)
      # puts resp
      # resp = JSON.parse resp.body
      # puts resp
      # respond_message "There are #{resp['open_issues_count']} open issues on #{repo}"
      # Message.perform_in(5)

      Timer.create(interval: 30)
      Log.create(notified_at: DateTime.now)
      worker = Worker.new
    when 'stop'
      worker.stop
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end

# Thread.new do
#   puts "testing outside"
#   loop do  
#     # Log.create(notified_at: DateTime.now)

#     puts "testing inside"
#     sleep(1)
#   end
# end