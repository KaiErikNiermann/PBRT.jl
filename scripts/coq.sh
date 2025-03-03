install_packages() {
    apt update && apt upgrade -y
    apt install -y opam m4 curl libgmp-dev pkg-config 
}

initialize_opam() {
    opam init --disable-sandboxing   
    opam switch create coq-switch "$OCAML_VERSION"
    eval $(opam env)
}

install_coq_vscoq() {
    opam update
    opam upgrade -y
    opam pin add coq "$COQ_VERSION"
    opam install vscoq-language-server -y
}

check_vscoqtop() {
    vscoqtop_path=$(which vscoqtop)
    if [ -z "$vscoqtop_path" ]; then
        echo "vscoqtop not found in your shell. Installation failed."
        exit 1
    else
        echo "vscoqtop installed at $vscoqtop_path"
    fi
}

usage() {
    echo "Usage: $0 [-ov <OCAML_VERSION>] [-cv <COQ_VERSION>]"
    exit 1
}

guide() {
    echo "To install the VS Code or VSCodium extension:"
    echo "1. Run code or codium."
    echo "2. Press F1 to open the command palette."
    echo "3. Start typing 'Extensions: Install Extension', press enter, and search for 'vscoq'."
    echo "4. Switch to the pre-release version of the extension and enable it."
    echo "5. Go to the extension settings and enter the vscoqtop full path ($vscoqtop_path) in the field 'Vscoq: Path'."
    echo "6. For asynchronous processing of Coq files, go to 'Proof: Mode' and select 'Continuous'."
}

main() {
    script_dir="$(dirname "$0")"

    # Default versions
    OCAML_VERSION="ocaml-base-compiler.5.2.1"
    COQ_VERSION="8.20.0"

    # Parse options
    
    while getopts "ov:cv:" opt; do                  
        case $opt in
            ov) OCAML_VERSION="$OPTARG" ;;
            cv) COQ_VERSION="$OPTARG" ;;
            *) usage ;;
        esac
    done

    # Source the utilities script to make its functions available
    source "$script_dir/utilities.sh"

    install_packages
    initialize_opam
    install_coq_vscoq
    check_vscoqtop
    guide
}

main "$@"