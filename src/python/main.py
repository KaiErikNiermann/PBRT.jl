from juliacall import Main
from juliacall import Pkg


class MiniRT:
    def __init__(self):
        # julia setup
        Pkg.activate(".")
        Main.seval("using MiniRT")
        Main.seval("using PythonCall")
        Main.seval("using Pkg")
        Main.seval("Pkg.instantiate()")
        Main.seval("Pkg.resolve()")

        self.MiniRT = Main.MiniRT

    def render_scene(self):
        self.MiniRT.render_scene("/scenes/cottage/cottage.obj")

if __name__ == "__main__":
    p = MiniRT()
