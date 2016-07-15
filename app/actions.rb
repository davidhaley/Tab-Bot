require 'httparty'

# Homepage (Root path)
get '/' do
  erb :index
end

# Receive Slack POST request, remove Slackbot trigger word, assign action word to variable.
post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  action, team_name, interval = message.split(' ').map {|c| c.strip.downcase }

  puts action.inspect
  puts team_name.inspect
  puts interval.inspect

  team = Team.find_or_create_by(name: team_name)

  if team.timer.nil?
    team.timer = Timer.create(interval: interval)
  end

  case action
    when 'start'
      puts action.inspect
      puts team_name.inspect
      puts interval.inspect
      
      team.timer.running = true
      team.timer.save

      Log.create(notified_at: DateTime.now)
      @worker = Worker.new(team, interval)
      puts "interval is #{interval}"

      @worker.start
    when 'stop'
      team.timer.running = false
      team.timer.save
  end
end