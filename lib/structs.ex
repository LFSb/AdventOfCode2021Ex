defmodule Dir do
  defstruct path: "", children: []
end

defmodule File2 do
  defstruct name: "", size: 0
end

defmodule Day7 do
  def sum_files([]) do
    0
  end

  def sum_files([%File2{} = head | tail]) do
    sum_files(tail) + head.size
  end

  def sum_files([%Dir{} = head | tail]) do
    dir_size = sum_files(head.children) + sum_files(tail)
    if dir_size < 100_000, do: dir_size, else: 0
  end
end
