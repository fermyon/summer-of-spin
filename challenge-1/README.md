# Overview 

Welcome to the first challenge of Summer of Spin! In this challenge, you will demonstrate the following skills:

- HTTP calls
- Building Spin apps with pre-build components
- Reading from a file (optional)

# Building the application

### Requirements

- Most recent version of [Spin](https://developer.fermyon.com/spin/v2/install)
- See language-specific requirements
    - [Rust](https://developer.fermyon.com/spin/v2/rust-components)
    - [Golang](https://developer.fermyon.com/spin/v2/go-components)
    - [Python](https://developer.fermyon.com/spin/v2/python-components)
    - [JavaScript](https://developer.fermyon.com/spin/v2/javascript-components)
    - [Other Languages](https://developer.fermyon.com/spin/v2/other-languages)

### Instructions

You will be building a Spin app (using `encryption-module/main.wasm` as a component) that will do the following:

- Read `message.txt` and decrypt the string using the encryption module.
- Append your name to the end of the decrypted string.
- Re-encrypt the newly-created string using the encryption module.
- Return an HTTP response with the following values:
    - Response code: 200
    - Headers:
        - `content-type`: `application/json`
        - `x-name`: The name value you appended to the decrypted string
        - `x-encryption-module-path`: The HTTP trigger path you defined for the encryption module in the `spin.toml` file
    - Body: A utf-8-encoded JSON object with `"encryptedMessage"` as the key, and the re-encrypted string as the value.

### Interacting with the encryption module

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

# Testing the application

### Requirements
- Latest version of [Hurl](https://hurl.dev/) installed

### Instructions

- Run your Spin application (see [Running Spin Applications](https://developer.fermyon.com/spin/v2/running-apps)). 
- In your terminal, navigate to the directory containing the `test.hurl` file. 
- Run the command `hurl --test test.hurl`
- If your application fails the tests, try using the `--verbose` or `--very-verbose` flags in the `hurl` command to debug.

### What will be tested

The Hurl test will evaluate whether the encrypted string returned by the application listening on `http://localhost:3000` returns an encrypted message that can be decrypted by calling `http://localhost:3000/your-encryption-module-http-trigger-path` and compared with the expected string value `${originalEncryptedMessage} + ${yourNameValue}`. 

If the decrypted message matches the expected value, all required headers are included, and the HTTP statuses are 200, the application will pass the tests.

# Helpful hints

Some things to keep in mind:
- There is a bug in the TinyGo compiler that prevents Spin Golang applications from reading files. If you want to use Golang, you'll need to pass in the `message.txt` file string some other way (i.e. via the body of a curl request or hard-coding).
- When you create a Spin application with multiple components, the way they will interact with each other is through HTTP calls (i.e. localhost:3000/your-component-http-trigger-route). In order to do this, you must define an `allowed_outbound_host` in your `spin.toml` file as `http://localhost:3000`.
- If you get stuck, reach out via our [Discord channel](https://www.fermyon.com/blog/fermyon-discord).
- Here are some helpful links from the Fermyon documentation:
    - [Writing applications](https://developer.fermyon.com/spin/v2/writing-apps)
    - [Structuring applications](https://developer.fermyon.com/spin/v2/spin-application-structure)
    - [Compiling applications](https://developer.fermyon.com/spin/v2/build)
    - [Running applications](https://developer.fermyon.com/spin/v2/running-apps)
    - [Publishing and distribution](https://developer.fermyon.com/spin/v2/distributing-apps)
        - #TODO: Find out how the actual submission process will work