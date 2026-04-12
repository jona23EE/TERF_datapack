#process logistics
execute if score @s terf_data_E matches 380.. run function terf:entity/machines/stfr/calculations/tick

execute as @s run scoreboard players add @s terf_data_E 1

scoreboard players operation temp terf_states = @s terf_data_T
scoreboard players operation temp terf_states %= 16 terf_states
execute if score temp terf_states matches 0 if score @s terf_data_E matches ..380 run playsound minecraft:block.bell.resonate ambient @a[distance=0..] ~ ~ ~ 5 0

scoreboard players add @s terf_data_V 150
function terf:entity/machines/stfr/visuals/stabilizer/rotation/rotate_stabilizers with entity @s data.terf
function terf:entity/machines/stfr/visuals/stabilizer/animation_tick

scoreboard players set core_scale terf_states 50

scoreboard players set @s terf_data_B 1200
execute if score @s terf_data_E matches ..380 run function terf:entity/machines/stfr/visuals/shield/tick

particle minecraft:dust_color_transition{from_color:[1,1,1],to_color:[0,1,1],scale:4} ~ ~ ~ 0 0 0 0 1 force

execute if score @s terf_data_E matches 380.. run function terf:entity/machines/stfr/states/online/tick

execute if score @s terf_data_E matches 280 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.reaction_loss.restab_firing',level:2,text:'{"text":"Firing Power And Stabilization Lasers at 5.000.000% To Re-Stabilize Reactor Core. ","color":"gold"},{"text":"Brace For Impact!","color":"red"}'}

execute if score @s terf_data_E matches ..380 run particle minecraft:ominous_spawning ~ ~ ~ 0 0 0 2 2 force
execute if score @s terf_data_E matches ..380 run particle minecraft:large_smoke ~ ~ ~ 0.2 0.2 0.2 0 1 force
execute if score @s terf_data_E matches ..380 run particle minecraft:firework ~ ~ ~ 0 0 0 1 10 force
execute if score @s terf_data_E matches ..380 run particle minecraft:sneeze ~ ~ ~ 0 0 0 0.05 1 force

execute if score @s terf_data_E matches 380 run function terf:entity/machines/stfr/states/reaction_loss/reignite

execute if score @s terf_data_E matches ..80 as @s[tag=terf_stab6] run particle minecraft:snowflake ~ ~-10.5 ~ 0.7 0 0.7 0 10 force
execute if score @s terf_data_E matches ..80 as @s[tag=terf_stab5] run particle minecraft:snowflake ~-8.5 ~ ~ 0 0.7 0.7 0 10 force
execute if score @s terf_data_E matches ..80 as @s[tag=terf_stab4] run particle minecraft:snowflake ~ ~ ~-7.5 0.7 0.7 0 0 10 force
execute if score @s terf_data_E matches ..80 as @s[tag=terf_stab3] run particle minecraft:snowflake ~7.5 ~ ~ 0 0.7 0.7 0 10 force
execute if score @s terf_data_E matches ..80 as @s[tag=terf_stab2] run particle minecraft:snowflake ~ ~ ~7.5 0.7 0.7 0 0 10 force
execute if score @s terf_data_E matches ..80 as @s[tag=terf_stab1] run particle minecraft:snowflake ~ ~8.5 ~ 0.7 0 0.7 0 10 force

execute if score @s terf_data_E matches ..380 run particle flash{color:[1,1,1,1]} ~ ~ ~ 0 0 0 0 1 force

execute if score @s terf_data_E matches 1000.. run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.reaction_loss.restab_complete',level:1,text:'{"text":"Fusion Reactor Re-Ignition Protocol Completed!","color":"green"}'}
execute if score @s terf_data_E matches 1000.. run scoreboard players set @s terf_data_A 3

execute if score @s terf_data_E matches ..380 run playsound minecraft:block.snow.break ambient @a[distance=0..] ~ ~ ~ 4 0
execute if score @s terf_data_E matches ..380 as @a[distance=..5] run damage @s 1 minecraft:freeze

execute if score @s terf_data_E matches 80 run scoreboard players set @s terf_data_U 299

tag @s remove terf_core_starting_alarm
