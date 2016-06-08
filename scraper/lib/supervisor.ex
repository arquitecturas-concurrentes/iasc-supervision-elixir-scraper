defmodule Scraper.Supervisor do

  def start do
    spawn __MODULE__, :loop, []
  end

  def start_link do
    spawn_link __MODULE__, :loop, []
  end

  def loop do
    Process.flag :trap_exit, true
    scraper = Scraper.start_link
    Process.register scraper, :scraper
    receive do
      {:EXIT, ^scraper, :normal} -> :ok
      {:EXIT, ^scraper, _reason} -> loop
    end
  end

end
