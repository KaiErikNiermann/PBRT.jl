#!/bin/sh
code --list-extensions | xargs -L 1 echo code --install-extension | sed '1i#!/bin/sh' > install-extensions.sh && chmod +x install-extensions.sh