scoreboard players add @s terf_data_A 1
execute if score @s terf_data_A matches 5 run data merge entity @s {text_opacity:128,interpolation_duration:5,transformation:{translation:[-5f,0f,0f],scale:[1f,10f,0f]}}
execute if score @s terf_data_A matches 10 run data merge entity @s {text_opacity:127,interpolation_duration:0}
execute if score @s terf_data_A matches 11 run data merge entity @s {text_opacity:25,interpolation_duration:5,transformation:{translation:[-10f,0f,0f],scale:[1f,10f,0f]}}


execute if score @s terf_data_A matches 20.. run kill @s
