valgrind \
  --tool=massif \
  --stacks=yes \
  --detailed-freq=5 \
  --max-snapshots=500 \
  --threshold=0.01 \
  --time-unit=ms \
  --depth=50 \
  --massif-out-file=massif.out \
  ./build/interop
