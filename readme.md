# Connect Four (or more)
## to run
Clone the repo, navigate to the directory, and run  

```
bundle install
ruby game.rb
```
## Time Spent
Just short of three hours
## Key Decisions
###Null Piece:
I decided to use a Null Piece class with the same API as my Piece class. This lets me not worry too much about checking wether there's a piece at a certain position before I call some methods on whatever's in that position. This came in pretty handy when I was printing the board.
### Game, Board, Player, and Piece classes, Game Loop:
Having the game class manage the game loop, the board class manage the movement of pieces, and the Pieces class for covinience methods seemed to me like the most straight-forward way to structure a game using OOP. I also put the player in it's own class, which will make it easier to implement a computer player if I decide to do so in the future.
## Runtime Complexity
The Board#won? method runs in constant time O(1). It's a depth-first search around the positions adjacent to it, and because of the nature of connect-four the positions adjacent ot it are either empty, out-of-bounds, or visited (and memo-ized).

## Thoughts on project
I enjoyed the project especially the hint to try and optimize the algorithm to check the winnings moves. It was just enough of a hint to make me aware that there's an interesting problem to solve, but not enough of a hint that it takes away the satisfaction of solving it myself.