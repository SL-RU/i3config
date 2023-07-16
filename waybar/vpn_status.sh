#!/bin/bash

if [[ $(pgrep openvpn) ]]; then
    echo "VPN"
fi