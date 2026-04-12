playsound terf:reactorshutdown ambient @a[distance=0..] ~ ~ ~ 10 1
playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
playsound terf:charge_up.heavy_shutdown ambient @a[distance=0..] ~ ~ ~ 3 0.8
playsound minecraft:block.beacon.deactivate ambient @a[distance=0..] ~ ~ ~ 10 0
playsound minecraft:block.beacon.deactivate ambient @a[distance=0..] ~ ~ ~ 10 0
playsound minecraft:block.beacon.deactivate ambient @a[distance=0..] ~ ~ ~ 10 0
playsound minecraft:block.beacon.deactivate ambient @a[distance=0..] ~ ~ ~ 10 0
playsound minecraft:block.beacon.deactivate ambient @a[distance=0..] ~ ~ ~ 10 0
playsound minecraft:block.beacon.deactivate ambient @a[distance=0..] ~ ~ ~ 10 0
playsound minecraft:block.beacon.deactivate ambient @a[distance=0..] ~ ~ ~ 10 0
particle minecraft:end_rod ~ ~ ~ 0.5 0.5 0.5 0.1 1000 force
particle minecraft:flame ~ ~ ~ 0.5 0.5 0.5 0.1 1000 force
particle minecraft:firework ~ ~ ~ 0.5 0.5 0.5 0.3 100 force
particle minecraft:lava ~ ~ ~ 0.5 0.5 0.5 0.3 100 force
particle minecraft:campfire_signal_smoke ~ ~ ~ 0.5 0.5 0.5 0.01 100 force
advancement grant @a[distance=..32] only terf:stfr/stfr_shutdown
tag @s remove terf_stfr_opshield
tag @s remove terf_breakers_activated
tag @s remove terf_core_online
function terf:entity/machines/stfr_control_panel/mute_alarms

data modify entity @n[tag=terf_stfr] data.terf.core_contents set value []

scoreboard players set @s terf_data_L 0
scoreboard players set @s terf_data_M 22000
scoreboard players set @s terf_data_N 100000

data modify storage terf:temp args set value {arg1:'execute as @e[type=minecraft:marker,tag=terf_maintenance,tag=terf_related_',arg3:'] run kill @s'}
data modify storage terf:temp args.arg2 set from entity @s data.terf.machine_id
function datapipes_lib:require/with_args/3 with storage terf:temp args

tag @s add terf_stab1_breach
tag @s add terf_stab2_breach
tag @s add terf_stab3_breach
tag @s add terf_stab4_breach
tag @s add terf_stab5_breach
tag @s add terf_stab6_breach
tag @s add terf_stab_pistons_breach
tag @s add terf_low_temp
tag @s add terf_low_temp_crit
tag @s add terf_fuel_crit
tag @s add terf_low_fuel

function terf:entity/machines/stfr/stabilizers_off
function terf:entity/machines/stfr/visuals/stabilizer/all_stab_rods_off