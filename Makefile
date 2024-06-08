SRC = "src/"

render:
	julia --project=. src/PBRT.jl

render-with-allocs: 
	julia --project=. --track-allocation=user src/PBRT.jl

mv-logs: 
	mv $(SRC)*.mem logs/
	mv $(SRC)*profile.pb.gz logs/