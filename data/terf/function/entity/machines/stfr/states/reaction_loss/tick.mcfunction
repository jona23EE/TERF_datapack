#override control panel text
data modify storage terf:temp displays.group_core[0].messages[0] set value {"text":"!Shield Collapse!",screen_color:"cyan"}
data modify storage terf:temp displays.group_core[0].messages[3][1][].color set value "black"
data modify storage terf:temp displays.group_core[0].messages[3][1][1].color set value "white"

function terf:autokick

execute run scoreboard players add @s terf_data_E 1

scoreboard players operation temp terf_states = @s terf_data_T
scoreboard players operation temp terf_states %= 16 terf_states
execute if score temp terf_states matches 0 run playsound minecraft:block.bell.resonate master @a[distance=0..] ~ ~ ~ 5 0

execute if predicate datapipes_lib:chances/10 run function terf:entity/machines/stfr/case_freeze

scoreboard players add @s terf_data_V 70
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players operation temp terf_states %= 9 terf_states
execute if score temp terf_states matches 1 run scoreboard players remove @s terf_data_V 630

function terf:entity/machines/stfr/visuals/stabilizer/rotation/rotate_stabilizers with entity @s data.terf

scoreboard players operation temp terf_states = @s terf_data_T
execute if score @s terf_data_E matches 1800.. run scoreboard players operation temp terf_states %= 2 terf_states
execute unless score @s terf_data_E matches 1800.. run scoreboard players operation temp terf_states %= 10 terf_states

execute if score temp terf_states matches 0 run function terf:entity/machines/stfr/visuals/stabilizer/all_stab_rods_off
execute if score temp terf_states matches 0 run scoreboard players remove @s terf_data_W 2
execute if score temp terf_states matches 0 run execute if score @s terf_data_W matches ..-1 run scoreboard players set @s terf_data_W 4
execute if score temp terf_states matches 0 run function terf:entity/machines/stfr/visuals/stabilizer/rod_animation_step

execute if score @s terf_data_E matches 1780 run scoreboard players set @a[distance=..50] terf_shake_magnitude 10
execute if score @s terf_data_E matches 1780 run scoreboard players set @a[distance=..50] terf_shake_frequency 30
execute if score @s terf_data_E matches 1800 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.reaction_loss.instability',level:4,text:'{"text":"EXTREME CORE INSTABILITY!","color":"aqua"},{"text":" Systems Predict a High Energy Explosion In ~T-30 Seconds!","color":"dark_aqua"}'}
execute if score @s terf_data_E matches 1780.. run particle minecraft:ominous_spawning ~ ~ ~ 0 0 0 5 20 force
execute if score @s terf_data_E matches 1780.. if predicate datapipes_lib:chances/10 run playsound terf:charge_up.charge master @a[distance=0..] ~ ~ ~ 5 1
execute if score @s terf_data_E matches 1780.. if predicate datapipes_lib:chances/10 run playsound terf:explosion.rocketfly master @a[distance=0..] ~ ~ ~ 5 1

execute if score @s terf_data_E matches 20 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.reaction_loss.stabilizer_fail',level:3,text:'{"text":"Reactor Stabilizer Rotor Failure Detected! Calculating Currently Avaliable Options...","color":"aqua"}'}

execute if score @s terf_data_E matches 450 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.reaction_loss.restab_options',level:1,text:'{"text":"Action Found!","color":"aqua"}'}
execute if score @s terf_data_E matches 451 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"Glowstone blocks near the ends of the","color":"blue"}'}
execute if score @s terf_data_E matches 452 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"stabilizers have been exhausted due to","color":"blue"}'}
execute if score @s terf_data_E matches 453 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"extreme temperature conditions!","color":"blue"}'}
execute if score @s terf_data_E matches 454 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"Replace the now cold glowstone blocks","color":"dark_aqua"}'}
execute if score @s terf_data_E matches 455 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"in at least 5 stabilizers immediately!","color":"dark_aqua"}'}

execute if score @s terf_data_E matches 2705.. run function terf:entity/machines/stfr/states/underload/core_collapse

scoreboard players set core_scale terf_states 50
scoreboard players set @s terf_data_B 1200
function terf:entity/machines/stfr/visuals/shield/tick
particle minecraft:dust_color_transition{from_color:[1,1,1],to_color:[0,1,1],scale:4} ~ ~ ~ 0 0 0 0 1 force

particle minecraft:ominous_spawning ~ ~ ~ 0 0 0 2 2 force
particle minecraft:large_smoke ~ ~ ~ 0.2 0.2 0.2 0 1 force
particle minecraft:firework ~ ~ ~ 0 0 0 1 10 force
particle minecraft:sneeze ~ ~ ~ 0 0 0 0.05 1 force

execute as @s[tag=terf_stab6] run particle minecraft:snowflake ~ ~-10.5 ~ 0.7 0 0.7 0 10 force
execute as @s[tag=terf_stab5] run particle minecraft:snowflake ~-8.5 ~ ~ 0 0.7 0.7 0 10 force
execute as @s[tag=terf_stab4] run particle minecraft:snowflake ~ ~ ~-8.5 0.7 0.7 0 0 10 force
execute as @s[tag=terf_stab3] run particle minecraft:snowflake ~8.5 ~ ~ 0 0.7 0.7 0 10 force
execute as @s[tag=terf_stab2] run particle minecraft:snowflake ~ ~ ~8.5 0.7 0.7 0 0 10 force
execute as @s[tag=terf_stab1] run particle minecraft:snowflake ~ ~8.5 ~ 0.7 0 0.7 0 10 force

function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/40',contp:'datapipes_lib:chances/50'}

execute if score @s terf_data_E matches 1780.. run particle flash{color:[1,1,1,1]} ~ ~ ~ 0 0 0 0 1 force @a[tag=!terf_epilepsy_mode]

playsound minecraft:block.snow.break ambient @a[distance=0..] ~ ~ ~ 4 0
execute as @a[distance=..5] run damage @s 1 minecraft:freeze
execute positioned ~ ~-0.3 ~ as @a[distance=..3] run damage @s 7 terf:reactor

scoreboard players set stabs_fixed terf_states 0
execute as @s[tag=terf_stab1] if block ~ ~11 ~ minecraft:glowstone run scoreboard players add stabs_fixed terf_states 1
execute as @s[tag=terf_stab2] if block ~ ~ ~11 minecraft:glowstone run scoreboard players add stabs_fixed terf_states 1
execute as @s[tag=terf_stab3] if block ~11 ~ ~ minecraft:glowstone run scoreboard players add stabs_fixed terf_states 1
execute as @s[tag=terf_stab4] if block ~ ~ ~-11 minecraft:glowstone run scoreboard players add stabs_fixed terf_states 1
execute as @s[tag=terf_stab5] if block ~-11 ~ ~ minecraft:glowstone run scoreboard players add stabs_fixed terf_states 1
execute as @s[tag=terf_stab6] if block ~ ~-11 ~ minecraft:glowstone run scoreboard players add stabs_fixed terf_states 1
