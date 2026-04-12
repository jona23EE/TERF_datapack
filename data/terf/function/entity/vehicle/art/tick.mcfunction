execute unless data entity @s Passengers run function terf:entity/vehicle/art/assembly/setup

execute if score NETratetimer terf_states >= NETrate terf_states run function terf:entity/vehicle/art/slower_tick

scoreboard players set lockdown_mode terf_states 0
data remove storage terf:temp temp
execute on passengers if entity @s[type=marker] at @s run function terf:entity/vehicle/art/as_marker
execute on passengers if entity @s[type=interaction] at @s run function terf:entity/vehicle/art/as_interaction

execute unless data storage terf:temp temp if score lockdown_mode terf_states matches 0 run return run function terf:entity/vehicle/art/stop
execute unless items block ~ ~-2 ~ container.2 minecraft:diamond if score lockdown_mode terf_states matches 0 run return run function terf:entity/vehicle/art/stop
execute unless block ~ ~-2 ~ hopper if score lockdown_mode terf_states matches 0 run return run function terf:entity/vehicle/art/stop

#check for entity
tag @e[tag=terf_art_target,tag=!terf_art_lock] remove terf_art_target
execute if score lockdown_mode terf_states matches 1 run tag @e[type=marker,tag=terf_warp_core,distance=..256,scores={terf_data_E=1..249}] add terf_art_target
execute as @a[distance=..256] unless predicate terf:has_max_fire_resistance unless score @s terf_data_C matches 1 if score lockdown_mode terf_states matches 0 run function terf:entity/vehicle/art/check_player
execute unless entity @e[tag=terf_art_target,distance=..256,limit=1] run return run function terf:entity/vehicle/art/stop

scoreboard players add @s terf_data_A 1
scoreboard players operation charge terf_states = @s terf_data_A

scoreboard players operation temp2 terf_states = charge terf_states
execute if score temp2 terf_states matches 201.. run scoreboard players set temp2 terf_states 200
execute store result storage terf:temp args.accuracy float 0.00001 run scoreboard players get temp2 terf_states

execute on passengers if entity @s[type=marker] at @s run function terf:entity/vehicle/art/get_target_axes
execute on passengers if entity @s[tag=terf_art_gun] at @s run function terf:entity/vehicle/art/as_gun with storage terf:temp args
execute on passengers if entity @s[tag=terf_art_stand] at @s run function terf:entity/vehicle/art/as_stand with storage terf:temp args2

execute unless score charge terf_states matches 1.. run return fail
execute if score charge terf_states matches 1 run playsound terf:charge_up.railguncharging1 ambient @a[distance=0..] ~ ~ ~ 9 1.6
execute if score charge terf_states matches 1 run playsound terf:elevator_start ambient @a[distance=0..] ~ ~ ~ 1 0

scoreboard players operation charge terf_states %= 10 terf_states
execute if score charge terf_states matches 0 run playsound minecraft:block.note_block.bit ambient @a[distance=0..] ~ ~ ~ 1 2

execute unless score temp terf_states matches 1 run return fail
scoreboard players set @s terf_data_A 0
playsound terf:explosion.missile ambient @a[distance=0..] ~ ~ ~ 3 2
playsound terf:explosion.missile ambient @a[distance=0..] ~ ~ ~ 3 2
playsound terf:explosion.missile ambient @a[distance=0..] ~ ~ ~ 3 2

title @a[distance=..16,tag=!terf_epilepsy_mode] times 0t 0t 4t
title @a[distance=..16,tag=!terf_epilepsy_mode] title {"text":"\uEff4"}

stopsound @a[distance=..16] * terf:elevator_start
item modify block ~ ~-2 ~ container.2 datapipes_lib:decrement_item
