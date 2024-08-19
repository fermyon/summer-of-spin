# Challenge 4

Welcome to the 4th and final challenge of Summer of Spin 2024!

In this challenge, you will get an intro to Spin Key-Value store by building an application that allows your favorite football (soccer) team to keep track of their players calorie intake during the summer break.

## Spec

It's summer time and your local football league is on break. For players, it's a time to rewind after the long season of intense games. Your local team is worried the players may become unfit by the time they resume for the next season. To ensure that they give the best personalized recovery to all the players when the season resume, they have decided to build an application to keep track of the players' calorie in-take.

Now, it's your job to build this application as a great programmer and supporter of the team!

The application needs to have 2 endpoints:

- `POST /register {player_name: string, player_no: int}`: This endpoint allows the head coach to register a player by providing their name and number in the request body.

  The response for this endpoint should look like:

  `201`: `{"player_name": "<PLAYER_NAME>", "player_no": "<PLAYER_NO>"}`

  ### Notes:

  - When there is a request to add a player with an already existing number, return a `409` response.
  - When there is an invalid input, return a `400` response.
  - You don't have to implement any form of authentication. You can assume that only the team coach will have access to the endpoint.

- `POST /record {player_no: int, calories: int}`: This endpoint allows the player to update their calorie in-take record. The endpoint accepts the player number and the number of calories they want to add.

  The response for this endpoint should look like:

  `200`: `{"player_name": "<PLAYER_NAME>", "calories": "<TOTAL_CALORIES>"}`

  ### Notes:

  - If there is no player with provided number, return a `404` response.
  - When there is an invalid input, return a `400` response.
  - You don't have to implement any form of authentication. You can assume that only the players have access to the endpoint and that each player can only update their record.

[This article](https://developer.fermyon.com/spin/v2/key-value-store-tutorial) on the Fermyon blog is a good starting point on how to use the Spin Key-Value store.
