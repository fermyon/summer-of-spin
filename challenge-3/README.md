# Challenge 3 - 2024

Welcome to the third challenge of Fermyon’s Summer of Spin 2024! 🥳

For this challenge you'll need to use:

- Spin CLI
- Your favorite programming [language](https://www.fermyon.com/wasm-languages/webassembly-language-support/) supported in Spin
- Working with Spin's key-value store.
- Fermyon cloud

## Spec

It's summertime, the perfect season for fun and engaging activities. Summertime is all about traveling, spending time with loved ones, and exploring new things. However, due to heatwaves, it can be challenging to go outside and explore. So, what can we do at home to kill boredom? Don't worry, we've got you covered. Let's make a game! Your challenge this week is to create and solve the popular game called WORDLE.

The game is pretty straightforward. In this game, players are tasked with guessing a hidden five-letter word from a predefined dictionary. Each guess must be a valid five-letter word, and the game provides feedback on the accuracy of your guess. If you guess the correct word, congratulations! You've solved the puzzle. If not, you can keep trying until you use up all your attempts.

For this challenge, you need to create two APIs: one to start the game and another to guess the words.

First, call the api/start to initialize the game, e.g., `curl -X POST http://127.0.0.1:3000/api/start`

```json
{
  "message": "The game has started, start guessing the word",
  "gameId": "350a4fbe-048e-42ad-a818-01a447a96d95",
  "grid": [["", "", "", "", ""], ["", "", "", "", ""], ..., ["", "", "", "", ""]],
  "currentRow": 0,
  "solved": false
}

```

To guess the word, call the api/guess with the parameter of the guessed word, e.g., `curl http://127.0.0.1:3000/api/guess?gameId=<game_id>&guess=apple`

```json
{
  "message": "The game has started, start guessing the word",
  "gameId": "350a4fbe-048e-42ad-a818-01a447a96d95",
  "grid": [["a", "p", "p", "l", "e"], ["", "", "", "", ""], ..., ["", "", "", "", ""]],
  "currentRow": 0,
  "solved": false
}

```

### Notes:

- If an invalid word is provided in the grid, return an error response.
- A frontend for the challenge would be great, but it is not compulsory.
- Last but not least, deploy this application to Fermyon Cloud.