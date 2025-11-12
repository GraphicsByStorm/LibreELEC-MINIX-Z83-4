#!/bin/sh
# Idempotent: In other words, harmless if Wi-Fi is already active.
connmanctl enable wifi >/dev/null 2>&1 || true
