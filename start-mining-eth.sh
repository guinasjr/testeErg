#!/bin/bash
{

CARTEIRA="0x00d44063efebb8e07b4df3dd7bd9678544b693db"
WORKERID="XXX"
POOL="us-eth.2miners.com:2020"


export __GL_ExperimentalPerfStrategy=1

sudo nvidia-smi -pm 1

sudo /usr/bin/nvidia-smi -i 0 -pl 150

sudo nvidia-settings -a [gpu:0]/GPUPowerMizerMode=1
sudo nvidia-settings -a "[gpu:0]/GPUMemoryTransferRateOffsetAllPerformanceLevels=2000"

sudo nvidia-settings -a "[gpu:0]/GPUGraphicsClockOffsetAllPerformanceLevels=-600"

sudo nvidia-settings -a [gpu:0]/GPUFanControlState=1
sudo nvidia-settings -a [fan:1]/GPUTargetFanSpeed=60
sudo nvidia-settings -a [fan:0]/GPUTargetFanSpeed=90

} > /var/log/mining-eth.log


nohup sudo /opt/nsfminer/build/nsfminer/nsfminer -U -P stratum1+tcp://{CARTEIRA}.${WORKERID}@${POOL} >> /var/log/mining-eth.log 2>&1 & 
sleep 20

{
sudo /usr/bin/nvidia-smi -i 0 -pl 135
sudo nvidia-settings -a "[gpu:0]/GPUMemoryTransferRateOffsetAllPerformanceLevels=2600"
sudo nvidia-settings -a "[gpu:0]/GPUGraphicsClockOffsetAllPerformanceLevels=-300"
sudo nvidia-smi -pm 0
} >> /var/log/mining-eth.log
