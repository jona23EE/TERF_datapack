texture_path = "C:/Users/jona23/AppData/Roaming/PrismLauncher/instances/TERF (1.21.8)/.minecraft/resourcepacks/TERFresources/assets/terf/textures/item/material"

layer1 = "C:/Users/jona23/AppData/Roaming/PrismLauncher/instances/TERF (1.21.8)/.minecraft/resourcepacks/TERFresources/assets/terf/textures/item/material/bright/ingot.png"
layer2 = "C:/Users/jona23/AppData/Roaming/PrismLauncher/instances/TERF (1.21.8)/.minecraft/resourcepacks/TERFresources/assets/terf/textures/item/material/bright/ingot_overlay.png"
layer3 = "C:/Users/jona23/AppData/Roaming/PrismLauncher/instances/TERF (1.21.8)/.minecraft/resourcepacks/TERFresources/assets/terf/textures/item/material/bright/ingot_secondary.png"

import tkinter as tk
from PIL import Image, ImageTk, ImageDraw
import colorsys
import numpy as np
import os
import pyperclip

# Helper: Convert HSL to RGB
def hsl_to_rgb(h, s, l):
    r, g, b = colorsys.hls_to_rgb(h / 360.0, l, s)
    return int(r * 255), int(g * 255), int(b * 255)

# Apply HSL tint using numpy for performance
def apply_hsl(image, h, s, l):
    arr = np.array(image).astype(np.float32) / 255.0
    alpha = arr[:, :, 3:4]  # Keep alpha separate
    rgb = np.array(hsl_to_rgb(h, s, l), dtype=np.float32) / 255.0
    # Multiplicative blend on RGB channels
    blended = arr[:, :, :3] * rgb
    result = np.dstack((blended, alpha))
    result = (result * 255).clip(0, 255).astype(np.uint8)
    return Image.fromarray(result, 'RGBA')

class LayerApp:
    def __init__(self, root):
        self.root = root
        root.title("Material Editor")
        root.configure(bg='#8b8b8b')

        # Load images and scale 8x for pixel art
        self.images = []
        for fname in [layer1, layer2, layer3]:
            img = Image.open(fname).convert("RGBA")
            img = img.resize((img.width * 8, img.height * 8), Image.NEAREST)
            self.images.append(img)

        self.hsl_values = [(0, 0.5, 0.5) for _ in range(3)]
        self.visible_layer_count = 1

        # Canvas for combined image
        self.canvas = tk.Label(root, bg='#8b8b8b')
        self.canvas.grid(row=0, column=0, columnspan=4)

        # HSL selectors
        self.sliders = []
        self.hs_images = []
        self.hs_tk_images = []
        self.hex_entries = []
        for i in range(3):
            text = "Base Color"
            if i == 1:
                text = "Overlay Color"
            elif i == 2:
                text = "Secondary Color"
            frame = tk.LabelFrame(root, text=text, bg='#8b8b8b', fg='white')
            frame.grid(row=1, column=i, padx=5, pady=5, sticky="nsew")
            h_var = tk.DoubleVar(value=self.hsl_values[i][0])
            s_var = tk.DoubleVar(value=self.hsl_values[i][1])
            l_var = tk.DoubleVar(value=self.hsl_values[i][2])

            hs_canvas = tk.Canvas(frame, width=180, height=180, bg='#8b8b8b', highlightthickness=2)
            hs_canvas.pack()
            hs_canvas.bind("<B1-Motion>", lambda e, idx=i: self.update_hs_from_canvas(e, idx))
            hs_canvas.bind("<Button-1>", lambda e, idx=i: self.update_hs_from_canvas(e, idx))

            # Create H/S selector image
            hs_img = self.create_hs_image(180, 180, l_var.get())
            hs_tk = ImageTk.PhotoImage(hs_img)
            self.hs_tk_images.append(hs_tk)
            hs_canvas.create_image(0, 0, anchor='nw', image=hs_tk)

            l_scale = tk.Scale(frame, from_=0, to=1, resolution=0.01, orient="horizontal", bg='#8b8b8b', fg='white', highlightbackground='#8b8b8b', variable=l_var, command=lambda val, idx=i: self.update_hsl(idx))
            l_scale.pack()

            hex_var = tk.StringVar()
            hex_entry = tk.Entry(frame, textvariable=hex_var, width=10, bg='#8b8b8b', fg='white', insertbackground='white')
            hex_entry.pack()
            hex_entry.bind("<Return>", lambda e, idx=i: self.update_from_hex(idx))
            self.hex_entries.append(hex_var)

            self.sliders.append({'h': h_var, 's': s_var, 'l': l_var, 'hs_canvas': hs_canvas, 'l_scale': l_scale, 'hs_img': hs_img, 'hs_tk': hs_tk, 'hex_var': hex_var})

        self.text_entry = tk.Entry(root, bg='#8b8b8b', fg='white', insertbackground='white')
        self.text_entry.grid(row=2, column=0, columnspan=3, sticky="we")
        self.text_entry.bind('<KeyRelease>', lambda e: self.load_images())

        tk.Button(root, text="Copy", command=self.copy, bg='#8b8b8b', fg='white').grid(row=2, column=3)
        tk.Button(root, text="Toggle layers", command=self.toggle_layers, bg='#8b8b8b', fg='white').grid(row=3, column=0, columnspan=4)

        self.update_canvas()

    # Function to generate H/S gradient image
    def create_hs_image(self, width, height, l):
        img = Image.new("RGB", (width, height))
        for x in range(width):
            for y in range(height):
                h = (x / width) * 360
                s = 1 - (y / height)
                r, g, b = hsl_to_rgb(h, s, l)
                img.putpixel((x, y), (r, g, b))
        return img

    # Update H/S values from mouse click/move
    def update_hs_from_canvas(self, event, idx):
        canvas = self.sliders[idx]['hs_canvas']
        width, height = int(canvas['width']), int(canvas['height'])
        x = min(max(event.x, 0), width - 1)
        y = min(max(event.y, 0), height - 1)
        h = (x / width) * 360
        s = 1 - (y / height)
        self.sliders[idx]['h'].set(h)
        self.sliders[idx]['s'].set(s)
        self.update_hsl(idx)

    # Process function
    def copy(self):
        path = self.text_entry.get().strip()
        if self.visible_layer_count == 2:
            path = path + "_overlay"
        elif self.visible_layer_count == 3:
            path = path + "_secondary"
            
        colors = ''
        for i in range(self.visible_layer_count):
            if self.sliders[i]['hs_canvas'].cget('highlightbackground') != '#FFFFFF':
                continue
            h, s, l = self.hsl_values[i]
            hex_color = '%02x%02x%02x' % hsl_to_rgb(h, s, l)
            colors = colors + str(int(hex_color, 16)) + ","

        output = '/give @s minecraft:recovery_compass[minecraft:item_model="terf:material/'+path+'",custom_model_data={colors:[I;'+colors[:-1]+']}]'
        pyperclip.copy(output)
        print("Copied "+output)

    # Toggle layers visibility
    def toggle_layers(self):
        self.visible_layer_count = (self.visible_layer_count % 3) + 1
        self.update_canvas()

    # Update combined image
    def update_canvas(self):
        combined = Image.new("RGBA", self.images[0].size, (0,0,0,0))
        for i in range(3):
            h, s, l = self.hsl_values[i]
            layer_img = apply_hsl(self.images[i], h, s, l)
            self.sliders[i]['hex_var'].set('#%02x%02x%02x' % hsl_to_rgb(h, s, l))
            if i < self.visible_layer_count:
                try:
                    combined = Image.alpha_composite(combined, layer_img)
                    self.sliders[i]['hs_canvas'].config(highlightbackground='#FFFFFF')
                except Exception:
                    self.sliders[i]['hs_canvas'].config(highlightbackground='#FF0000')
            else:
                self.sliders[i]['hs_canvas'].config(highlightbackground='#000000')

        self.tk_image = ImageTk.PhotoImage(combined)
        self.canvas.configure(image=self.tk_image)

    # Update HSL values and refresh
    def update_hsl(self, idx):
        h = self.sliders[idx]['h'].get()
        s = self.sliders[idx]['s'].get()
        l = self.sliders[idx]['l'].get()
        self.hsl_values[idx] = (h, s, l)
        self.update_canvas()

    # Load the images from the bottom text field thingy
    def load_images(self):
        base_path = f"{texture_path}/{self.text_entry.get().strip()}"
        def try_load(path):
            if os.path.exists(path):
                img = Image.open(path).convert("RGBA")
                return img.resize((img.width*8, img.height*8), Image.NEAREST)
            else:
                parent_dir = os.path.dirname(os.path.dirname(path))
                dull_dir = os.path.join(parent_dir, "dull")
                new_path = os.path.join(dull_dir, os.path.basename(path))
                if os.path.exists(new_path):
                    img = Image.open(new_path).convert("RGBA")
                    return img.resize((img.width*8, img.height*8), Image.NEAREST)
                return Image.new('RGBA', (64,64), (0,0,0,0))

        def try_load_nodull(path):
            if os.path.exists(path):
                img = Image.open(path).convert("RGBA")
                return img.resize((img.width*8, img.height*8), Image.NEAREST)
            return Image.new('RGBA', (64,64), (0,0,0,0))
            
        self.images = [
            try_load(base_path+".png"),
            try_load_nodull(base_path+"_overlay.png"),
            try_load_nodull(base_path+"_secondary.png")
        ]
        self.update_canvas()

    # Update from hex entry
    def update_from_hex(self, idx):
        hex_val = self.sliders[idx]['hex_var'].get()
        if hex_val.startswith('#') and len(hex_val) == 7:
            r = int(hex_val[1:3], 16) / 255
            g = int(hex_val[3:5], 16) / 255
            b = int(hex_val[5:7], 16) / 255
            h, l, s = colorsys.rgb_to_hls(r, g, b)
            self.sliders[idx]['h'].set(h * 360)
            self.sliders[idx]['s'].set(s)
            self.sliders[idx]['l'].set(l)
            self.update_hsl(idx)

root = tk.Tk()
app = LayerApp(root)
root.mainloop()