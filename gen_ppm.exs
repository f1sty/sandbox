defmodule GenPpm do
  def generate(
        mode \\ :palette,
        file_path \\ "test.ppm",
        {width, height} = resolution \\ {800, 600},
        colour \\ 0x4287F5
      ) do
    colour = transform_to_binary(colour)
    canvas = Tuple.append(resolution, colour)
    # header = header(resolution)

    data =
      case mode do
        :palette -> [header(resolution) | fill_rectangle_palette(resolution)]
        :normal -> [header(resolution) | fill_rectangle(canvas)]
        _ -> {:error, :unknown_mode}
      end

    # [header | rest] = data
    # Enum.take(rest, width * 2) |> IO.inspect(label: :line)
    File.write!(file_path, data)
  end

  defp header({width, height}) do
    "P6\n#{width} #{height} 255\n"
  end

  defp fill_rectangle({width, height, colour}) do
    for _dot <- 0..(width * height), do: colour
  end

  defp fill_rectangle_palette({width, height}) do
    # dots = height * width

    for x <- 1..width, y <- 1..height do
      u = round(x / width * 255)
      v = round(y / height * 255)
      z = round(:rand.uniform() * 255)
      <<u::8, z::8, v::8>>
    end
  end

  defp transform_to_binary(colour) do
    import Bitwise

    r = colour >>> 16 &&& 0x0000FF
    g = colour >>> 8 &&& 0x0000FF
    b = colour &&& 0x0000FF

    <<r::8, g::8, b::8>>
  end
end
