tag @s add terf_stfr_wind
execute store result entity @s Rotation[0] int 1 run random value 1..360
execute store result entity @s Rotation[1] int 1 run random value -90..90
data merge entity @s {brightness:{block:15,sky:15},text:"\ueedb",background:0}
execute if predicate datapipes_lib:chances/50 run data merge entity @s {text_opacity:255,start_interpolation:0,transformation:{left_rotation:{axis:[1.0f,0.0f,0.0f],angle:1.5707963267948966192313216916398}}}
