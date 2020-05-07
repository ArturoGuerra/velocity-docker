#!/bin/bash

: ${MEMORY:=512m}
VELOCITY_HOME=/server
VELOCITY_JAR=$VELOCITY_HOME/velocity.jar

if [[ ! -e $VELOCITY_JAR ]]; then
    echo "Downloading ${VELOCITY_JAR_URL}"
    if ! curl -o $VELOCITY_JAR -fsSL $VELOCITY_JAR_URL; then
        echo "ERROR: failed to download" >&2
        exit 2
    fi
fi

if [ -d /plugins ]; then
    echo "Copying Velocity plugins over..."
    cp -r /plugins $VELOCITY_HOME
fi

# If supplied with a URL for a plugin download it.
if [[ "$PLUGINS" ]]; then
for i in ${PLUGINS//,/ }
do
  EFFECTIVE_PLUGIN_URL=$(curl -Ls -o /dev/null -w %{url_effective} $i)
  case "X$EFFECTIVE_PLUGIN_URL" in
    X[Hh][Tt][Tt][Pp]*.jar)
      echo "Downloading plugin via HTTP"
      echo "  from $EFFECTIVE_PLUGIN_URL ..."
      if ! curl -sSL -o /tmp/${EFFECTIVE_PLUGIN_URL##*/} $EFFECTIVE_PLUGIN_URL; then
        echo "ERROR: failed to download from $EFFECTIVE_PLUGIN_URL to /tmp/${EFFECTIVE_PLUGIN_URL##*/}"
        exit 2
      fi

      mkdir -p $VELOCITY_HOME/plugins
      mv /tmp/${EFFECTIVE_PLUGIN_URL##*/} "$VELOCITY_HOME/plugins/${EFFECTIVE_PLUGIN_URL##*/}"
      rm -f /tmp/${EFFECTIVE_PLUGIN_URL##*/}
      ;;
    *)
      echo "Invalid URL given for plugin list: Must be HTTP or HTTPS and a JAR file"
      ;;
  esac
done
fi

echo "Copying BungeeCord configs over..."
cp -u /config/velocity.toml "$VELOCITY_HOME/velocity.toml"


echo "Setting initial memory to ${INIT_MEMORY:-${MEMORY}} and max to ${MAX_MEMORY:-${MEMORY}}"
JVM_OPTS="-Xms${INIT_MEMORY:-${MEMORY}} -Xmx${MAX_MEMORY:-${MEMORY}} ${JVM_OPTS}"

exec java $JVM_OPTS -jar $VELOCITY_JAR "$@"
