#!/bin/bash
ps -A | grep hotkey | grep -v grep | awk '{print $1}'
ps -A | grep hotkey.sh | grep -v grep | awk '{print $1}'
