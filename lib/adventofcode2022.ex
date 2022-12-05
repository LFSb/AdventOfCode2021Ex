defmodule Adventofcode2022 do
  import Helpers

  def day1p1(input) do
    input
    |> Helpers.chunk_by_empty()
    |> Enum.map(fn chunk -> chunk |> Enum.map(&String.to_integer/1) |> Enum.sum() end)
    |> Enum.max()
  end

  def day1p2(input) do
    input
    |> Helpers.chunk_by_empty()
    |> Enum.map(fn chunk -> chunk |> Enum.map(&String.to_integer/1) |> Enum.sum() end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  def day2p1(input) do
    input
    |> Enum.map(fn x -> x |> String.split(" ") |> List.to_tuple() end)
    |> Enum.map(fn x -> calculate_round_result(elem(x, 0), elem(x, 1)) end)
    |> Enum.sum()
  end

  def day2p2(input) do
    input
    |> Enum.map(fn x -> x |> String.split(" ") |> List.to_tuple() end)
    |> Enum.map(fn x -> calculate_desired_round_result(elem(x, 0), elem(x, 1)) end)
    |> Enum.sum()
  end

  def day3p1(input) do
    input
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.chunk_every(line |> get_half_length)
      |> Enum.map(fn chunk ->
        chunk
        |> Enum.uniq()
        |> MapSet.new()
      end)
      |> intersect
      |> MapSet.to_list()
      |> Enum.at(0)
      |> convert_to_priority
    end)
    |> Enum.sum()
  end

  def day3p2(input) do
    input
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      group
      |> Enum.map(fn line -> line |> String.graphemes() |> Enum.uniq() |> MapSet.new() end)
      |> intersect_3
      |> MapSet.to_list()
      |> Enum.join()
      |> convert_to_priority
    end)
    |> Enum.sum()
  end

  def day4p1(input) do
    input
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(fn group ->
        group
        |> String.split("-")
        |> Enum.map(fn pair -> pair |> String.to_integer() end)
        |> List.to_tuple()
      end)
      |> contains_range
    end)
    |> Enum.count(fn range -> range == true end)
  end

  def day4p2(input) do
    input
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(fn group ->
        group
        |> String.split("-")
        |> Enum.map(fn pair -> pair |> String.to_integer() end)
        |> List.to_tuple()
      end)
      |> ranges_overlap
    end)
    |> Enum.count(fn range -> range == true end)
  end

  def day5p1(input) do
    tower =
      input
      |> chunk_by_empty
      |> Enum.at(0)

    tower
    |> Enum.reverse
    |> Enum.map(fn x -> x |> String.graphemes() |> Enum.drop(1) |> Enum.take_every(4) end)
    |> Enum.drop(1)
    |> Enum.zip
  end
end
