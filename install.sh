#!/bin/bash

#/
# Copyright 2015-2016 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/
#
set -e
set -x

if [ $# -eq 0 ]
then
    echo "Usage: ./install.sh APIHOST AUTH WSK_CLI"
fi

APIHOST="$1"
AUTH="$2"
WSK_CLI="$3"

PACKAGE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo Installing IMAP Package \

$WSK_CLI --apihost $APIHOST package update --auth $AUTH --shared yes imap \
    -a description "IMAP Package" \
    -a parameters '[{"name":"host","required":true,"bindTime":true,"description":"IMAP server host"},{"name":"username","required":true,"bindTime":true,"description":"IMAP username"},{"name":"password","required":true,"bindTime":true,"type":"password","description":"IMAP username"}]'

$WSK_CLI --apihost $APIHOST action update --auth $AUTH --shared yes imap/imapFeed $PACKAGE_HOME/feeds/feed.js \
    -a feed true \
	-a description "A feed action that allows users to register for IMAP incoming emails notifications" \
	-a parameters '[{"name":"host","required":true,"bindTime":true,"description":"IMAP server host"},{"name":"username","required":true,"bindTime":true,"type":"password","description":"IMAP username"},{"name":"password","required":true,"bindTime":treu,"description":"IMAP username"},{"name":"mailbox","required":false,"bindTime":false,"description":"Mailbox name"}]' \
    -a sampleInput '{"host":"imap.google.com","username":"xxxxx@gmail.com","password":"XXXXXX","mailbox":"INBOX"}' \