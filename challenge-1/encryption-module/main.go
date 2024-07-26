package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	spinhttp "github.com/fermyon/spin/sdk/go/v2/http"
)

type Response struct {
	RequestBody string `json:"requestBody"`
	ActionType  string `json:"actionType"`
	Response    string `json:"response"`
}

// This is defined at build time using the -ldflags option for tinygo
var encryptionKey string

func encrypt(encryptionKey, message string) (string, error) {
	block, err := aes.NewCipher([]byte(encryptionKey))
	if err != nil {
		return "", err
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	nonce := make([]byte, gcm.NonceSize())
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		return "", err
	}

	ciphertext := gcm.Seal(nonce, nonce, []byte(message), nil)
	return base64.StdEncoding.EncodeToString(ciphertext), nil
}

func decrypt(encryptionKey, message string) (string, error) {
	base64Error := fmt.Errorf("{\"payloadReceived\": \"%s\"}\nThe request payload is not base64 encoded. Did you mistakenly send a plaintext string?", message)

	ciphertext, err := base64.StdEncoding.DecodeString(message)
	if err != nil {
		return "", base64Error
	}

	block, err := aes.NewCipher([]byte(encryptionKey))
	if err != nil {
		return "", err
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	nonceSize := gcm.NonceSize()

	if len(ciphertext) < nonceSize {
		return "", base64Error
	}

	nonce, ciphertext := ciphertext[:nonceSize], ciphertext[nonceSize:]
	plaintext, err := gcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return "", err
	}

	return string(plaintext), nil
}

func writeResponse(w http.ResponseWriter, r *Response, message string) {
	r.Response = message
	jsonResponse, err := json.Marshal(r)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Write(jsonResponse)
	return
}

func init() {
	spinhttp.Handle(func(w http.ResponseWriter, r *http.Request) {
		action := r.Header.Get("x-action")
		if action != "encrypt" && action != "decrypt" {
			http.Error(w, "Please include the 'x-action' header with 'encrypt' or 'decrypt' as the value:\ncurl -H 'x-action: encrypt'\ncurl -H 'x-action: decrypt'\n", http.StatusBadRequest)
			return
		}

		messageBytes, err := io.ReadAll(r.Body)
		if err != nil {
			http.Error(w, "Error reading request body: "+err.Error(), http.StatusInternalServerError)
			return
		}
		r.Body.Close()

		if len(messageBytes) == 0 {
			fmt.Println("No message bytes")
			http.Error(w, "Please include a body in your request", http.StatusBadRequest)
			return
		}

		var response Response
		response.ActionType = action
		response.RequestBody = string(messageBytes)

		w.Header().Set("Content-Type", "application/json")

		if action == "encrypt" {
			encryptedMessage, err := encrypt(encryptionKey, string(messageBytes))
			if err != nil {
				http.Error(w, "Error encrypting message: "+err.Error(), http.StatusInternalServerError)
				return
			}

			writeResponse(w, &response, encryptedMessage)

		} else if action == "decrypt" {
			decryptedMessage, err := decrypt(encryptionKey, string(messageBytes))
			if err != nil {
				http.Error(w, "Error decrypting message: "+err.Error(), http.StatusInternalServerError)
				return
			}

			writeResponse(w, &response, decryptedMessage)
		}
	})
}

func main() {}
