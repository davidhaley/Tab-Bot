require 'httparty'

# Homepage (Root path)
get '/' do
  erb :index
end

# Receive Slack POST request, remove Slackbot trigger word. 
post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  # puts message
  action, repo = message.split('_').map {|c| c.strip.downcase }

  # puts action
  # puts repo.inspect
  repo_url = "https://api.github.com/repos/#{repo}"

  case action
    when 'start'
      # resp = HTTParty.get(repo_url)
      # puts resp
      # resp = JSON.parse resp.body
      # puts resp
      # respond_message "There are #{resp['open_issues_count']} open issues on #{repo}"
      Timer.perform_in(5)
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end