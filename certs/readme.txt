Step 2: Generate Self-Signed Certificates
Generate self-signed certificates using OpenSSL:

mkdir -p certs
openssl req -newkey rsa:2048 -nodes -keyout certs/key.pem -x509 -days 365 -out certs/cert.pem
This will create two files in the certs directory: key.pem (the private key) and cert.pem (the certificate).
