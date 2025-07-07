poetry run python3 \
-X juliacall-check-bounds=yes \
-X juliacall-inline=no \
-X juliacall-warn-overwrite=yes \
-X juliacall-depwarn=error \
-X juliacall-startup-file=no \
-X juliacall-handle-signals=yes \
-X juliacall-threads=1 src/python/main.py 
