#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

/usr/bin/php -S localhost:8000 -t public
