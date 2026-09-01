#!/bin/bash

# ==========================================
# JSP Servlet Project Runner
# ==========================================

PROJECT_DIR="/home/deepanshu-adhikari/IdeaProjects/jsp-servlet-demo"
TOMCAT_HOME="/opt/tomcat"
APP_NAME="jsp-servlet-demo"
APP_URL="http://127.0.0.1:8080/jsp-servlet-demo/"

# ==========================================
# Go to project directory
# ==========================================

cd "$PROJECT_DIR" || exit 1

echo "================================"
echo "Building project..."
echo "================================"

# ==========================================
# Build WAR
# ==========================================

mvn clean package

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

echo "Build successful."

# ==========================================
# Stop existing Tomcat
# ==========================================

echo "Stopping Tomcat..."

"$TOMCAT_HOME/bin/shutdown.sh" >/dev/null 2>&1 || true

sleep 3

# ==========================================
# Make sure old Tomcat process is stopped
# ==========================================

if pgrep -f "$TOMCAT_HOME" >/dev/null 2>&1; then
    echo "Tomcat is still running. Stopping it..."
    pkill -f "$TOMCAT_HOME" || true
    sleep 2
fi

# ==========================================
# Remove old application
# ==========================================

echo "Removing old application..."

rm -rf "$TOMCAT_HOME/webapps/$APP_NAME"
rm -f "$TOMCAT_HOME/webapps/$APP_NAME.war"

# ==========================================
# Clean old JSP compiled files
# ==========================================

echo "Cleaning Tomcat work directory..."

rm -rf "$TOMCAT_HOME/work/Catalina/localhost/$APP_NAME"

# ==========================================
# Deploy new WAR
# ==========================================

echo "Deploying new WAR..."

cp "$PROJECT_DIR/target/$APP_NAME.war" \
   "$TOMCAT_HOME/webapps/$APP_NAME.war"

echo "WAR deployed."

# ==========================================
# Start Tomcat DETACHED from IntelliJ
# ==========================================

echo "Starting Tomcat..."

cd "$TOMCAT_HOME"

# Start Tomcat in a completely detached session
setsid "$TOMCAT_HOME/bin/catalina.sh" start \
    </dev/null \
    >/dev/null 2>&1 &

# Detach the background process
disown

echo "Tomcat start command executed."

# ==========================================
# Wait for Tomcat
# ==========================================

echo "Checking Tomcat..."

for i in {1..15}; do

    if curl -s --head --max-time 2 \
        http://127.0.0.1:8080 >/dev/null 2>&1; then

        echo "Tomcat is running."
        break
    fi

    sleep 1

done

# ==========================================
# Verify Tomcat
# ==========================================

if ! curl -s --head --max-time 5 \
    http://127.0.0.1:8080 >/dev/null 2>&1; then

    echo "================================"
    echo "ERROR: Tomcat failed to start."
    echo "================================"
    echo ""
    echo "Check logs:"
    echo "tail -50 $TOMCAT_HOME/logs/catalina.out"

    exit 1
fi

# ==========================================
# Check application
# ==========================================

echo "Checking application..."

if curl -s --head --max-time 5 \
    "$APP_URL" >/dev/null 2>&1; then

    echo "Application is running."

else

    echo "================================"
    echo "ERROR: Application is not responding."
    echo "================================"
    echo ""
    echo "Check logs:"
    echo "tail -50 $TOMCAT_HOME/logs/catalina.out"

    exit 1
fi

# ==========================================
# Open browser
# ==========================================

echo "Opening application..."

sleep 1

xdg-open "$APP_URL" >/dev/null 2>&1 &

echo "================================"
echo "Application is running!"
echo "================================"
echo ""
echo "URL:"
echo "$APP_URL"
echo ""

# ==========================================
# IMPORTANT:
# Tomcat is now detached from this script.
# IntelliJ can safely finish this process.
# ==========================================