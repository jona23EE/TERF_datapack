HOW TO USE
1) You need to make any 16 by 16 texture
2) Replace Bottom left pixel with white pixel with oppacity 254
3) 4 following pixels should have opacity from 251 to 254 (last 4 digits will make your shader ID, like 4444, or 1111), colour doesn't matter, you have 4 ^ 4 = 256 unique IDs in total
4) Make item definition, model, and add your shader to rendertype_item_entity_translucent_cull.fsh, otherwise it will go to default behaviour
5) Model should not contain any shitty not 16 by 16 vertexes!
