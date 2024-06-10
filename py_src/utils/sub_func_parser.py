import os
import sys

JL_FP = "../interface"

def get_sub_func_list() -> list[str]:
    jl_funcs: list[str] = []
    for jl_f in os.listdir(JL_FP):
        if jl_f.endswith(".jl"):
            with open(os.path.join(JL_FP, jl_f), 'r') as f:
                jl_funcs.append(f"""{f.read()}""")
    return jl_funcs