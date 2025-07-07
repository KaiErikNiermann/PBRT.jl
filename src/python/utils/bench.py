import time
import functools
import threading


class Benchmark:
    _results = []
    _lock = threading.Lock()  # To prevent race conditions in parallel tracing

    @staticmethod
    def run(func=None, *, name=None):
        def decorator(func):
            @functools.wraps(func)
            def wrapper(*args, **kwargs):
                before = time.perf_counter_ns()
                result = func(*args, **kwargs)
                after = time.perf_counter_ns()
                elapsed = after - before  # in ns

                with Benchmark._lock:
                    Benchmark._results.append({
                        "before": before,
                        "after": after,
                        "elapsed": elapsed,
                        "gc": "0",
                        "tp": elapsed,
                    })

                return result
            return wrapper
        return decorator

    @staticmethod
    def save(path="/workspaces/Thesis/benchmarks/py_time.csv"):
        with open(path, "w") as f:
            for entry in Benchmark._results:
                f.write(
                    f"{entry['before']},{entry['after']},{int(entry['elapsed'])}, {entry['gc']},{entry['tp']}\n")
