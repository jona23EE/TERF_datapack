data modify storage terf:temp displays.group_core[0].messages[3][1][].color set value "red"

kill @e[type=minecraft:falling_block,distance=..200]
kill @e[type=minecraft:item,distance=..200]

playsound minecraft:entity.lightning_bolt.thunder ambient @a[distance=0..] ~ ~ ~ 40 0
playsound minecraft:entity.lightning_bolt.thunder ambient @a[distance=0..] ~ ~ ~ 40 0
playsound minecraft:entity.lightning_bolt.thunder ambient @a[distance=0..] ~ ~ ~ 40 0
playsound minecraft:entity.lightning_bolt.thunder ambient @a[distance=0..] ~ ~ ~ 40 0
playsound minecraft:entity.lightning_bolt.thunder ambient @a[distance=0..] ~ ~ ~ 40 0

execute unless score dev_mode terf_states matches 0 run return fail

scoreboard players add @s terf_data_E 1

#data modify storage terf:temp args set value {arg1:'function datapipes_lib:require/run_in_all_directions {accuracy:12000,command:"execute rotated ~',arg3:' ~ run function terf:entity/machines/stfr/states/detonation/explosion_raycast"}'}
#execute store result storage terf:temp args.arg2 float 0.2287 run scoreboard players get @s terf_data_E
#execute unless score strong_stfr_boom terf_states matches 1 run return run function datapipes_lib:require/with_args/3 with storage terf:temp args

scoreboard players set temp terf_states 0
data modify storage terf:temp args set value {command:'function terf:entity/machines/stfr/states/detonation/strong_explosion'}
execute store result storage terf:temp args.n int 1 run scoreboard players get @s terf_data_E
function terf:require/run_n_times with storage terf:temp args
scoreboard players operation @s terf_data_Ab += @s terf_data_E

execute unless score @s terf_data_Ab > stfr_explosion_raycasts terf_states run return fail

#unload chunks
data modify storage terf:temp args set value {load:0}
execute store result storage terf:temp args.radius int 16 run scoreboard players get stfr_explosion_load_radius terf_states
function terf:entity/machines/stfr/states/detonation/load_chunks with storage terf:temp args
forceload add ~ ~

function terf:entity/machines/multiblock_core_drop_capsules with entity @s data.terf
function terf:entity/machines/multiblock_core_kill