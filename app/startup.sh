#!/bin/bash
echo "RUNNING THE APP"
bash /odtp/odtp-app/app.sh 2>&1 | tee /odtp/odtp-workdir/log.txt

echo "--- ODTP COMPONENT ENDING ---" >> /odtp/odtp-workdir/log.txt