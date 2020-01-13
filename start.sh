echo "Starting Velocity server https://www.velocitypowered.com"
VELOCITY="./velocity.jar"

if ! test -f "$VELOCITY"; then
    if [ "${CUSTOM_URL}" != "" ]; then
        echo "Downloading custom version: ${CUSTOM_URL}"
        curl -sSL -o ./velocity.jar "${CUSTOM_UR}"
    else
        echo "Downloading latest stable version"
        curl -sSL -o ./velocity.jar "https://ci.velocitypowered.com/job/velocity/187/artifact/proxy/build/libs/velocity-proxy-1.0.4-all.jar"
    fi

    if [ "${PORT}" != "" ]; then
        echo "Setting port to: $PORT"
        echo "bind = \"0.0.0.0:$PORT\"" > velocity.toml
    fi

    if [ "${VCONFIG}" != "" ]; then
        echo "Downloading custom velocity config..."
        curl -sSL -o ./velocity.toml "${VCONFIG}"
    fi
fi


java -jar "$VELOCITY"
