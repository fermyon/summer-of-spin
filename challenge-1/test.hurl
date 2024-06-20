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
jsonpath "$.response" == "Hello, {{name}}"




