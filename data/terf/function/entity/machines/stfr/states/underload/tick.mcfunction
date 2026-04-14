#override control panel text
data modify storage terf:temp displays.group_main[1].messages[1] set value {"text":"unknown","color":"gray"}
data modify storage terf:temp displays.group_core[0].messages[0] set value {"text":"?  ?  ?",screen_color:"gray"}

function terf:autokick

scoreboard players add @s terf_data_E 1

execute if score @s terf_data_E matches 30 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.system_damage',level:3,text:'{"text":"Major System Damage! Unable To Retreive Reactor Core Vitals","color":"dark_aqua"}'}

execute if score @s terf_data_E matches 300 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.stabilization_failure',level:5,text:'{"text":"Complete Stabilization Failure! Cannot Confirm Reactor Core Offline State","color":"dark_aqua"}'}
execute if score @s terf_data_E matches 320 run playsound terf:music.remi_galleno_panic_track ui @a[tag=!terf_disable_music,distance=0..] ~ ~ ~ 16 0.9
execute if score @s terf_data_E matches 320 as @a[distance=..256] run function terf:entity/player/title_music {music:"Remi Gallego - Panic Track (slowed)"}

execute if score @s terf_data_E matches 500 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.connecting_backup_systems',level:0,text:'{"text":"Attempting To Connect Backup Systems, Standby...","color":"dark_aqua"}'}

execute if score @s terf_data_E matches 700 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.backup_systems_online',level:0,text:'{"text":"Backup Systems Online","color":"yellow"}'}
execute if score @s terf_data_E matches 720 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.scanning',level:0,text:'{"text":"Scanning Reactor Core To Confirm Offline State...","color":"yellow"}'}
execute if score @s terf_data_E matches 900 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.no_match',level:0,text:'{"text":"Cannot Confirm Reactor Core Offline State: No Match Found In Database","color":"yellow"}'}

execute if score @s terf_data_E matches 920 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.field_increasing',level:0,text:'{"text":"Core Magnetic Field Rapidly Increasing! Monitoring...","color":"yellow"}'}

execute if score @s terf_data_E matches 1130 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.underload.evacuate',level:4,text:'{"text":"Extreme Structural Stress, A Complete Reactor Structural Failure May Occour! Evacuate The Facility Immediately.","color":"red"}'}

#process visuals for this state
execute if score @s terf_data_E matches 900.. run function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/10',contp:'datapipes_lib:chances/10'}

execute store result entity 0010eff0-0010-effa-0010-cd370010c94e Rotation[0] float 0.5 run scoreboard players get @s terf_data_E
execute if score @s terf_data_E matches 1980.. rotated as 0010eff0-0010-effa-0010-cd370010c94e rotated ~ 20 run function terf:entity/machines/stfr/states/underload/field_start

particle minecraft:wax_off ~ ~ ~ 0 0 0 70 10 force
particle flash{color:[1,1,1,1]}
particle minecraft:gust ~ ~.2 ~ 0.01 0.01 0.01 0 1 force
execute if score @s terf_data_E matches 3500.. run particle minecraft:end_rod ~ ~ ~ 0 0 0 0.3 10 force
execute if score @s terf_data_E matches 3600.. run particle flash{color:[1,1,1,1]} ~ ~ ~ 0 0 0 0 10 force

execute if score @s terf_data_E matches 1980.. run particle flash{color:[1,1,1,1]} ~ ~ ~ 5 5 5 0 1 force
execute if score @s terf_data_E matches 1130.. run data modify storage terf:temp displays.group_main[].color set value "red"

data modify storage terf:temp args set value {arg1:'execute positioned ^ ^ ^',arg3:' run function terf:entity/machines/stfr/states/underload/shockwave'}
execute store result storage terf:temp args.arg2 float 0.5 run scoreboard players get @s terf_data_E
execute if score @s terf_data_E matches ..100 run function datapipes_lib:require/run_in_all_directions {accuracy:10000,command:'function datapipes_lib:require/with_args/3 with storage terf:temp args'}

scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players remove temp terf_states 1960
data modify storage terf:temp args set value {arg1:'execute positioned ^ ^ ^',arg3:' run particle flash{color:[1,1,1,1]} ~ ~ ~ 1 0 1 0 20 force'}
execute store result storage terf:temp args.arg2 float 1 run scoreboard players get temp terf_states
execute if score @s terf_data_E matches 1960..1980 run function datapipes_lib:require/run_in_all_directions {accuracy:10000,command:'function datapipes_lib:require/with_args/3 with storage terf:temp args'}

execute as @s[tag=terf_stab6] run particle minecraft:large_smoke ~ ~-8.5 ~ 0.7 0 0.7 0 10 force
execute as @s[tag=terf_stab5] run particle minecraft:large_smoke ~-8.5 ~ ~ 0 0.7 0.7 0 10 force
execute as @s[tag=terf_stab4] run particle minecraft:large_smoke ~ ~ ~-8.5 0.7 0.7 0 0 10 force
execute as @s[tag=terf_stab3] run particle minecraft:large_smoke ~8.5 ~ ~ 0 0.7 0.7 0 10 force
execute as @s[tag=terf_stab2] run particle minecraft:large_smoke ~ ~ ~8.5 0.7 0.7 0 0 10 force
execute as @s[tag=terf_stab1] run particle minecraft:large_smoke ~ ~8.5 ~ 0.7 0 0.7 0 10 force

execute as @s[tag=terf_stab6] run particle minecraft:large_smoke ~ ~-10.5 ~ 0.7 0 0.7 0 10 force
execute as @s[tag=terf_stab5] run particle minecraft:large_smoke ~-10.5 ~ ~ 0 0.7 0.7 0 10 force
execute as @s[tag=terf_stab4] run particle minecraft:large_smoke ~ ~ ~-10.5 0.7 0.7 0 0 10 force
execute as @s[tag=terf_stab3] run particle minecraft:large_smoke ~10.5 ~ ~ 0 0.7 0.7 0 10 force
execute as @s[tag=terf_stab2] run particle minecraft:large_smoke ~ ~ ~10.5 0.7 0.7 0 0 10 force
execute as @s[tag=terf_stab1] run particle minecraft:large_smoke ~ ~10.5 ~ 0.7 0 0.7 0 10 force

scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players operation temp terf_states %= 360 terf_states

data modify storage terf:temp args set value {command:"function terf:entity/machines/opencore/states/online/counterrotating_particles"}
execute store result storage terf:temp args.angle int -2 run scoreboard players get temp terf_states
function datapipes_lib:require/run_with_angle with storage terf:temp args
execute if score @s terf_data_E matches 1982.. run particle minecraft:campfire_cosy_smoke ~ ~ ~ 0 0 0 1 10 force

#process sounds for this state
execute if score @s terf_data_E matches 2420 run playsound terf:rumbling master @a[distance=0..] ~ ~ ~ 10 0.55
execute if score @s terf_data_E matches 1982.. run playsound minecraft:entity.zombie_villager.converted master @a[distance=0..] ~ ~ ~ 5 0.7
scoreboard players operation temp terf_states = @s terf_data_T
scoreboard players operation temp terf_states %= 8 terf_states
execute if score temp terf_states matches 0 run playsound minecraft:block.bell.resonate master @a[distance=0..] ~ ~ ~ 5 0.5
execute if score temp terf_states matches 0 run playsound minecraft:block.bell.resonate master @a[distance=0..] ~ ~ ~ 5 0.5

function terf:entity/machines/stfr/sound/alarm_measurement_error
execute if score @s terf_data_E matches 1130..1980 run function terf:entity/machines/stfr/sound/alarm_reaction_loss_tick
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players operation temp terf_states %= 240 terf_states
execute if score @s terf_data_E matches 1980.. if score temp terf_states matches 200 run playsound terf:alarms.airraidsiren master @a[distance=0..] ~ ~ ~ 50 1

execute if score @s terf_data_E matches 3400 run playsound terf:charge_up.mega_chargeup master @a[distance=0..] ~ ~ ~ 16 2
execute if score @s terf_data_E matches 3400 run playsound terf:charge_up.mega_chargeup master @a[distance=0..] ~ ~ ~ 16 2
execute if score @s terf_data_E matches 3400 run playsound terf:charge_up.mega_chargeup master @a[distance=0..] ~ ~ ~ 16 2
execute if score @s terf_data_E matches 3400 run playsound terf:charge_up.mega_chargeup master @a[distance=0..] ~ ~ ~ 16 2

#event logic
execute if score @s terf_data_E matches 1980..3220 if predicate datapipes_lib:chances/1 run function terf:entity/machines/stfr/states/underload/random_explosion
execute if score @s terf_data_E matches 3620 run function terf:entity/machines/stfr/states/underload/random_explosion

execute if score @s terf_data_E matches 3620 as @e[type=minecraft:falling_block,distance=..30] run data modify entity @s NoGravity set value 0b
execute if score @s terf_data_E matches 3640.. run function terf:entity/machines/stfr/states/detonation/detonate_reactor
execute if score @s terf_data_E matches 3510 run title @a[distance=0..] times 260 10 0
execute if score @s terf_data_E matches 3510 run title @a[distance=0..] title {"text":"\ueff4","color":"gray"}

execute if score @s terf_data_E matches 1982.. run scoreboard players set @s terf_connected_mainframe -69

execute if score @s terf_data_E matches 1980 run function terf:entity/machines/stfr/states/underload/structure_fail
execute if score @s terf_data_E matches 1981..3600 run function terf:entity/machines/stfr/states/underload/check_falling_blocks
execute if score @s terf_data_E matches 1981.. run particle minecraft:explosion ~ ~ ~ 0 0 0 8 1 force

scoreboard players operation temp terf_states = @s terf_data_T
scoreboard players operation temp terf_states %= 10 terf_states
execute if score temp terf_states matches 0 if score @s terf_data_E matches 1101.. run summon marker ~ ~ ~ {Tags:['terf_reactororbit']}

execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run function terf:entity/machines/stfr/states/underload/as_orbital_particles
execute if score @s terf_data_E matches 1101..1120 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.5 ^-0.01 ^
execute if score @s terf_data_E matches 1121..1220 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.2 ^-0.01 ^
execute if score @s terf_data_E matches 1221..1270 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.1 ^-0.01 ^0.01
execute if score @s terf_data_E matches 1271..1300 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.2 ^0.01 ^-0.01
execute if score @s terf_data_E matches 1301..1380 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.1 ^0.05 ^-0.01
execute if score @s terf_data_E matches 1381..1410 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^1.5 ^-0.01 ^0.05
execute if score @s terf_data_E matches 1411..1420 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.3 ^-0.02 ^-0.01
execute if score @s terf_data_E matches 1421..1520 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.19 ^0.01 ^0.4
execute if score @s terf_data_E matches 1521..1550 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.2 ^-0.3 ^0.01
execute if score @s terf_data_E matches 1551..1590 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.19 ^0.01 ^-0.01
execute if score @s terf_data_E matches 1591..1610 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.1 ^0.05 ^0.01
execute if score @s terf_data_E matches 1611..1700 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.13 ^-0.01 ^0.09
execute if score @s terf_data_E matches 1701..1760 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.1 ^0.05 ^0.01
execute if score @s terf_data_E matches 1831..1850 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.19 ^0.01 ^-0.01
execute if score @s terf_data_E matches 1851..1900 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.2 ^-0.3 ^0.01
execute if score @s terf_data_E matches 1901..2010 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.19 ^0.01 ^0.4
execute if score @s terf_data_E matches 2011..2120 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.3 ^-0.02 ^-0.01
execute if score @s terf_data_E matches 2121..2160 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.15 ^-0.01 ^0.05
execute if score @s terf_data_E matches 2161..2270 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.1 ^0.05 ^-0.01
execute if score @s terf_data_E matches 2271..2310 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.3 ^0.01 ^-0.01
execute if score @s terf_data_E matches 2311..2370 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.1 ^-0.01 ^0.01
execute if score @s terf_data_E matches 2371..2380 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.1 ^-0.01 ^
execute if score @s terf_data_E matches 2381..2390 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.5 ^-0.01 ^
execute if score @s terf_data_E matches 2391..2790 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.5 ^0.01 ^0.01
execute if score @s terf_data_E matches 2791..3090 run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.7 ^0.1 ^-1.01
execute if score @s terf_data_E matches 3091.. run execute as @e[type=minecraft:marker,tag=terf_reactororbit] at @s run tp @s ^0.7 ^0.1 ^-1.01

