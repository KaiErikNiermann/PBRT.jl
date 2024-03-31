# juliaThesis

[![Build Status](https://github.com/KaiErikNiermann/julia-bsc-thesis/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/KaiErikNiermann/julia-bsc-thesis/actions/workflows/documenation.yml?query=branch%3Amain)

## Usage 

### Installation

If you don't have julia installed, you can download it [here](https://julialang.org/downloads/).

Clone the repository

```bash
$ git clone https://github.com/KaiErikNiermann/julia-bsc-thesis.git
```

### Testing 

If you want to run the library tests 

1. Open the julia repl by typing `julia`
2. Go to **package mode** by typing `]`
3. Activate the environment by running the `activate .` command 
4. In the package mode, run the command `test`

#### Summary 

```bash
$ julia                         # Enter the julia REPL
julia> ]                        # Go to the package mode
(v1.8) pkg> activate .          # Activate the environemnt
(YourPackageName) pkg> test     # Run the tests
```