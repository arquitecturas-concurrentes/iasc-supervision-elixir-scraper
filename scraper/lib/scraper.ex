defmodule Scraper do

  # ------- Client API

  def start do
    spawn __MODULE__, :loop, []
  end

  def start_link do
    spawn_link __MODULE__, :loop, []
  end

  def titles(url) do
    ref = make_ref
    send :scraper, {self, ref, url}
    receive do
      {^ref, titles} -> {:ok, titles}
    after
      3_000 -> {:error, :timeout}
    end
  end

  # ------- Private

  def loop do
    receive do
      {from, ref, url} ->
        send from, {ref, fetch_titles(url)}

      _ ->
        IO.puts "Message not understood :("
    end
    loop
  end

  defp fetch_titles(url) do
    url
    |> HTTPoison.get!
    |> parse_headers
  end

  defp parse_headers(%HTTPoison.Response{status_code: 200, body: body}) do
    Enum.flat_map ["h1", "h2", "h3"], fn selector ->
      body
      |> Floki.find(selector)
      |> Enum.map(&element_text/1)
    end
  end

  defp element_text({_tag, _attributes, [text]}) do
    text
  end

end
