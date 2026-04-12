stopsound @a[distance=..160] * terf:music.hacknet_labyrinths_ogre_snidelywhiplash
playsound terf:music.hacknet_music_end ui @a[distance=0..,tag=!terf_disable_music] ~ ~ ~ 10 1
execute as @s[tag=terf_speakerconnected] run playsound terf:alarms.beep2 master @a[distance=0..] ~ ~ ~ 1 1
tag @s add terf_restabilizing
execute at @s run playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
execute at @s run playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
execute at @s run playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
execute at @s run playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
execute at @s run playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8

$execute as @e[tag=terf_related_$(machine_id),tag=terf_stab_rotor,tag=!terf_stab_rotor_vertical] run data merge entity @s {start_interpolation:0,interpolation_duration:400,transformation:{translation:[0f,0f,0f],scale:[1f,1f,1f]}}
$execute as @e[tag=terf_related_$(machine_id),tag=terf_stab_d_rotor] run data merge entity @s {start_interpolation:0,interpolation_duration:400,transformation:{translation:[0f,1f,0f],scale:[1f,1f,1f]}}
$execute as @e[tag=terf_related_$(machine_id),tag=terf_stab_u_rotor] run data merge entity @s {start_interpolation:0,interpolation_duration:400,transformation:{translation:[0f,0f,0f],scale:[1f,1f,1f]}}
