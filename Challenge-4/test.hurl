# Test 1: Register a new player successfully

POST http://localhost:3000/register
Content-Type: application/json

{
  "player_name": "John Doe",
  "player_no": 10
}

HTTP/1.1 201
[Asserts]
jsonpath "$.player_name" == "John Doe"
jsonpath "$.player_no" == 10


POST http://localhost:3000/register
Content-Type: application/json

# Test 2: Register a Player with an Existing Number

{
  "player_name": "Jane Smith",
  "player_no": 10
}

HTTP/1.1 409

# Test 3: Record Calories Successfully

POST http://localhost:3000/record
Content-Type: application/json

{
  "player_no": 10,
  "calories": 500
}

HTTP/1.1 200
[Asserts]
jsonpath "$.player_name" == "John Doe"
jsonpath "$.calories" == 500

# Test 4: Record Calories for Non-Existent Player

POST http://localhost:3000/record
Content-Type: application/json

{
  "player_no": 99,
  "calories": 300
}

HTTP/1.1 404

# Test 5: Record Invalid Calories Value

POST http://localhost:3000/record
Content-Type: application/json

{
  "player_no": 10,
  "calories": -100
}

HTTP/1.1 400
