from PIL import Image

def read_ppm(file_path):
    with open(file_path, 'rb') as f:
        # Read the header
        magic_number = f.readline().decode().strip()
        if magic_number != 'P3':
            raise ValueError("Invalid PPM file format")
        
        # Read dimensions
        width, height = map(int, f.readline().decode().split())
        
        # Read the maximum color value
        max_color_value = int(f.readline().decode().strip())
        
        # Read image data
        image_data = f.read()
        
    return width, height, max_color_value, image_data

def render_ppm(width, height, max_color_value, image_data):
    image = Image.new('RGB', (width, height))
    pixels = list(image.getdata())

    # Parse pixel data
    for i in range(width * height):
        r = image_data[i * 3]
        g = image_data[i * 3 + 1]
        b = image_data[i * 3 + 2]
        pixels[i] = (r, g, b)

    # Display image
    image.putdata(pixels)
    image.save("output.png")

# function to plot distribution of red green and blue pixel values 
import matplotlib.pyplot as plt
import numpy as np
import cv2
import os
def plot_rgb_distribution(image_path):
    image = cv2.imread(image_path)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    red, green, blue = cv2.split(image)
    fig, ax = plt.subplots(1, 3, figsize=(15, 5))
    ax[0].hist(red.ravel(), 256, [0, 256], color='r')
    ax[0].set_title('Red Channel')
    ax[1].hist(green.ravel(), 256, [0, 256], color='g')
    ax[1].set_title('Green Channel')
    ax[2].hist(blue.ravel(), 256, [0, 256], color='b')
    ax[2].set_title('Blue Channel')
    plt.savefig("rgb_distribution.png")

if __name__ == "__main__":
    file_path = "../image.ppm"
    try:
        width, height, max_color_value, image_data = read_ppm(file_path)
        render_ppm(width, height, max_color_value, image_data)
        try: 
            plot_rgb_distribution("output.png")
        except Exception as e:
            print("Error:", e)
    except Exception as e:
        print("Error:", e)
