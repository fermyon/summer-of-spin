# Introduction

Welcome to the fourth and final challenge of Summer of Spin 2024!

In this challenge, you will get an intro to Spin Key-Value store by building an application that allows your favorite football (soccer) team to keep track of their players calory intake during the summer break.

## Spec

It's summer time and your local football league is on break. For players, it's a time to rewind after the long season of intense games. Your local team is worried the players may become unfit by the time they resume for the next season. To ensure that they give the best personalized recovery to all the players when the season resume, they have decided to build an application to keep track of the players' calory in-take.

Now, it's your job to build this application as a great programmer and supporter of the team!

The application needs to have two endpoints:

- `/register?player_name=<PLAYER_NAME>&player_no=<PLAYER_NO>`: This endpoint allows the head coach to register a player by providing their name and number as query params.

  The response for this endpoint should look like:

  - Success response: `{"success": true, "data": {"player_name": "<PLAYER_NAME>", "player_no": "<PLAYER_NO>"}}`
  - Error response: `{"success": false}}`

  ### Notes:

  - You don't have to implement any form of authentication. You can assume that only the team coach will have access to the endpoint.
  - You can assume that every player has a unique number.
  - When there is a request to add a player with an already existing number, return an error response.

- `/record?player_no=<PLAYER_NO>&calories=<NO_OF_CALORIES>`: This endpoint allows the player to update their calory in-take record. The endpoint accepts the player number and the number of calories they want to add.

  The response for this endpoint should look like:

  - Success response: `{"success": true, "data": {"player_name": "<PLAYER_NAME>", "total_calories": "<TOTAL_CALORIES>"}}`
  - Error response: `{"success": false}`

  ### Notes:

  - You don't have to implement any form of authentication. You can assume that only the players have access to the endpoint and that each player can only update their record.
  - If there is no player with provided number, return an error response.
  - If an invalid value is provided in the calories field, return an error response.

[This article](https://developer.fermyon.com/spin/v2/key-value-store-tutorial) on the Fermyon blog is a good starting point on how to use the Spin Key-Value store.
