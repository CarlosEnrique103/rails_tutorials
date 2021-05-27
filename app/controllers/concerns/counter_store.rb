module CounterStore
  private

  def counter_push
    session[:counter] = 0 if session[:counter].nil?

    session[:counter] += 1
    @counter = session[:counter]
  end

  def counter_reset
    session[:counter] = nil
  end
end
