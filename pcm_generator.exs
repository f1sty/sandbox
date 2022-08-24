defmodule PcmGenerator do
  def generate(
        file_path \\ "test.pcm",
        freq \\ 48000,
        duration \\ 5.0,
        volume \\ 0.2,
        divisor \\ 0.03
      ) do
    Enum.map(0..round(freq * duration), fn sample ->
      tick = :math.sin(sample * divisor) * volume
      tack = :math.sin(sample * divisor * 2) * volume
      tock = :math.sin(sample * divisor * 3) * volume
      # tick = :math.sin(:rand.uniform() * freq) * volume
      <<tick::float-little-32, tack::float-little-32, tock::float-little-32>>
    end)
    |> then(&File.write!(file_path, &1))
  end
end
