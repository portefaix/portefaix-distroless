#!/bin/bash

[ -n "$1" ] && exec "$@"

cat <<EOF

 ______                       ___      _
(_____ \           _         / __)    (_)              kubectl: ${KUBECTL_VERSION}
 _____) )__   ____| |_  ____| |__ ____ _ _   _         helm: ${HELM_VERSION}
|  ____/ _ \ / ___)  _)/ _  )  __) _  | ( \ / )        kustomize: ${KUSTOMIZE_VERSION}
| |   | |_| | |   | |_( (/ /| | ( ( | | |) X (
|_|    \___/|_|    \___)____)_|  \_||_|_(_/ \_)  

Home: https://github.com/portefaix/portefaix-distroless

EOF
exec /bin/sh