# AdventOfCodeEx

Does what it says on the tin. I'm attempting to do AdventOfCode in Elixir, a language I've written nothing in before.

To run all of the tests:

`mix test`

To run the interactive interpreter to figure stuff out with:

`iex -S mix`

Inside iex, `r {{Module}}` to reload whatever {{Module}} you've just made a change to. Afterwards, import it again.


Also, run `aoc d -I -i lib/inputs/2022/dayX.txt` to download the latest puzzle input file to dayX.txt. 

For this, you of course need [Elixir](brew install elixir) installed, and also the [aoc-cli](brew install scarvalhojr/tap/aoc-cli).
