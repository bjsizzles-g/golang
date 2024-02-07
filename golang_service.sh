.
#!/bin/bash

APP_BINARY="/opt/app/app"
LOG_FILE="/var/log/app.log"
PID_FILE="/var/run/app.pid"

start_app() {
    if [ -f "$PID_FILE" ]; then
        echo "App is already running."
    else
        echo "Starting app..."
        nohup "$APP_BINARY" >> "$LOG_FILE" 2>&1 &
        echo $! > "$PID_FILE"
        echo "App started."
    fi
}

stop_app() {
    if [ -f "$PID_FILE" ]; then
        echo "Stopping app..."
        PID=$(cat "$PID_FILE")
        kill "$PID"
        rm "$PID_FILE"
        echo "App stopped."
    else
        echo "App is not running."
    fi
}

case "$1" in
    start)
        start_app
        ;;
    stop)
        stop_app
        ;;
    restart)
        stop_app
        start_app
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
