class Worker

  def initialize(team, interval)
    # @running = true
    @team = team
    @interval = interval
  end

  def start(greeting)
    while @team.timer.running
      if DateTime.now < Log.last.notified_at + @team.timer.interval.seconds
        puts "team timer interval: #{@team.timer.interval.seconds}"
        puts "sleeping for 2 seconds"        
        sleep(2)
      else
        Message.perform_in(1, greeting)
        Timer.create(interval: @interval)
        Log.create(notified_at: DateTime.now)
      end
      @team.timer.reload
    end
    @team.timer.destroy
  end

  def stop(greeting)
    Message.perform_in(1, greeting)
    # @running = false
  end
end