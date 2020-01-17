#!/bin/bash
script_dir=$(dirname $0)
unbuffer pocketsphinx_continuous -inmic yes -keyphrase "okay listen to me" -kws_threshold "\1e-45" -logfn /dev/null > $script_dir/pipe 
