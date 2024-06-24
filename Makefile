SRC = "src/"

instantiate-jl: 
	julia --project=. -e "using Pkg; Pkg.instantiate()"

render-jl:
	julia --project=. src/PBRT.jl

render-py: 
	make instantiate-jl
	cd py_src 
	poetry run python3.12 main.py

render-cpp: 
	cd cpp_src
	cmake --build . && ./PBRT

render-with-allocs: 
	julia --project=. --track-allocation=user src/PBRT.jl

mv-logs: 
	mv $(SRC)*.mem logs/
	mv $(SRC)*profile.pb.gz logs/