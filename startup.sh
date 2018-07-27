#!/bin/bash

cd /home/linaro/AiVA-96-alexa-avs-sample-app-setup/samples/companionService
qterminal -e "npm start" &
cd /home/linaro/AiVA-96-alexa-avs-sample-app-setup/samples/javaclient
qterminal -e "mvn exec:exec" &
sleep 30
cd /home/linaro/AiVA-96-alexa-avs-sample-app-setup/samples/wakeWordAgent/src
qterminal -e "sudo ./wakeWordAgent gpio" &
cd /home/linaro/AiVA-96-alexa-avs-sample-app-setup
qterminal -e "./run_sphinx_no_log.sh" &