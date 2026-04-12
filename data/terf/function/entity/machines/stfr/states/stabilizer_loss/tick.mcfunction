#override control panel text
data modify storage terf:temp displays.group_main[1].messages[1] set value {"text":"⚠OUTR FAIL⚠","color":"dark_red"}
data modify storage terf:temp displays.group_core[0].messages[0] set value {"text":"⚠ STB LOSS ⚠",screen_color:"orange"}

function terf:autokick

scoreboard players set stabilizer_rotation_duration terf_states 10
execute if score shield_stress terf_states matches 100.. if predicate datapipes_lib:chances/10 run particle minecraft:gust_emitter_small ~ ~ ~ 0 0 0 0 1 force
execute if score shield_stress terf_states matches 100.. if predicate datapipes_lib:chances/20 run playsound terf:braam master @a[distance=0..] ~ ~ ~ 4 0.7
particle minecraft:dust_plume ~ ~ ~ 0 0 0 0.2 1 force

execute if score @s[tag=!terf_restabilizing] terf_data_E matches ..290 run scoreboard players set shield_intensity_divided terf_states 0

scoreboard players operation core_scale terf_states = @s terf_data_E
scoreboard players operation core_scale terf_states /= 30 terf_states
scoreboard players add core_scale terf_states 100

function terf:entity/machines/stfr/visuals/core/tick
function terf:entity/machines/stfr/visuals/shield/tick
function terf:entity/machines/stfr/visuals/stabilizer/animation_tick

scoreboard players remove @s[tag=terf_restabilizing] terf_data_E 10
execute if score @s terf_data_E matches ..-1 run scoreboard players set @s terf_data_E 0
scoreboard players add @s[tag=!terf_restabilizing] terf_data_E 1
scoreboard players add @s[tag=terf_restabilizing] terf_data_Ab 1

function terf:entity/machines/stfr/calculations/extra

#netherite block colors

data modify storage terf:temp args set from entity @s data.terf
scoreboard players operation temp terf_states = @s terf_data_E
execute store result storage terf:temp args.temp int 0.3 run scoreboard players get temp terf_states
execute if score temp terf_states matches 270.. run function terf:entity/machines/stfr/states/stabilizer_loss/beam_tick with storage terf:temp args

execute if score @s terf_data_Ab matches 410 run function terf:entity/machines/stfr/states/stabilizer_loss/untransform_lasers with entity @s data.terf
execute if score @s terf_data_Ab matches 420.. run function terf:entity/machines/stfr/states/stabilizer_loss/stop with entity @s data.terf

execute as @s[tag=terf_restabilizing] run return run function terf:entity/machines/stfr/visuals/stabilizer/stabilizer_shield_beam_tick

data modify storage terf:temp args set value {arg1:'function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:"none",level:5,text:\'{"text":"Monitoring Error! CODE: x',arg3:'","color":"yellow"}\'}'}
execute store result storage terf:temp args.arg2 int 1 run random value 1000000..9999999
execute if score @s terf_data_E matches ..5 run function datapipes_lib:require/with_args/3 with storage terf:temp args

execute if score @s terf_data_E matches 4000.. run function terf:entity/machines/stfr/states/meltdown/start
execute if score @s terf_data_E matches 3960 run playsound terf:dem.metal_2 master @a[distance=0..] ~ ~ ~ 10 0.8
execute if score @s terf_data_E matches 3960 run playsound terf:dem.metal_2 master @a[distance=0..] ~ ~ ~ 10 0.8
execute if score @s terf_data_E matches 3960 run playsound terf:dem.metal_2 master @a[distance=0..] ~ ~ ~ 10 0.8
execute if score @s terf_data_E matches 3960 run playsound terf:dem.metal_2 master @a[distance=0..] ~ ~ ~ 10 0.8
execute if score @s terf_data_E matches 3960 run playsound terf:dem.metal_2 master @a[distance=0..] ~ ~ ~ 10 0.8
execute if score @s terf_data_E matches 3960 run playsound terf:dem.metal_2 master @a[distance=0..] ~ ~ ~ 10 0.8

execute unless score @s terf_data_E matches 280.. run return fail
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players operation temp terf_states %= 100 terf_states
execute if score temp terf_states matches 0 run playsound terf:dem.purge master @a[distance=0..] ~ ~ ~ 5 2

execute positioned ~10 ~ ~ run function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/40',contp:'datapipes_lib:chances/60'}
execute positioned ~-10 ~ ~ run function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/40',contp:'datapipes_lib:chances/60'}
execute positioned ~ ~10 ~ run function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/40',contp:'datapipes_lib:chances/60'}
execute positioned ~ ~-10 ~ run function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/40',contp:'datapipes_lib:chances/60'}
execute positioned ~ ~ ~10 run function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/40',contp:'datapipes_lib:chances/60'}
execute positioned ~ ~ ~-10 run function terf:require/lightning_random {max_splits:100,splitp:'datapipes_lib:chances/40',contp:'datapipes_lib:chances/60'}

data modify storage terf:temp displays.group_main[].color set value "red"
data modify storage terf:temp displays.group_main[1].messages[1] set value {"text":"⚠CONTINGENCY⚠","color":"blue"}

function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/steam_ejection

execute if score @s terf_data_E matches 300 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"Restabilization Options Found:","color":"gold"}'}
execute if score @s terf_data_E matches 301 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"- Repair At Least 3 Stabilizers, Then Confirm Restabilization Via. SSTB Before The Stabilizers Overheat."}'}

execute if score @s terf_data_E matches 1636 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.stab_loss.fail_in_2m',level:2,text:'{"text":"Estimated Time Until Stabilizer Destruction: T-2 Minutes","color":"yellow"}'}
execute if score @s terf_data_E matches 2785 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.stab_loss.fail_in_1m',level:2,text:'{"text":"Estimated Time Until Stabilizer Destruction: T-1 Minute","color":"yellow"}'}
execute if score @s terf_data_E matches 3340 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.stab_loss.fail_in_30s',level:2,text:'{"text":"Estimated Time Until Stabilizer Destruction: T-30 Seconds","color":"yellow"}'}

execute unless score @s terf_data_E matches 280 run return fail
playsound terf:charge_up.motor_rampup master @a[distance=0..] ~ ~ ~ 10 0
function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:"stfr.stab_loss.restab_options",level:1,text:'{"text":"Primary Shield Stabilization Lost! Stabilizers Are Now Operating In Contingency Mode.","color":"yellow"}'}

scoreboard players set @a[distance=..120] terf_shake_frequency 140
scoreboard players set @a[distance=..120] terf_shake_magnitude 5
function terf:entity/machines/stfr/states/stabilizer_loss/transform_rotors with entity @s data.terf
playsound minecraft:block.fire.extinguish master @a[distance=0..] ~ ~ ~ 5 0