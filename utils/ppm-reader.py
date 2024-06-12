from PIL import Image

def read_ppm(fp, output_image_path):
    with open(fp, 'r') as file:
        # Read the magic number (P3)
        magic_number = file.readline().strip()
        if magic_number != 'P3':
            raise ValueError("File is not a valid P3 PPM file")
        
        # Skip comments
        line = file.readline().strip()
        while line.startswith('#'):
            line = file.readline().strip()
        
        # Read width, height
        width, height = map(int, line.split())
        
        # Read the maximum color value
        max_color = int(file.readline().strip())
        
        # Read pixel data
        pixels = []
        for line in file:
            pixels.extend(line.split())
        
        # Convert to integers
        pixels = [int(float(value)) for value in pixels]
        
        # Ensure we have enough pixels, fill with white if necessary
        expected_pixels = width * height * 3
        while len(pixels) < expected_pixels:
            pixels.extend([255, 255, 255])  # White pixel

        # Trim excess pixels (just in case)
        pixels = pixels[:expected_pixels]
        
        # Create an image
        image = Image.new("RGB", (width, height))
        pixel_index = 0
        for y in range(height):
            for x in range(width):
                r = pixels[pixel_index]
                g = pixels[pixel_index + 1]
                b = pixels[pixel_index + 2]
                image.putpixel((x, y), (r, g, b))
                pixel_index += 3
        
        # Save the image
        image.save(output_image_path)
        
        return {
            'magic_number': magic_number,
            'width': width,
            'height': height,
            'max_color': max_color,
            'pixels': pixels
        }

# Usage example:
ppm_data = read_ppm('image.ppm', 'output_image.png')