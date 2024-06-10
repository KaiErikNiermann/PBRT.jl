import numpy as np
from dataclasses import dataclass

@dataclass 
class Image: 
    width: int
    height: int
    spp: int
    max_depth: int
    
@dataclass 
class Camera: 
    origin: np.ndarray
    lower_left_corner: np.ndarray
    horizontal: np.ndarray
    vertical: np.ndarray
    u: np.ndarray
    v: np.ndarray
    w: np.ndarray
    lens_radius: float
    