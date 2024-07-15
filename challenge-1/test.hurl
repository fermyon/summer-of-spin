GET http://localhost:3000
HTTP 200
[Asserts]
header "x-encryption-module-path" exists
header "x-name" exists
header "content-type" == "application/json"
body exists
[Captures]
encryptionModulePath: header "x-encryption-module-path"
name: header "x-name"
body: jsonpath "$.encryptedMessage"

PUT http://localhost:3000/{{encryptionModulePath}}
x-action: decrypt
`{{body}}`
HTTP 200
[Asserts]
jsonpath "$.response" == "Formation:\n\n    4-3-3\n\nKey Plays:\n\n    Play 1: The Lightning Strike\n        Formation shifts to 3-4-3 in the 70th minute.\n        Jamie Roberts moves forward to support the midfield.\n        Riley Taylor switches to the left wing.\n        Avery Wilson plays as a false nine, dropping back to draw defenders out of position.\n\n    Play 2: The Iron Curtain\n        Formation shifts to 5-3-2 when defending a lead in the last 10 minutes.\n        Casey Lee and Taylor Johnson take on sweeper roles.\n        Sydney Clarke drops back to form a three-person defensive midfield with Jordan Davis and Avery Wilson.\n        Blake Murphy and Cameron Evans stay forward for counter-attacks.\n\n    Play 3: The Phantom Goal\n        Execute in the first 15 minutes of the second half.\n        Quick, short passes to draw the opposition’s midfield out of position.\n        Riley Taylor and Blake Murphy switch sides to confuse defenders.\n        Cameron Evans makes a diagonal run into the box, looking for a through ball from Jordan Davis.\n\nAdditional Strategy:\n\n    High press for the first 20 minutes to unsettle the opposition defense.\n    Utilize the wings for fast counter-attacks.\n    Maintain possession with short, controlled passes in the midfield.\n\nStarting Lineup:\n\n    Goalkeeper: Alex Smith\n    Right Back: Jamie Roberts\n    Center Back: Taylor Johnson\n    Center Back: Casey Lee\n    Left Back: Morgan Brown\n    Defensive Midfield: Jordan Davis\n    Central Midfield: Sydney Clarke\n    Central Midfield: Avery Wilson\n    Right Wing: Riley Taylor\n    Striker: Cameron Evans\n    Left Wing: Blake Murphy\n\nSubstitutes:\n\n    Goalkeeper: Pat Green\n    Defender: Sam Harper\n    Midfielder: Drew Bailey\n    Forward: {{name}}"




