# Certificates

## Creating a Request for a CA

### Creating Domain Key
```bash
openssl genpkey -algorithm RSA -out domain.key -outform PEM -pkeyopt rsa_keygen_bits:2048
```

Creating a Certificate Signing Request (csr)
```bash
openssl req -new -key domain.key -out domain.csr
```

## Own CA (small local Certificate Authority)
### Creating CA Key
```bash
openssl genpkey -algorithm RSA -aes128 -out private-ca.key -outform PEM -pkeyopt rsa_keygen_bits:2048
```

Instead of -aes128, you can use the older -des3 option.

### Creating CA crt
```bash
openssl req -x509 -new -nodes -sha256 -days 3650 -key private-ca.key -out self-signed-ca-cert.crt
```

The -nodes argument prevents setting a passphrase for the private key (key pair) in a test/unsafe environment; otherwise, you will have to enter the passphrase every time the server starts/restarts.

### Creating a Certificate Based on the csr Request

Create a text file domain.ext with the following content, changing the domain names as necessary:

```
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:TRUE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = domain.local
DNS.2 = www.domain.local
# Optionally add IP if you're not using DNS names:
IP.1 = 192.168.0.10
```

Create the certificate domain.crt, signed by the local CA:
```bash
openssl x509 -req -in domain.csr -CA self-signed-ca-cert.crt -CAkey private-ca.key -CAcreateserial -out domain.crt -days 365 -sha256 -extfile domain.ext
```

## Working with pfx

### Creating
```bash
openssl pkcs12 -export -out domain.pfx -inkey domain.key -in domain.crt
```

If there is a root CA and intermediate certificates, you can also include them using multiple -in parameters:
```bash
openssl pkcs12 -export -out domain.pfx -inkey domain.key -in domain.crt -in intermediate.crt -in rootca.crt
```

### Reading
```bash
openssl pkcs12 -info -in domain.pfx
```

---

## Description of .csr File Fields

The .csr (Certificate Signing Request) file is used to request a digital certificate from a Certificate Authority (CA). It contains the information needed to create the certificate, including the public key. Key fields in the .csr file include:
1. **Common Name (CN)**: The domain name for which the certificate is requested (e.g., www.example.com).
2. **Organization (O)**: The full legal name of the organization requesting the certificate.
3. **Organizational Unit (OU)**: A division within the organization, such as the IT department.
4. **City/Locality (L)**: The city or locality where the organization is located.
5. **State/Province (ST)**: The state or province where the organization is located.
6. **Country (C)**: The two-letter country code where the organization is located (e.g., US for the United States).
7. **Email Address**: The email address for contacting the organization.
8. **Public Key**: The public key to be included in the certificate and used for encrypting data.
9. **Signature Algorithm**: The algorithm used for creating the CSR signature (e.g., SHA256 with RSA).
10. **Subject Alternative Name (SAN)**: Additional domain names or IP addresses to be included in the certificate.

These fields provide identification for the requesting party and the necessary information for creating the certificate.

### Example of .csr File Field Fill
1. **Common Name (CN)**: example.com
2. **Organization (O)**: Example Inc.
3. **Organizational Unit (OU)**: IT Department
4. **City/Locality (L)**: Palo Alto
5. **State/Province (ST)**: CA
6. **Country (C)**: US
7. **Email Address**: contact@example.com
8. **Public Key**: The public key included in the CSR (presented in base64 format in the main data block).
9. **Signature Algorithm**: SHA256 with RSA
10. **Subject Alternative Name (SAN)**: May include additional domain names or IP addresses, such as www.example.com, mail.example.com