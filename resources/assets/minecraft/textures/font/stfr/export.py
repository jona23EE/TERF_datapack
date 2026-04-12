SAVE_PATH = "C:/Users/jona23/AppData/Roaming/PrismLauncher/instances/TERF (1.21.8)/minecraft/resourcepacks/TERFresources/assets/minecraft/textures/font/stfr/"

import json
import base64

with open(SAVE_PATH + 'all.bbmodel', 'r') as file:
    data = json.load(file)

data = data['textures']
data = data[0]
data = data['layers']

for layer in data:
    # Get data url from json thingy
    data_url = layer['data_url']

    # Strip the header
    header, encoded = data_url.split(',', 1)

    # Decode the base64 data
    image_data = base64.b64decode(encoded)

    # Save image
    name = layer['name']

    with open(SAVE_PATH + name + '.png', 'wb') as f:
        f.write(image_data)

