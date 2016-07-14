class Timer
  include SuckerPunch::Job
  # workers 1

  def perform(repo_url)
    resp = HTTParty.get(repo_url)
    # puts resp
    resp = JSON.parse resp.body
    interval = 5
    respond_message("Time interval = #{interval}")
  end
end

# respond_message("There are #{resp['open_issues_count']} open issues on #{}. Time interval = #{interval}")