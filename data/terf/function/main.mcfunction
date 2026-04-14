#try catching up if ticks got missed (DANGEROUS AND EXPERIMENTAL!!!)
#execute in terf:intermediary_technical_storage_dimension run data modify storage terf:temp temp set from block 29999999 255 29999999 LastOutput
#data modify storage terf:temp args.hours set string storage terf:temp temp 10 12
#data modify storage terf:temp args.minutes set string storage terf:temp temp 13 15
#data modify storage terf:temp args.seconds set string storage terf:temp temp 16 18
#function terf:get_real_time with storage terf:temp args
#execute if score real_time terf_states < game_time terf_states run return fail
#scoreboard players add seconds_ticker terf_states 1
#execute if score seconds_ticker terf_states matches 20.. run scoreboard players add game_time terf_states 1
#execute if score seconds_ticker terf_states matches 20.. run scoreboard players set seconds_ticker terf_states 0
#execute if score real_time terf_states > game_time terf_states run function terf:main

scoreboard players add gametime terf_states 1

#slowerticking
execute if score ETratetimer terf_states matches 10.. run scoreboard players set ETratetimer terf_states 0
scoreboard players add ETratetimer terf_states 1

execute if score NETratetimer terf_states >= NETrate terf_states run scoreboard players set NETratetimer terf_states 0
scoreboard players add NETratetimer terf_states 1
scoreboard players operation NETratehalf terf_states = NETrate terf_states
scoreboard players operation NETratehalf terf_states /= 2 terf_states

execute if score NETratetimer terf_states = NETratehalf terf_states run function datapipes_lib:fluid_transfer/fluid_tick
execute if score NETratetimer terf_states >= NETrate terf_states run function terf:slower_tick

#KEEP. THIS. LOADED. OR. DATAPACK. DETONATES.
execute in terf:intermediary_technical_storage_dimension run forceload add -16 -16 16 16

#stasis chamber nerfs
execute if score ender_pearls_explode_after_awhile terf_states matches 1 as @e[type=ender_pearl] at @s positioned ~ ~.1 ~ run function terf:entity/ender_pearl/tick

#projectiles for mrt and such
execute if score bullets_exists terf_states matches 1.. run function terf:bullet_tick

#prismarine building
execute if score tick_prismarine_bits terf_states matches 1.. as @e[type=item_display,tag=!terf_setup,tag=terf_dark_prismarine_bit] at @s run function terf:entity/player/tool/prismarine_bit/tick 
execute if score tick_prismarine_bits terf_states matches 1.. run scoreboard players remove tick_prismarine_bits terf_states 1

#custom particle system
execute as @e[type=minecraft:text_display,tag=terf_particle,limit=512] at @s run function terf:entity/particle/tick
execute as @e[type=item_display,tag=terf_spark] at @s run function terf:entity/particle/spark/tick

#explosion system
execute as @e[type=minecraft:marker,tag=terf_explosion] at @s run function terf:entity/explosion/tick
execute as @e[type=item_display,tag=terf_seismic_explosion] at @s run function terf:entity/explosion/seismic/tick

#black hole
execute as @e[type=marker,tag=terf_black_hole] at @s run function terf:entity/black_hole/tick

#pressurizer
data modify storage terf:temp temp set value [0.0d,0.0d,0.0d]
execute if score enable_oxygen_system terf_states matches 1 as @e[type=minecraft:armor_stand,tag=terf_gas_oxygen] at @s run function terf:entity/machines/pressurizer/stand/tick

#meteors
execute if score ETratetimer terf_states matches 10.. in minecraft:the_end as @a[distance=0..] at @s if score @s terf_data_C matches 0 if predicate {"condition":"minecraft:random_chance","chance":0.1} run function terf:entity/meteor/spawn_end_player
execute as @e[type=minecraft:item_display,tag=terf_meteor] at @s run function terf:entity/meteor/tick

#space
execute in terf:orbit_earth as @e[type=!minecraft:player,type=!minecraft:marker,type=!minecraft:item_display,tag=!terf_nogravity] run function terf:entity/in_space
execute in terf:orbit_end as @e[type=!minecraft:player,type=!minecraft:marker,type=!minecraft:item_display,tag=!terf_nogravity] run function terf:entity/in_space

#sculk stuff
execute as @e[type=minecraft:marker,tag=terf_sculk_charge] at @s run function terf:entity/sculk_charge/tick
execute as @e[type=minecraft:marker,tag=terf_super_catalyst] at @s run function terf:entity/sculk_charge/super_catalyst/tick

#nuclear stuff
execute as @e[type=minecraft:marker,tag=terf_neutron] at @s run function terf:entity/neutron/tick with entity @s data.terf.neutron
execute if score ETratetimer terf_states matches 10 as @e[type=minecraft:marker,tag=terf_fuel_rod] at @s run function terf:entity/machines/fission_reactor/rod_marker_tick
execute as @e[type=marker,tag=terf_marked_rod,sort=random,limit=1] at @s run function terf:entity/machines/fission_reactor/compiler/as_markers

#photon ball
execute as @e[type=minecraft:marker,tag=terf_photon_ball] at @s run function terf:entity/photon_ball/tick

#limbo
execute if score oldmapadditions_installed terfmap_states matches 1 as @e[type=minecraft:marker,tag=terf_limbo] at @s run function terf:entity/limbo/tick

#gasses
execute as @e[type=bat,tag=terf_gas,tag=terf_fire] at @s run setblock ~ ~ ~ fire keep

#fallout
execute as @e[type=minecraft:marker,tag=terf_fallout] at @s run function terf:entity/fallout/tick

#electromagnetic container receptacles
execute if score receptacle_tick terf_states matches 1.. run function terf:entity/receptacle/tick_global

#vehicles (aka entities with a passenger layout)
execute as @e[tag=terf_vehicle] at @s run function terf:entity/vehicle/vehicle_tick

#multiblock core
execute if score NETratetimer terf_states >= NETrate terf_states as @e[type=marker,tag=terf_multiblockcore] at @s run function terf:entity/machines/multiblock_core_slower_tick
execute as @e[type=marker,tag=terf_multiblockcore,tag=!terf_slower_ticked] at @s run function terf:entity/machines/multiblock_core_args with entity @s data.terf

#function that runs for every player
execute as @a at @s run function terf:entity/player/everyone

#------------------------------| Experimental / Not yet obtainable features |------------------------------
execute unless score experimental_features terf_states matches 1 run return fail

#stone plate
execute as @e[type=minecraft:item_display,tag=terf_stone_plate] at @s run function terf:entity/stone_plate/tick

#missiles
execute as @e[type=minecraft:item_display,tag=terf_missile] at @s run function terf:entity/missile/tick

#orbital strike
execute as @e[type=marker,tag=terf_orbital_strike] at @s run function terf:entity/orbital_strike/tick

#kilonova
execute as @e[type=minecraft:marker,tag=terf_kilonova] at @s run function terf:entity/kilonova/tick

#entity conveyor
#execute as @e[type=!item,type=!minecraft:marker,type=!minecraft:item_display,type=!minecraft:block_display,type=!minecraft:interaction] at @s if block ~ ~-0.16 ~ minecraft:magenta_glazed_terracotta unless score @s terf_sneaking matches 1.. run function terf:entity/machines/conveyor/as_entity

#solar panels
#execute as @e[type=minecraft:marker,tag=terf_solar_panel] at @s positioned ~ ~1 ~ run function terf:entity/machines/solar_panel/wire_checks/connected_wires_on
#scoreboard players set solar_panel_checks terf_states 0

#nuke
execute as @e[type=minecraft:item_display,tag=terf_nuke] at @s run function terf:entity/nuke/tick
