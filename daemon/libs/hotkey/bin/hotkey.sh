#!/bin/bash

script_dir=$(dirname $0)
unbuffer $script_dir/hotkey > $script_dir/../pipe
