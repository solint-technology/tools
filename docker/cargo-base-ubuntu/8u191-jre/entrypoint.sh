#!/bin/bash

LOGFILE="$CARGOPATH/data/log/server.log"
SERVERSH="$CARGOPATH/bin/server.sh"

# This will create the server.log file if it doesn't exist and
# empty it if it exists.
> "$LOGFILE"

# This tail process will follow the logs to output them on standard
# output but will not interrupt signal because of the "exec" command
# used to start the cargo server.
tail -f "$LOGFILE" &

exec ${SERVERSH} run