features = %{test: 1.2, name: "Koala", rank: :fool}
names = ~w[John Alex Sean Andrew Lucas Booo]

dbg(features)
dbg([names | "Jacob"])
dbg(["Jacob" | names])

dbg(__ENV__.file |> Path.basename() |> File.exists?())
