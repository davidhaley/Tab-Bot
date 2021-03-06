class Worker

  def initialize(team, interval)
    @running = true
    @team = team
    @interval = interval
  end

  def start
    while @team.timer.running
      if DateTime.now < Log.last.notified_at + @team.timer.interval.seconds
        puts "team timer interval: #{@team.timer.interval.seconds}"
        puts "sleeping for 2 seconds"        
        sleep(2)
      else
        Message.perform_in(1)
        # Timer.create(interval: @interval)
        Log.create(notified_at: DateTime.now)
        @team.timer.reload
      end
      @team.timer.reload
    end
    @team.timer.reload
    @team.timer.destroy
  end

  def stop
    @running = false
  end
end