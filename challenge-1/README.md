# Overview 

Welcome to the first challenge of Summer of Spin! In this challenge, you will demonstrate the following skills:

- HTTP calls
- Building Spin apps with pre-built components

## Scenario

You are the head coach of an intensely competitive summer soccer team, and you have been having trouble with the coaches of the other teams intercepting key plays that will help you win the summer tournament. You have devised a list of code names that represent key plays that will ensure your victory. All you need to do is add a final play to your playbook; however, you accidentally encrypted the playbook before you could add the code name of the final play. You need to decrypt the playbook, add the code name of the final play, and then re-encrypt the playbook for safekeeping.


## \*\*\*\**DISCLAIMER*\*\*\*\*

This challenge includes a WebAssembly component (`/encryption-module/main.wasm`) that performs cryptographic operations. While it's not a concern in this case because there is no sensitive data being handled, performing cryptographic tasks in a WebAssembly application is not secure. Specifically, WebAssembly doesn't have constant-time operations, which opens up vulnerabilities to [timing attacks](https://en.m.wikipedia.org/wiki/Timing_attack). Please reach out to us via [Discord](https://www.fermyon.com/blog/fermyon-discord) with any questions. 

# Building the application

## Requirements

- Most recent version of [Spin](https://developer.fermyon.com/spin/v2/install)
- See language-specific requirements
    - [Rust](https://developer.fermyon.com/spin/v2/rust-components)
    - [Golang](https://developer.fermyon.com/spin/v2/go-components)
    - [Python](https://developer.fermyon.com/spin/v2/python-components)
    - [JavaScript](https://developer.fermyon.com/spin/v2/javascript-components)
    - [Other Languages](https://developer.fermyon.com/spin/v2/other-languages)

## Instructions

You will be building a Spin app (using `encryption-module/main.wasm` as a component) that will do the following:

- Receive an HTTP POST request containing the binary data of the encrypted string from the `plans.txt` file.
- Decrypt the string using the encryption module.
- Append the desired code name for the play to the end of the decrypted string.
- Re-encrypt the newly-created string using the encryption module.
- Return an HTTP response with the following values:
    - Response code: 200
    - Headers:
        - `content-type`: `application/json`
        - `x-secret-play`: The name value you appended to the decrypted string
        - `x-encryption-module-path`: The HTTP trigger path you defined for the encryption module in the `spin.toml` file
    - Body: A utf-8 encoded JSON object with `"encryptedMessage"` as the key, and the re-encrypted string as the value.

### Example

Request to the main Spin app:

```bash
curl --request POST --data-binary @plans.txt localhost:3000
```

Response from the main Spin app:

```
HTTP/1.1 200 OK
content-type: application/json
x-secret-play: Very Secret Play
x-encryption-module-path: crypto

Response body:  
{"encryptedMessage":"kBgDsdusxSCuzKMjJKSkZYJjhB3O9y0rjP1PHSd9mpXbuJoIe5VXNh2o+yYSRJKbCWGGGnQ2bB3yY7C/QC7rNQINm9GnFBFT7quGCco7xP24EMJf2IV/DcxFVMqka0XRA+5f93LilWSm1xMimi8="}
```

## Interacting with the encryption module

The encryption module is set up to accept an HTTP request with the following parameters: 

- Headers:
    - `x-action`: `encrypt` or `decrypt`. 
- Body: a utf-8-encoded string.

The encryption module will return a JSON object with the following structure:
- Response code: 200
- Headers:
    - `Content-Type`: `application/json`
- Body (JSON)
    - `"requestBody"`: The string value passed in to the encryption module for encryption/decryption
    - `"actionType"`: The action specified in the `x-action` header (either `encrypt` or `decrypt`)
    - `"response"`: The encrypted or decrypted value of the `"requestBody"`

### Example

Request to the encryption module:

```
curl -H 'x-action: encrypt' --data-binary "Hello, world\!" localhost:3000/crypto
```

Response from the encryption module:

```
HTTP/1.1 200 OK
content-type: application/json

Response body:
{"requestBody":"Hello, world!","actionType":"encrypt","response":"UTMj2fAinK0V62jNJpERzLP1M9OuhhMD+yIchwhbDe6yKAdUrCD3f4k="}
```

# Testing the application

## Requirements
- Latest version of [Hurl](https://hurl.dev/) installed

## Instructions

- Run your Spin application (see [Running Spin Applications](https://developer.fermyon.com/spin/v2/running-apps)). 
- In your terminal, navigate to the directory containing the `test.hurl` file. 
- Run the command `hurl --test test.hurl`
- If your application fails the tests, try using the `--verbose` or `--very-verbose` flags in the `hurl` command to debug.

## What will be tested

The Hurl test will evaluate whether the encrypted string returned by the application listening on `http://localhost:3000` returns an encrypted message that can be decrypted by calling `http://localhost:3000/your-encryption-module-http-trigger-path` and compared with the expected string value `${originalEncryptedMessage} + ${yourNameValue}`. 

If the decrypted message matches the expected value, all required headers are included, and the HTTP statuses are 200, the application will pass the tests.

# Helpful hints

Some things to keep in mind:
- There is a bug in the TinyGo compiler that prevents Spin Golang applications from reading files. If you want to use Golang, you'll need to pass in the `plans.txt` file string some other way (i.e. via the body of a curl request or hard-coding).
- When you create a Spin application with multiple components, the way they will interact with each other is through HTTP calls (i.e. localhost:3000/your-component-http-trigger-route). In order to do this, you must define an `allowed_outbound_host` in your `spin.toml` file as `http://localhost:3000`.
- If you get stuck, reach out via our [Discord channel](https://www.fermyon.com/blog/fermyon-discord).
- Here are some helpful links from the Fermyon documentation:
    - [Writing applications](https://developer.fermyon.com/spin/v2/writing-apps)
    - [Structuring applications](https://developer.fermyon.com/spin/v2/spin-application-structure)
    - [Compiling applications](https://developer.fermyon.com/spin/v2/build)
    - [Running applications](https://developer.fermyon.com/spin/v2/running-apps)
    - [Publishing and distribution](https://developer.fermyon.com/spin/v2/distributing-apps)