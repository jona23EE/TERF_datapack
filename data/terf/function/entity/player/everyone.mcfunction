#terf_data_A = environmental radiation
#terf_data_B = photon cannon charge
#terf_data_C = immune
#terf_data_D = force immune
#terf_data_F = UNASSIGNED
#terf_data_G = tool cooldown
#terf_data_H = radiation damage
#terf_data_I = absorbed radiation
#terf_data_J = body rotation
#terf_data_K = zero gravity cooldown
#terf_data_L = alarm effects
#terf_data_M = tau cannon charge
#terf_data_N = radioactive skin contamination
#terf_data_O = oxygen amount
#terf_data_P = screenshake explosion
#terf_data_Q = no oxygen damage
#terf_data_R = bleeding effect
#terf_data_S = launch reset

execute if score @s terf_data_S matches 1.. run function terf:require/launch_player/clear

#solar panel
execute if score @s terf_placed_lapis_block matches 1.. run function terf:entity/machines/solar_panel/player_trigger
execute if score @s terf_broke_lapis_block matches 1.. run function terf:entity/machines/solar_panel/player_trigger

#space movement and gravity
execute unless function terf:require/is_dimension_not_space run function terf:entity/player/in_space
execute if entity @s[tag=terf_in_space] if function terf:require/is_dimension_not_space run function terf:entity/player/not_in_space

execute if score @s terf_data_K matches 1.. run attribute @s minecraft:gravity modifier add terf:no_gravity -0.08 add_value
execute unless score @s terf_data_K matches 1.. run attribute @s minecraft:gravity modifier remove terf:no_gravity
execute if score @s terf_data_K matches 1.. run scoreboard players remove @s terf_data_K 1

attribute @s minecraft:gravity modifier remove terf:gravity_boots
execute if items entity @s armor.head *[trim~{pattern:"terf:magnetic_armor_trim"}] positioned ~ ~1 ~ rotated 0 -90 if function terf:require/is_magnetic_afront run attribute @s minecraft:gravity modifier add terf:gravity_boots -0.105 add_value
execute if items entity @s armor.feet *[trim~{pattern:"terf:magnetic_armor_trim"}] rotated 0 90 if function terf:require/is_magnetic_afront run attribute @s minecraft:gravity modifier add terf:gravity_boots 0.105 add_value
execute if items entity @s armor.chest *[trim~{pattern:"terf:magnetic_armor_trim"}] run function terf:entity/player/attract_items

tag @s remove terf_in_air
execute if entity @s[tag=terf_cant_breathe] anchored eyes if predicate terf:is_in_air run tag @s add terf_in_air

#oxygen system
execute if score @s[tag=terf_full_hazmat] terf_data_O matches 1.. run function terf:entity/player/oxygen/has_oxygen_suit_tick

execute if score @s[tag=terf_cant_breathe,tag=!terf_in_air] terf_data_C matches 0 if score enable_oxygen_system terf_states matches 1 run scoreboard players add @s terf_data_Q 1
execute if score @s terf_data_Q matches 1.. run function terf:entity/player/oxygen/has_oxygen_damage

#get radiation when in nuclear wasteland
execute if biome ~ ~ ~ terf:nuclear_wasteland run scoreboard players add @s terf_data_A 4
execute if dimension terf:intermediary_technical_storage_dimension run scoreboard players add @s terf_data_A 54321

#get radiation when close to neutrons
#scoreboard players set temp terf_states 0
#execute store result score temp terf_states run execute if entity @e[type=minecraft:marker,tag=terf_radioactive,distance=..3]
#scoreboard players operation temp terf_states *= 9 terf_states
#scoreboard players operation @s terf_data_A += temp terf_states

#detect deaths
execute if score @s terf_deaths matches 1.. run function terf:entity/player/died

#when a player joins
execute unless score @s terf_leftgame matches 0 run function terf:entity/player/joined

attribute @s minecraft:jump_strength modifier remove terf:has_zoom_slowness
attribute @s minecraft:gravity modifier remove terf:has_zoom_slowness
execute if predicate terf:has_zoom_slowness run attribute @s minecraft:jump_strength modifier add terf:has_zoom_slowness -1 add_multiplied_base
execute if predicate terf:has_zoom_slowness run attribute @s[tag=terf_in_space] minecraft:gravity modifier add terf:has_zoom_slowness 0.004 add_value

#menu
execute unless score @s terf_trigger matches 0 run function terf:entity/player/menu/clicked

#snowballs
# execute if score @s terf_snowballs_thrown matches 1.. run function terf:entity/snowball/summon

#skin contamination
execute if score @s terf_data_N matches 1.. run function terf:entity/player/has_skin_contamination

#tools
execute if score @s terf_data_C matches 1 run scoreboard players set @s terf_data_G 0
execute if score @s terf_coas_click matches 1.. anchored eyes positioned ^ ^ ^ run function terf:entity/player/tool/carrot_on_a_stick_click
execute if items entity @s weapon.* carrot_on_a_stick anchored eyes positioned ^ ^ ^ run function terf:entity/player/tool/carrot_on_a_stick_hold
execute if items entity @s weapon.* recovery_compass anchored eyes positioned ^ ^ ^ run function terf:entity/player/tool/recovery_compass_hold

execute if score @s terf_data_G matches 1.. run scoreboard players remove @s terf_data_G 1

#bleeding effect
execute if score @s terf_broke_glass_0 matches 1.. run function terf:entity/player/custom_effects/bleeding/start
execute if score @s terf_broke_glass_1 matches 1.. run function terf:entity/player/custom_effects/bleeding/start
execute if score @s terf_data_R matches 1.. run function terf:entity/player/custom_effects/bleeding/tick

#hazmat suit
tag @s remove terf_full_hazmat
scoreboard players set hazmat_pieces terf_states 0
execute if items entity @s armor.feet *[trim~{pattern:"terf:hazmat_armor_trim"}] run function datapipes_lib:require/complex_function/2 {command1:'scoreboard players add hazmat_pieces terf_states 1',command2:'scoreboard players operation @s terf_data_A /= 2 terf_states'}
execute if items entity @s armor.legs *[trim~{pattern:"terf:hazmat_armor_trim"}] run function datapipes_lib:require/complex_function/2 {command1:'scoreboard players add hazmat_pieces terf_states 1',command2:'scoreboard players operation @s terf_data_A /= 2 terf_states'}
execute if items entity @s armor.chest *[trim~{pattern:"terf:hazmat_armor_trim"}] run function datapipes_lib:require/complex_function/2 {command1:'scoreboard players add hazmat_pieces terf_states 1',command2:'scoreboard players operation @s terf_data_A /= 2 terf_states'}
execute if items entity @s armor.head *[trim~{pattern:"terf:hazmat_armor_trim"}] run function datapipes_lib:require/complex_function/2 {command1:'scoreboard players add hazmat_pieces terf_states 1',command2:'scoreboard players operation @s terf_data_A /= 4 terf_states'}
execute if score hazmat_pieces terf_states matches 4.. run tag @s add terf_full_hazmat

#radiation
execute if items entity @s container.* *[custom_data~{id:"terf:dosimeter"}] run function terf:entity/player/tool/dosimeter/sound

scoreboard players operation @s[gamemode=!spectator] terf_data_I += @s terf_data_A
scoreboard players set @s terf_data_A 0
scoreboard players operation temp terf_states = @s terf_data_I
scoreboard players operation temp terf_states /= 5000 terf_states
execute if score temp terf_states matches 1.. run scoreboard players operation @s terf_data_H += temp terf_states

execute unless score @s terf_data_C matches 1 if score @s terf_data_H matches 50000.. run function terf:entity/player/has_radiation_poisoning

#passively decrease radiation
scoreboard players operation temp terf_states = @s terf_data_I
scoreboard players operation temp terf_states /= 10000 terf_states
execute if score @s terf_data_I matches 1.. run scoreboard players operation @s terf_data_I -= temp terf_states

scoreboard players operation temp terf_states = @s terf_data_H
scoreboard players operation temp terf_states /= 10000 terf_states
scoreboard players operation @s terf_data_H -= temp terf_states

execute if score @s terf_data_H matches 1.. run scoreboard players remove @s terf_data_H 1
execute if score @s terf_data_I matches 1.. run scoreboard players remove @s terf_data_I 1

#multiblock core rotation
execute if score @s terf_usedcreeperspawnegg matches 1.. run function terf:entity/player/placed_multiblock_core

#screen shake
scoreboard players set temp terf_states 255
scoreboard players set temp2 terf_states 255
scoreboard players operation temp terf_states -= @s terf_shake_magnitude
scoreboard players operation temp2 terf_states -= @s terf_shake_frequency

execute if score @s terf_data_P matches 1.. run function terf:entity/player/screenshake_explosion

execute if score temp terf_states matches ..-1 run scoreboard players set temp terf_states 0
execute if score temp2 terf_states matches ..-1 run scoreboard players set temp2 terf_states 0

execute store result storage terf:temp args.magnitude double 0.003921568627451 run scoreboard players get temp terf_states
execute store result storage terf:temp args.frequency double 0.003921568627451 run scoreboard players get temp2 terf_states
execute store result storage terf:temp args.alarms double 0.003921568627451 run scoreboard players get @s terf_data_L
execute positioned ^ ^ ^100 run function terf:entity/player/update_screen_shake with storage terf:temp args
