#!/bin/bash

#############################################################
# Description : Check Kubernetes cluster for unhealthy pods
# Author      : Tejaswini Lingala
#############################################################

LOG_DIR="/home/ubuntu/logs"
LOG_FILE="$LOG_DIR/kubernetes_pod_report.log"
mkdir -p "$LOG_DIR"

echo "=========================================="
echo "     KUBERNETES POD HEALTH CHECK"
echo "=========================================="

echo "Date : $(date)"

echo
# Check kubectl installation
if ! command -v kubectl &>/dev/null
then
    echo "ERROR : kubectl is not installed."
    exit 1
fi

# Check cluster connectivity

kubectl cluster-info >/dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "ERROR : Unable to connect to Kubernetes Cluster."
    exit 1
fi
echo "Connected to Cluster Successfully"

echo
echo "Checking Pods..."
UNHEALTHY=0

kubectl get pods -A --no-headers | while read namespace pod ready status rest

do
    case "$status" in
        Running|Completed)
            ;;
       *)
           echo "-----------------------------------------"
            echo "Namespace : $namespace"
            echo "Pod       : $pod"
            echo "Status    : $status"
            echo "$(date) | $namespace | $pod | $status" >> "$LOG_FILE"
            UNHEALTHY=1
            ;;
    esac
done

echo
echo "=========================================="

if grep -q "$(date +%Y)" "$LOG_FILE"
then
    echo "Unhealthy Pods Found"
    exit 1
else
    echo "All Pods are Healthy"
    exit 0
fi
 
