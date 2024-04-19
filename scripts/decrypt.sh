#!/bin/bash

# decrypt the file into a var
decrypted_content=$(sops --decrypt "secrets/secrets.enc.yaml")

# read each line of decrypted content -
# the text before the ":" is the filename and the text after is the secret
echo "${decrypted_content}" | while IFS=: read -r filename value; do
    # trim any leading space from value
    content=$(echo "$value" | xargs)
    # write the content to the corresponding file in the secrets folder
    echo "${content}" > "secrets/${filename}"
done
