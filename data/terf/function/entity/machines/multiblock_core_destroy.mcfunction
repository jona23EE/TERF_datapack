execute as @s[tag=terf_lamp_controller] if score @s terf_data_A matches 1 run function terf:entity/machines/lamp_controller/lamps_off_instant
execute as @s[tag=terf_security_turret] if data entity @s data.terf.security_config run function terf:entity/machines/security_turret/explosion
execute as @s[tag=terf_pressurizer] run function terf:entity/machines/pressurizer/destroyed with entity @s data.terf
execute as @s[tag=terf_ifire_pro_max] run function terf:entity/explosion/small_explosion/summon
execute as @s[tag=terf_shearing_press] run setblock ^1 ^1 ^ iron_trapdoor[open=true]
execute as @s[tag=terf_chunk_loader] run forceload remove ~-48 ~-48 ~48 ~48

function terf:entity/machines/multiblock_core_drop_capsules with entity @s data.terf

data modify storage terf:temp args.array set from entity @s data.fluids
function terf:entity/explosion/antimatter/attempt_explosion

function terf:require/custom_item_summon {count:1,id:"terf:multiblock_core"}
particle minecraft:end_rod ~ ~ ~ 0 0 0 0.5 100 force
playsound minecraft:block.beacon.deactivate block @a[distance=0..] ~ ~ ~ 1 2
function terf:entity/machines/multiblock_core_kill