# OpenSSL_Seguridad

# How to run docker?
```
docker-compose up --build
docker ps
docker exec -it <container_id> bash
```

## Fase 2: Cifrado de un Mensaje con AES y Protección con RSA

La realización de esta fase se centra en:

1. Generar una clave AES
2. Cifrar un mensaje con AES
3. Cifrar la clave AES con la clave pública RSA del destinatario

Para generar una clave AES se debe de ejecutar el siguiente comando:

```
openssl rand -base64 32 > aes_key.txt
```

El cual genera una clave aleatoria en formato Base64.

output

```
P7IfiEyKrUH9yECtHV6oP8T ...
```

Como seundo paso se tiene que cifrar el mensaje con la clave AES, el cual se hace con el siguiente comando.

```
openssl enc -aes-256-cbc -salt -in mensaje.txt -out mensaje_cifrado.bin -pas
s file:aes_key.txt
```

El cual cifra un archivo (mensaje.txt) usando el algoritmo AES-256 en modo CBC y guarda el resultado en mensaje_cifrado.bin.

output

```
Salted__\��7{ݠ�Ws ...
```


Para el ultimo paso se tiene que cifrar la clave AES con la clave pública RSA del destinatario, el cual se realiza con el siguiente comando

```
openssl pkeyutl -encrypt -inkey mi_clave_publica_Sara.pem -pubin -in aes_key.txt -out aes_key_cifrada.bin -pkeyopt rsa_padding_mode:oaep
```
Cifra la clave AES almacenada en aes_key.txt utilizando una clave pública RSA del destina y el modo de padding OAEP.

output

```
��OĚ%�kT.]s�����b ...
```
