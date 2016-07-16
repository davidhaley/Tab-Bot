require 'httparty'

# Homepage (Root path)
get '/' do
  erb :index
end

# Receive Slack POST request, remove Slackbot trigger word, assign action word to variable.
post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  action, team_name, interval = message.split(' ').map {|c| c.strip.downcase }

  team_name ||= "team1"
  interval ||= 1

  interval = interval.to_i * 3600

  team = Team.find_or_create_by(name: team_name)

  if team.timer.nil?
    team.timer = Timer.create(interval: interval)
  end

  case action
    when 'start'

      team.timer.running = true
      team.timer.save

      Log.create(notified_at: DateTime.now)
      @worker = Worker.new(team, interval)

      Message.perform_in(1, "start", team_name, interval)
      @worker.start
    when 'stop'
      Message.perform_in(1, "stop")
      team.timer.running = false
      team.timer.save
  end
end