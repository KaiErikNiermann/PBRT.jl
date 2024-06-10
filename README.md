# PBRT.jl

## Installation

If you don't have julia installed, you can download it [here](https://julialang.org/downloads/).

1. Clone the repository

    ```bash
    git clone https://github.com/KaiErikNiermann/julia-bsc-thesis.git
    ```

2. Build the Dockerfile 

    ```bash 
    docker build -t pbrt-runner .
    ```

3. Either mount to the Docker container or attach to it

    **option 1** - Mounting to the container
    ```bash
    docker run -v $(pwd):/mnt -it pbrt-runner
    ```

    **option 2** - Attaching to the container
    
    Install the [`Dev Containers`](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension for VScode, and then just attach to the running container.

## Directories explained 

| Directory   | Description                                                                                 |
|-------------|---------------------------------------------------------------------------------------------|
| `build`     | Contains compiled binaries and build artifacts for the cpp PBRT implementation              |
| `cpp_src`   | Contains C++ source code files for the project, uses CMake for compilation.                                            |
| `docs`      | Project documentation using `Documenter.jl`                                                 |
| `logs`      | Stores any log files for the PBRT implementation (e.g. memory profiling)                 |
| `notebooks` | Contains Jupyter notebooks for benchmarking, debugging, and other analysis      |
| `paper`     | Cotnains the main research paper and research proposal|
| `py_src`    | Contains Python source code files for the project ; project uses `poetry`                                         |
| `scenes`    | Stores scene files in the wavefront object format (`.obj`)  |
| `src`       | Contains the main source code for the project, in Julia. |
| `test`      | Constains tests for the main Julia implementation                 |
