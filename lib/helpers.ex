defmodule Helpers do
  # Basically, we want n-1, but we don't want -1 as a result.
  def safePreviousIdx(n) do
    if(n > 0, do: n - 1, else: n)
  end

  def isValueLargerThanPreviousIdx(input, idx) do
    Enum.at(input, idx) > Enum.at(input, safePreviousIdx(idx))
  end

  def getWindowSum(input, idx) do
    input
    |> Enum.drop(idx)
    |> Enum.take(3)
    |> Enum.sum()
  end

  def isWindowLargerThanPreviousWindow(input, idx) do
    getWindowSum(input, idx) > getWindowSum(input, safePreviousIdx(idx))
  end

  def parseDirections(input) do
    input
    |> Enum.map(fn i -> String.split(i, " ") end)
    |> Enum.map(fn item -> List.to_tuple(item) end)
  end

  def processInstruction(input, pos) do
    distance = elem(input, 1) |> String.to_integer()

    case elem(input, 0) do
      "forward" -> {elem(pos, 0), elem(pos, 1) + distance}
      "up" -> {elem(pos, 0) - distance, elem(pos, 1)}
      "down" -> {elem(pos, 0) + distance, elem(pos, 1)}
      _ -> IO.puts("You fucked up, dumbass")
    end
  end

  def aimSights(input, pos) do
    distance = elem(input, 1) |> String.to_integer()

    case elem(input, 0) do
      "forward" -> {elem(pos, 0) + distance, elem(pos, 1) + elem(pos, 2) * distance, elem(pos, 2)}
      "up" -> {elem(pos, 0), elem(pos, 1), elem(pos, 2) - distance}
      "down" -> {elem(pos, 0), elem(pos, 1), elem(pos, 2) + distance}
      _ -> IO.puts("You fucked up, dumbass.")
    end
  end

  def getColumnWidth(input) do
    width =
      input
      |> Enum.fetch!(0)
      |> String.length()

    # We're indexing by 0.
    width - 1
  end

  # This gives us a 0-indexed list of character freqencies per column of input.
  def getColumnFrequencies(input) do
    0..getColumnWidth(input)
    |> Enum.map(fn idx -> input |> Enum.map(fn line -> line |> String.at(idx) end) end)
    |> Enum.map(fn line -> line |> Enum.frequencies() end)
  end

  # This makes a lot of assumptions, but if you pass it "10110", it will return 22.
  def convertToDecimal(input) do
    input
    |> Integer.parse(2)
    |> elem(0)
  end

  def invertMap(map) do
    map |> Enum.map(fn m -> m |> Map.new(fn {key, val} -> {val, key} end) end)
  end

  def calculateRateByFunc(map, func) do
    map
    |> Enum.map(func)
    |> Enum.map(fn t -> t |> elem(1) end)
    |> Enum.join()
  end

  # Here, based on said 0-indexed list of character frequencies we should construct both the gamma and the epsilon rates.
  # The gamma rate is made up from the MSB (Most Significant Bit) in each column, the epsilon rate is made up from the LSB (Least Significant Bit) in each column.
  # The power consumption is then calculated by multiplying the decimal representation of the gamma rate and the epsilon rate.

  def getPowerConsumption(frequencies) do
    # First, we invert the map for easier sorting.
    inverted = frequencies |> invertMap

    gamma = inverted |> calculateRateByFunc(fn m -> m |> Enum.max() end) |> convertToDecimal

    epsilon = inverted |> calculateRateByFunc(fn m -> m |> Enum.min() end) |> convertToDecimal

    gamma * epsilon
  end

  def filterInputByIndex(input) do
    invertedFrequencies = input |> getColumnFrequencies |> invertMap

    index = invertedFrequencies |> Enum.find_index(fn f -> f |> Map.keys |> length > 1 end) # Here we get the first index of a map inside the frequencies that has more than one key. That should give us the index of the character in the search space we should filter.
    
    index = if index |> is_nil do -1 else index end
    
    searchChar = invertedFrequencies |> Enum.at(index) |> Enum.max |> elem(1)

    input |> Enum.filter(fn i -> i |> String.at(index) == searchChar end) #This is a rough outline as to how we can filter a list of strings based on the occurance of a specific character at a specific position in the string.    
  end

  # Calculating the life support rating is similar to the power consumption, but a little different:
  # Instead of taking the MSB and LSB of each of the columns, We should filter the search space by whether or not they contain the MSB or LSB in a specific position. 
  def getLifeSupportRating(input) do
     
  end
end
