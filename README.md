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

<b>Conflictos encontrados </b>

El comando openssl rsautl está deprecado:

```
openssl rsautl -encrypt -inkey clave_publica_destinatario.pem -pubin -in aes_
key.txt -out aes_key_cifrada.bin
```

 Sin embargo, ya no se recomienda su uso para cifrado con RSA, ya que no ofrece soporte para opciones modernas como OAEP de forma flexible y segura. En su lugar, se utiliza openssl pkeyutl, que es la alternativa actual y admite configuraciones avanzadas, como el modo de padding OAEP, proporcionando mayor seguridad contra ataques criptográficos.

<b>Lecciones aprendidas </b>

Al trabajar con AES, aprendimos la importancia de usar claves seguras y cómo protegerlas mediante cifrado asimétrico con RSA. Vimos cómo generar una clave AES con OpenSSL, cifrar y descifrar archivos, y asegurar la clave AES utilizando una clave pública RSA con OAEP para mayor seguridad. También entendimos por qué comandos como rsautl están deprecados y cómo pkeyutl ofrece mejores prácticas criptográficas. Estos conceptos son esenciales para proteger datos en aplicaciones del mundo real.
