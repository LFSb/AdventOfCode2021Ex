defmodule Dir do
  defstruct path: "", children: []
end

defmodule File2 do
  defstruct name: "", size: 0
end

defmodule Day7 do
  @moduledoc """
  This just solves Day 7, as long as you provide the directory structure as a list of Dir's containing subsequent children. 
  """
  def p1(list) do
    p1(list, 0)
  end

  defp p1([], sum) do
    sum
  end

  defp p1([%{name: _, size: _} = head | tail], sum) do
    p1(tail, sum) + head.size + sum
  end

  defp p1([%{path: _, children: _} = head | tail], sum) do
    dir_size = p1(head.children, sum) + p1(tail, sum)
    if dir_size < 100_000, do: dir_size, else: 0
  end
end
