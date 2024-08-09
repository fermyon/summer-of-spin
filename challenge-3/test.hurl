# Test 1
# Please note, that we will use a different set of values when validating your submission
POST http://localhost:3000/api/start
{
    "message": "The game has started, start guessing the word",
    "gameId": "2c047c81-45ac-44cb-ac7b-ad8c73f55d8a",
    "grid": [
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ]
    ],
    "currentRow": 0,
    "solved": false
}
HTTP 200

# Test 2
# Please note, that we will use a different set of values when validating your submission
GET http://127.0.0.1:3000/api/guess?gameId=2c047c81-45ac-44cb-ac7b-ad8c73f55d8a&guess=along
{
    "message": "Congratulations!",
    "gameId": "2c047c81-45ac-44cb-ac7b-ad8c73f55d8a",
    "grid": [
        [
            "a",
            "l",
            "o",
            "n",
            "g"
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            "",
            ""
        ]
    ],
    "currentRow": 0,
    "solved": true,
    "correctLetters": [
        "a",
        "l",
        "o",
        "n",
        "g"
    ]
}

HTTP 200