# Test 1
# Please note, that we will use a different set of values when validating your submission
POST http://localhost:3000/plan-my-trip
{
    "tag": "week-in-banff"
    "destination": "Banff",
    "duration": "1 week",
    "num_people": "four",
    "activities": ["hiking", "camping", "long drive", "food"]
    
}

HTTP 201
[Asserts]
jsonpath "$.itinerary" != null

# Test 2
# Please note, that we will use a different set of values when validating your submission
GET http://localhost:3000/<tag>

HTTP 200
[Asserts]
jsonpath "$.itinerary" != null