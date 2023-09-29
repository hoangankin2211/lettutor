#!/bin/bash
set -e

#flutter pub get
fvm flutter pub global run intl_utils:generate

echo "Gen Localize Done !!!"