POST http://localhost:3000
file,plans.txt;
HTTP 200
[Asserts]
header "x-encryption-module-path" exists
header "x-secret-play" exists
header "content-type" == "application/json"
body exists
[Captures]
encryptionModulePath: header "x-encryption-module-path"
secretPlay: header "x-secret-play"
body: jsonpath "$.encryptedMessage"

POST http://localhost:3000/{{encryptionModulePath}}
x-action: decrypt
`{{body}}`
HTTP 200
[Asserts]
jsonpath "$.response" == "Play 1: Operation Kino, Play 2: Aldo Raine's Masterpiece, Play 3: {{secretPlay}}"