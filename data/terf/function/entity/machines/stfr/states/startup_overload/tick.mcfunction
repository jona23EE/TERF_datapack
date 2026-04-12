function terf:autokick

execute as @s[tag=!terf_startup_overload_stabilizing] run scoreboard players add @s terf_data_E 1
function terf:entity/machines/stfr/calculations/tick

#process visuals
scoreboard players set stabilizer_rotation_duration terf_states 3
particle flash{color:[1,1,1,1]} ~ ~ ~ 0 0 0 0 1 force
particle minecraft:large_smoke ~ ~ ~ 0 0 0 1 10 force
scoreboard players add @s terf_data_V 250
function terf:entity/machines/stfr/visuals/core/tick
function terf:entity/machines/stfr/visuals/stabilizer/stabilizer_shield_beam_tick
function terf:entity/machines/stfr/visuals/stabilizer/stabilizer_power_beam_tick
function terf:entity/machines/stfr/visuals/stabilizer/rotation/rotate_stabilizers with entity @s data.terf

execute if predicate datapipes_lib:chances/5 run function terf:entity/machines/stfr/emergency_controls/radiation_surge/break_stab_6_rotation

execute if score @s[tag=terf_stab1] terf_data_E matches 483.. run particle minecraft:large_smoke ~ ~6 ~ 0 0 0 0.2 10 force
execute if score @s[tag=terf_stab6] terf_data_E matches 483.. run particle minecraft:large_smoke ~ ~-6 ~ 0 0 0 0.2 10 force
execute if score @s[tag=terf_stab2] terf_data_E matches 483.. run particle minecraft:large_smoke ~ ~ ~6 0 0 0 0.2 10 force
execute if score @s[tag=terf_stab4] terf_data_E matches 483.. run particle minecraft:large_smoke ~ ~ ~-6 0 0 0 0.2 10 force
execute if score @s[tag=terf_stab5] terf_data_E matches 483.. run particle minecraft:large_smoke ~-6 ~ ~ 0 0 0 0.2 10 force
execute if score @s[tag=terf_stab3] terf_data_E matches 483.. run particle minecraft:large_smoke ~6 ~ ~ 0 0 0 0.2 10 force

execute if score @s terf_data_E matches 483.. run function terf:entity/machines/stfr/visuals/stabilizer/rod_animation_step
execute if score @s terf_data_E matches 783.. run particle minecraft:flame ~ ~ ~ 2 2 2 0.1 20 force

execute if score @s terf_data_E matches 7090.. run particle minecraft:campfire_signal_smoke ~ ~ ~ 0 0 0 0.5 100 force

execute store result score temp terf_states run random value 3000..4000
data modify storage terf:temp args set value {arg1:'execute as @e[type=minecraft:item_display,tag=terf_stfr_so_beam,tag=terf_related_',arg3:'] run function terf:entity/machines/stfr/states/startup_overload/as_beam'}
data modify storage terf:temp args.arg2 set from entity @s data.terf.machine_id
execute if score @s terf_data_E matches 783.. run function datapipes_lib:require/with_args/3 with storage terf:temp args

data modify storage terf:temp args set value {arg1:"execute as @e[type=minecraft:marker,tag=terf_related_",arg3:",tag=terf_overload_beam] at @s run function terf:entity/machines/stfr/states/startup_overload/as_particle_beams"}
data modify storage terf:temp args.arg2 set from entity @s data.terf.machine_id
function datapipes_lib:require/with_args/3 with storage terf:temp args

execute if score @s terf_data_E matches 3789.. run function terf:entity/machines/stfr/states/startup_overload/summon_particle_beam

#process sounds
playsound minecraft:block.sculk.charge master @a[distance=0..] ~ ~ ~ 5 0

execute if score @s terf_data_E matches 483 run playsound terf:lightsswitch master @a[distance=0..] ~ ~ ~ 7 2
execute if score @s terf_data_E matches 483 run playsound terf:lightsswitch master @a[distance=0..] ~ ~ ~ 7 2
execute if score @s terf_data_E matches 483 run playsound terf:lightsswitch master @a[distance=0..] ~ ~ ~ 7 2

#start messages
execute if score @s terf_data_E matches 481 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.options',level:4,text:'{"text":"SHIELD CREATION FAILURE! CORE DETONATION IMMINENT!","color":"red"}'}
execute if score @s terf_data_E matches 482 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"Calculating Avaliable Options...","color":"red"}'}

#available options messages
execute if score @s terf_data_E matches 483 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"To restabilize the reactor:","color":"red"}'}
execute if score @s terf_data_E matches 484 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"Connect up at least 4 stabilizers","color":"gold"}'}
execute if score @s terf_data_E matches 485 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"to the power grid and give","color":"gold"}'}
execute if score @s terf_data_E matches 486 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"each AT LEAST 100MW","color":"gold"}'}
execute if score @s terf_data_E matches 487 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"DO NOT:","color":"yellow"}'}
execute if score @s terf_data_E matches 488 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"- connect the stabilizers that are","color":"red"}'}
execute if score @s terf_data_E matches 489 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"connected to the cooling system,","color":"red"}'}
execute if score @s terf_data_E matches 490 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"this would halt power generation.","color":"red"}'}
execute if score @s terf_data_E matches 491 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"- connect the stabilizers to the","color":"red"}'}
execute if score @s terf_data_E matches 492 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"breakers output, in the current mode the","color":"red"}'}
execute if score @s terf_data_E matches 493 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:1,text:'{"text":"stabilizers need alternating current.","color":"red"}'}

execute if score @s terf_data_E matches 793 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.output_stable',level:1,text:'{"text":"Reactor Power Output Stable, Begin Restabilization Protocol Immediately.","color":"yellow"}'}

execute if score @s terf_data_E matches 481..493 run playsound terf:alarms.notification master @a[distance=0..] ~ ~ ~ 8 2

#explosion countdown messages
execute if score @s terf_data_E matches 1390 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_5.5m',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-5.5 MINUTES \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}
execute if score @s terf_data_E matches 1990 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_5m',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-5 MINUTES \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}
execute if score @s terf_data_E matches 3040 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_4.5m',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-4.5 MINUTES \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}
execute if score @s terf_data_E matches 3640 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_4m',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-4 MINUTES \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}
execute if score @s terf_data_E matches 4690 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_3m',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-3 MINUTES \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}
execute if score @s terf_data_E matches 5290 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_2.5m',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-2.5 MINUTES \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}
execute if score @s terf_data_E matches 6340 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_60s',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-60 SECONDS \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}
execute if score @s terf_data_E matches 7090 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.startup_overload.detonation_30s',level:2,text:'{"text":"\\u26a0\\u26a0\\u26a0 REACTOR DETONATION IN T-30 SECONDS \\u26a0\\u26a0\\u26a0","color":"dark_red"}'}

#inner workings
execute if score @s terf_data_E matches 3789 run function terf:entity/machines/stfr/case_explosion
#execute if score @s terf_data_E matches 5270.. run scoreboard players set @s terf_data_O 436734868

execute if score @s terf_data_E matches 783.. run scoreboard players set @s terf_data_P 101500000
execute if score @s terf_data_E matches 8040.. run function terf:entity/machines/stfr/states/meltdown/start

execute if score NETratetimer terf_states >= NETrate terf_states as @s[tag=!terf_startup_overload_stabilizing] run function terf:entity/machines/stfr/states/startup_overload/slower_tick

data modify storage terf:temp args set value {arg1:'execute as @e[type=minecraft:item_display,tag=terf_stfr_so_beam,tag=terf_related_',arg3:'] run function terf:entity/machines/stfr/states/startup_overload/as_beam_calm'}
data modify storage terf:temp args.arg2 set from entity @s data.terf.machine_id
execute if score @s[tag=terf_startup_overload_stabilizing] terf_data_U matches 500.. run function datapipes_lib:require/with_args/3 with storage terf:temp args

execute if score @s[tag=terf_startup_overload_stabilizing] terf_data_U matches 600.. run function terf:entity/machines/stfr/states/startup_overload/restabilize
