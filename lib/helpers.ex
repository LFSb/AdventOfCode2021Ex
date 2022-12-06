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
  # def get_life_support_rating(input) do
  # end

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
      _ -> -1
    end
  end

  def calculate_round_result(opponent_hand, own_hand) do
    own_hand_score = own_hand |> calculate_hand_score
    opponent_hand_score = opponent_hand |> calculate_hand_score

    own_index = own_hand_score - 1
    other_index = opponent_hand_score - 1

    cond do
      own_index == rem(other_index + 1, 3) -> 6 + own_hand_score
      own_index == other_index -> 3 + own_hand_score
      other_index == rem(own_index + 1, 3) -> 0 + own_hand_score
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

    opponent_hand_score = opponent_hand |> calculate_hand_score

    case calculated_result do
      6 -> rem(opponent_hand_score, 3) + 1 + calculated_result
      3 -> opponent_hand_score + calculated_result
      0 -> if opponent_hand_score - 1 == 0, do: 3, else: opponent_hand_score - 1
    end
  end

  def intersect(mapsets) do
    MapSet.intersection(Enum.at(mapsets, 0), Enum.at(mapsets, 1))
  end

  def intersect_3(mapsets) do
    MapSet.intersection(
      MapSet.intersection(Enum.at(mapsets, 0), Enum.at(mapsets, 1)),
      Enum.at(mapsets, 2)
    )
  end

  def convert_to_priority(item) do
    <<c::utf8>> = item

    if c > 96 do
      c - 96
    else
      c - 38
    end
  end

  def get_half_length(input) do
    (String.length(input) / 2) |> round
  end

  def contains_range(a) do
    first = Enum.at(a, 0)
    second = Enum.at(a, 1)

    (elem(first, 0) >= elem(second, 0) && elem(first, 1) <= elem(second, 1)) ||
      (elem(second, 0) >= elem(first, 0) && elem(second, 1) <= elem(first, 1))
  end

  def ranges_overlap(a) do
    first = Enum.at(a, 0)
    second = Enum.at(a, 1)

    firstMapSet = elem(first, 0)..elem(first, 1) |> MapSet.new()
    secondMapSet = elem(second, 0)..elem(second, 1) |> MapSet.new()

    MapSet.intersection(firstMapSet, secondMapSet) |> MapSet.size() != 0
  end

  def build_tower(input) do
    input
    |> Enum.reverse()
    |> Enum.map(fn x -> x |> String.graphemes() |> Enum.drop(1) |> Enum.take_every(4) end)
    |> Enum.drop(1)
    |> Enum.zip()
  end

  def parse_instruction(instruction) do
    split = instruction |> String.split(" ")

    {split |> Enum.at(1) |> String.to_integer(), split |> Enum.at(3) |> String.to_integer(),
     split |> Enum.at(5) |> String.to_integer()}
  end

  def execute_instruction(tower, move_amount, source, target) do
    1..move_amount |> Enum.reduce(tower, fn _, acc -> move_top(acc, source, target) end)
  end

  def move_top(tower, source, target) do
    empty_place = " "
    source_tower = tower |> Enum.at(source - 1)
    index_to_retrieve = source_tower |> Enum.find_index(fn x -> x != empty_place end) || 0
    target_tower = tower |> Enum.at(target - 1)
    index_to_insert = target_tower |> Enum.find_index(fn x -> x != empty_place end) || 0

    target_tower =
      target_tower |> List.insert_at(index_to_insert, Enum.at(source_tower, index_to_retrieve))

    source_tower = source_tower |> List.update_at(index_to_retrieve, &(&1 = empty_place))

    tower
    |> List.update_at(source - 1, &(&1 = source_tower))
    |> List.update_at(target - 1, &(&1 = target_tower))
    |> Enum.map(fn x -> x |> Enum.reject(fn y -> y == empty_place end) end)
  end

  def move_stack(tower, amount, source, target) do
    empty_place = " "
    source_tower = tower |> Enum.at(source - 1)
    index_to_retrieve = source_tower |> Enum.find_index(fn x -> x != empty_place end) || 0

    stack = source_tower |> Enum.slice(index_to_retrieve..(amount - 1)) |> Enum.reverse()

    target_tower = tower |> Enum.at(target - 1)
    index_to_insert = target_tower |> Enum.find_index(fn x -> x != empty_place end) || 0

    target_tower =
      stack
      |> Enum.reduce(target_tower, fn x, acc -> acc |> List.insert_at(index_to_insert, x) end)

    source_tower = source_tower |> Enum.drop(amount)

    tower
    |> List.update_at(source - 1, &(&1 = source_tower))
    |> List.update_at(target - 1, &(&1 = target_tower))
    |> Enum.map(fn x -> x |> Enum.reject(fn y -> y == empty_place end) end)
  end

  def find_marker(input, seq_len) do
    (input
     |> String.graphemes()
     |> Enum.chunk_every(seq_len, 1, :discard)
     |> Enum.map(fn x ->
       x |> Enum.frequencies() |> Map.values() |> Enum.all?(fn y -> y == 1 end)
     end)
     |> Enum.find_index(fn z -> z == true end)) + seq_len
  end
end
