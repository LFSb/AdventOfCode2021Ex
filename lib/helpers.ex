defmodule Helpers do
  # Basically, we want n-1, but we don't want -1 as a result.
  def safe_previous_idx(n) do
    if(n > 0, do: n - 1, else: n)
  end

  def is_value_larger_than_previous_idx(input, idx) do
    Enum.at(input, idx) > Enum.at(input, safe_previous_idx(idx))
  end

  def get_window_sum(input, idx) do
    input
    |> Enum.drop(idx)
    |> Enum.take(3)
    |> Enum.sum()
  end

  def is_window_larger_than_previous_window(input, idx) do
    get_window_sum(input, idx) > get_window_sum(input, safe_previous_idx(idx))
  end

  def parse_directions(input) do
    input
    |> Enum.map(fn i -> String.split(i, " ") end)
    |> Enum.map(fn item -> List.to_tuple(item) end)
  end

  def process_instruction(input, pos) do
    distance = elem(input, 1) |> String.to_integer()

    case elem(input, 0) do
      "forward" -> {elem(pos, 0), elem(pos, 1) + distance}
      "up" -> {elem(pos, 0) - distance, elem(pos, 1)}
      "down" -> {elem(pos, 0) + distance, elem(pos, 1)}
      _ -> IO.puts("You fucked up, dumbass")
    end
  end

  def aim_sights(input, pos) do
    distance = elem(input, 1) |> String.to_integer()

    case elem(input, 0) do
      "forward" -> {elem(pos, 0) + distance, elem(pos, 1) + elem(pos, 2) * distance, elem(pos, 2)}
      "up" -> {elem(pos, 0), elem(pos, 1), elem(pos, 2) - distance}
      "down" -> {elem(pos, 0), elem(pos, 1), elem(pos, 2) + distance}
      _ -> IO.puts("You fucked up, dumbass.")
    end
  end

  def get_column_width(input) do
    width =
      input
      |> Enum.fetch!(0)
      |> String.length()

    # We're indexing by 0.
    width - 1
  end

  # This gives us a 0-indexed list of character freqencies per column of input.
  def get_column_frequencies(input) do
    0..get_column_width(input)
    |> Enum.map(fn idx -> input |> Enum.map(fn line -> line |> String.at(idx) end) end)
    |> Enum.map(fn line -> line |> Enum.frequencies() end)
  end

  # This makes a lot of assumptions, but if you pass it "10110", it will return 22.
  def convert_to_decimal(input) do
    input
    |> Integer.parse(2)
    |> elem(0)
  end

  def calculate_rate_by_func(map, func) do
    map
    |> Enum.map(func)
    |> Enum.map(fn t -> t |> elem(1) end)
    |> Enum.join()
  end

  # Here, based on said 0-indexed list of character frequencies we should construct both the gamma and the epsilon rates.
  # The gamma rate is made up from the MSB (Most Significant Bit) in each column, the epsilon rate is made up from the LSB (Least Significant Bit) in each column.
  # The power consumption is then calculated by multiplying the decimal representation of the gamma rate and the epsilon rate.

  def get_power_consumption(frequencies) do
    # First, we invert the map for easier sorting.
    inverted = frequencies |> invert_map

    gamma = inverted |> calculate_rate_by_func(fn m -> m |> Enum.max() end) |> convert_to_decimal

    epsilon =
      inverted |> calculate_rate_by_func(fn m -> m |> Enum.min() end) |> convert_to_decimal

    gamma * epsilon
  end

  def invert_map(map) do
    map |> Enum.map(fn m -> m |> Map.new(fn {key, val} -> {val, key} end) end)
  end

  def determine_by_msb(frequency, msb) do
    case msb do
      true -> frequency |> Enum.max() |> elem(1)
      false -> frequency |> Enum.min() |> elem(1)
    end
  end

  def return_search_char(frequencies, index, msb) do
    frequency = frequencies |> Enum.at(index)

    frequencyValues = frequency |> Map.values()

    equal = Enum.at(frequencyValues, 0) == Enum.at(frequencyValues, 1)

    case equal do
      true -> if msb, do: "1", else: "0"
      false -> frequency |> Map.new(fn {key, val} -> {val, key} end) |> determine_by_msb(msb)
    end
  end

  def filter_input_by_index(input, msb) do
    frequencies = input |> get_column_frequencies

    # Here we get the first index of a map inside the frequencies that has more than one key. That should give us the index of the character in the search space we should filter.
    index = frequencies |> Enum.find_index(fn f -> f |> Map.keys() |> length > 1 end)

    index =
      if index |> is_nil do
        # if the above can't find an index, compare the last occurance.
        -1
      else
        index
      end

    searchChar = frequencies |> return_search_char(index, msb)

    # This is a rough outline as to how we can filter a list of strings based on the occurance of a specific character at a specific position in the string.    
    input |> Enum.filter(fn i -> i |> String.at(index) == searchChar end)
  end

  # Calculating the life support rating is similar to the power consumption, but a little different:
  # Instead of taking the MSB and LSB of each of the columns, We should filter the search space by whether or not they contain the MSB or LSB in a specific position. 
  def get_life_support_rating(input) do
  end

  def chunk_by_empty(input) do
    input
    |> Enum.chunk_by(fn i -> i == "" end)
    |> Enum.reject(fn chunk -> chunk |> List.first() == "" end)
  end

  def calculate_hand_score(own_hand) do
    case own_hand do
      # Rock
      "X" -> 1
      "A" -> 1
      # Paper
      "Y" -> 2
      "B" -> 2
      # Scissors
      "Z" -> 3
      "C" -> 3
      _ -> 0
    end
  end

  def calculate_round_result(opponent_hand, own_hand) do
    # Rock (X, 1) -> Scissors (Z, 3)
    # Scissors (Z, 3) -> Paper (Y, 2)
    # Paper (Y, 2) -> Rock (X, 1)

    # win = 6, draw = 3, 0 = lose 
    own_hand_score = own_hand |> calculate_hand_score

    case {own_hand, calculate_hand_score(opponent_hand) + own_hand_score} do
      {"Y", 3} -> 6 + own_hand_score
      {"Y", 4} -> 3 + own_hand_score
      {"Y", 5} -> 0 + own_hand_score
      {"Z", 5} -> 6 + own_hand_score
      {"Z", 6} -> 3 + own_hand_score
      {"Z", 4} -> 0 + own_hand_score
      {"X", 4} -> 6 + own_hand_score
      {"X", 2} -> 3 + own_hand_score
      {"X", 3} -> 0 + own_hand_score
      _ -> 0
    end
  end

  def calculate_desired_result(input) do
    case input do
      # Draw
      "Y" -> 3
      # Lose
      "X" -> 0
      # Win
      "Z" -> 6
    end
  end

  def calculate_desired_round_result(opponent_hand, desired_result) do
    
    calculated_result = desired_result |> calculate_desired_result

    case {opponent_hand, calculated_result} do
      {"A", 3} -> calculate_hand_score("X") + calculated_result # Draw
      {"A", 0} -> calculate_hand_score("Z") + calculated_result # Lose
      {"A", 6} -> calculate_hand_score("Y") + calculated_result # Win
      {"B", 3} -> calculate_hand_score("Y") + calculated_result # Draw
      {"B", 0} -> calculate_hand_score("X") + calculated_result # Lose
      {"B", 6} -> calculate_hand_score("Z") + calculated_result # Win
      {"C", 3} -> calculate_hand_score("Z") + calculated_result # Draw
      {"C", 0} -> calculate_hand_score("Y") + calculated_result # Lose
      {"C", 6} -> calculate_hand_score("X") + calculated_result # Win

    end
  end
end
