FROM alpine:latest

# Install OpenSSL and Bash
RUN apk add --no-cache openssl bash

# Set working directory
WORKDIR /app

# Default to Bash shell
CMD ["/bin/bash"]
