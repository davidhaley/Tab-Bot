require 'httparty'

# Homepage (Root path)
get '/' do
  erb :index
end

# Receive Slack POST request, remove Slackbot trigger word, assign action word to variable.
post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  # action, team_name, interval = message.split(' ').map {|c| c.strip.downcase }

  input = message.split(' ').map {|c| c.strip.downcase }
  action = input.shift
  interval = input.pop

  team_name = "team"

  interval ||= 1
  interval = interval.to_i * 60

  team = Team.find_or_create_by(name: team_name)

  if team.timer.nil?
    team.timer = Timer.create(interval: interval)
  else
    team.timer.update(interval: interval)
  end

  case action
  when 'start'
  if interval.to_s.size < 5
    if interval > 0

      team.timer.running = true
      team.timer.save

      Log.create(notified_at: DateTime.now)
      @worker = Worker.new(team, interval)

      Message.perform_in(1, "start", team_name, interval)
      @worker.start
    end
  else
    Message.perform_in(1, "help")
  end
  when 'stop'
    Message.perform_in(1, "stop")
    team.timer.update(running: false)
    team.timer.save
  when 'help'
    Message.perform_in(1, "help")
  else
    Message.perform_in(1, "interval_count")
  end
end