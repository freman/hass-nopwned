#!/usr/bin/with-contenv bashio

cat << EOF
This addon is no longer required"

See: https://community.home-assistant.io/t/opt-out-of-pwned-secrets-warnings/286394/241

> To anyone interested, the password check can now be disabled with the command below in the CLI using the latest versions of either the core-ssh add-on or the community ssh add-on:
>
> Terminal & SSH (core) version 9.1.0
> SSH & Web Terminal (community) version 8.0.4

ha resolution check options --enabled=false addon_pwned
EOF