
defmodule BaconSolver do
  def find(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:find, file, client} ->
        send client, {:answer, file, bacon_find(file), self()}
        find(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  def bacon_find(file) do
    body = File.read!(Path.join("./bacon_ipsum/", file)) |> String.split(" ") 
    count = Enum.count(Enum.filter(body, fn word ->  String.downcase(word) == "bacon" end))

    count
  end
end
