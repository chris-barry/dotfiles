#!/bin/bash
# csd.sh - do dumb cisco anyconnect stuff
# Author: Kevin Cernekee <cernekee@gmail.com>
# License: https://opensource.org/licenses/BSD-3-Clause

# TODO: Make this use wget since Debian ships with that, one less dependency
function run_curl
{
curl \
--insecure \
--user-agent "AnyConnect Windows $ver" \
--header "X-Transcend-Version: 1" \
--header "X-Aggregate-Auth: 1" \
--header "X-AnyConnect-Platform: $plat" \
--cookie "sdesktop=$token" \
"$@"
}

set -e

host=https://$CSD_HOSTNAME
plat=win
ver=3.2.1 # determined from: https://$CSD_HOSTNAME/CACHE/sdesktop/data.xml
token=$CSD_TOKEN

run_curl --data-ascii @- "$host/+CSCOE+/sdesktop/scan.xml?reusebrowser=1" <<-END
endpoint.policy.location="corplaptop";
END

exit 0
