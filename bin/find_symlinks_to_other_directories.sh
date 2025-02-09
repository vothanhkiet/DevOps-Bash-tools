#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2025-01-08 14:34:11 +0700 (Wed, 08 Jan 2025)
#
#  https///github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Finds symlinks to other directories under the given path
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="<base_path>"

help_usage "$@"

min_args 1 "$@"

if [ -L "$1" ]; then
    ls -l "$1"
else
    find "$1" -type l -exec ls -l {} \;
fi |
grep -E -- '[[:space:]]->[[:space:]]+.*/' |
awk '{$1=$2=$3=$4=$5=$6=$7=$8=""; print}'
