# OpenSSL_Seguridad

# How to run docker?
```
docker-compose up --build
docker ps
docker exec -it <container_id> bash
```

## Fase 1: Generación de Claves (RSA - Asimétrico)

### Pasos Realizados y Evidencia

#### Generación de la Clave Privada
```
openssl genpkey -algorithm RSA -out mi_clave_privada.pem -pkeyopt rsa_key gen_bits:2048
```

Este comando genera una clave privada RSA de 2048 bits y la guarda en un archivo llamado mi_clave_privada.pem. Para esto, se usa OpenSSL con la opción genpkey, especificando el algoritmo RSA y el tamaño de la clave con -pkeyopt rsa_keygen_bits:2048.

```
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDLISowRH0a9L1M
lsc/UJzxV1m1YUGvKSQxqoBUuWXSbL+ZOm8y14VIjSHCgEs/U60udVARteo3x0kH
0VJzRdItewKOYI6wl3KQnZHITue8qYHLmGxOodc+ABUvsL/pCi1iY+/0PgyB1XWS
spGcoqM8wp0UGAf1U2mzgX3LwXZFy8qQr8KMV7UkJ/e3dlbLkfOEGPQdQ6AA0Npx
n6mThT2ESSESP259W6/e2vYGYA5TbJGUZDaHhj6zwYWdNyd09vYkms4Anxi9Qjab
iExpbBQwE/MYuTOpc7y39syhwLttrHnrzreyFKOhW9CVghbfmBPTxufAKygktQ5D
JqzIzdlfAgMBAAECgg...
-----END PRIVATE KEY-----
```

#### Extracción de la Clave Pública
```
openssl rsa -in mi_clave_privada.pem -pubout -out mi_clave_publica.pem
```

Este comando extrae la clave pública a partir de la clave privada con la opción rsa, utilizando -pubout para guardarla en mi_clave_publica.pem.

```
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyyEqMER9GvS9TJbHP1Cc
8VdZtWFBrykkMaqAVLll0my/mTpvMteFSI0hwoBLP1OtLnVQEbXqN8dJB9FSc0XS
LXsCjmCOsJdykJ2RyE7nvKmBy5hsTqHXPgAVL7C/6QotYmPv9D4MgdV1krKRnKKj
PMKdFBgH9VNps4F9y8F2RcvKkK/CjFe1JCf3t3ZWy5HzhBj0HUOgANDacZ+pk4U9
hEkhEj9ufVuv3tr2BmAOU2yRlGQ2h4Y+s8GFnTcndPb2JJrOAJ8YvUI2m4hMaWwU
MBPzGLkzqXO8t/bMocC7bax56863shSjoVvQlYIW35gT08bnwCsoJLUOQyasyM3Z
XwIDAQAB
-----END PUBLIC KEY-----
```

### Lecciones Aprendidas
Se logro aprender cómo se generan y utilizan las claves privadas y públicas en criptografía asimétrica con OpenSSL. Se logro entender porque la clave privada debe mantenerse segura, ya que es la única que puede descifrar los mensajes cifrados con la clave pública. La clave pública puede compartirse libremente para que otros cifren información de manera segura. Con OpenSSL, se pueden generar estas claves de manera sencilla y comprender su importancia en la seguridad de las comunicaciones.

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
