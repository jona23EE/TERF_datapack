function terf:entity/machines/stfr/calculations/tick

#override control panel text
data modify storage terf:temp displays.group_main[1].messages[1] set value {"text":"normal","color":"green"}
data modify storage terf:temp displays.group_core[0].messages[0] set value {"text":"Shutdown Fail",screen_color:"magenta"}
execute if score @s terf_data_E matches 2550.. run data modify storage terf:temp displays.group_main[].color set value "red"
execute if score @s terf_data_E matches 2550.. run data modify storage terf:temp displays.structure[].color set value "red"
data modify storage terf:temp displays.group_core[0].messages[3][1][].color set value "white"

execute if score @s terf_data_E matches 3070.. if predicate datapipes_lib:chances/20 run data modify storage terf:temp displays.group_main[13].messages[2][1] set value {text:"T: - °kC"}
execute if score @s terf_data_E matches 3130.. run data modify storage terf:temp displays.group_main[13].messages[2][0].color set value "yellow"
execute if score @s terf_data_E matches 3130.. run data modify storage terf:temp displays.group_main[13].messages[2][1] set value {text:"Err",color:"#FF0000"}

scoreboard players operation e_digit_1 terf_states = @s terf_data_Af
scoreboard players operation e_digit_2 terf_states = e_digit_1 terf_states
scoreboard players operation e_digit_3 terf_states = e_digit_1 terf_states
scoreboard players operation e_digit_4 terf_states = e_digit_1 terf_states
scoreboard players operation e_digit_5 terf_states = e_digit_1 terf_states

scoreboard players operation e_digit_1 terf_states /= 10000 terf_states
scoreboard players operation e_digit_2 terf_states /= 1000 terf_states
scoreboard players operation e_digit_3 terf_states /= 100 terf_states
scoreboard players operation e_digit_4 terf_states /= 10 terf_states

scoreboard players operation e_digit_2 terf_states %= 10 terf_states
scoreboard players operation e_digit_3 terf_states %= 10 terf_states
scoreboard players operation e_digit_4 terf_states %= 10 terf_states
scoreboard players operation e_digit_5 terf_states %= 10 terf_states

execute if entity @s[tag=terf_core_online] if score @s terf_data_E matches 3200.. run data modify storage terf:temp displays.group_main[13].messages[2] set value [{text:"T:",color:"yellow"},{"score":{"name":"e_digit_2","objective":"terf_states"}},".",{"score":{"name":"e_digit_3","objective":"terf_states"}},{"score":{"name":"e_digit_4","objective":"terf_states"}},{"score":{"name":"e_digit_5","objective":"terf_states"}},"E",{"score":{"name":"e_digit_1","objective":"terf_states"}},"°kC"]

#decrease core scale
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players remove temp terf_states 1100
scoreboard players operation temp terf_states /= 50 terf_states
scoreboard players set core_scale terf_states 100
execute if score temp terf_states matches 1.. run scoreboard players operation core_scale terf_states -= temp terf_states

#process visuals for this state
execute if score @s terf_data_E matches ..4050 if score @s terf_data_Ab matches ..695 run function terf:entity/machines/stfr/visuals/core/tick
scoreboard players set terminated terf_states 20
execute if score @s terf_data_E matches 1300..4050 if score @s terf_data_Ab matches ..990 positioned ~ ~.2 ~ run function terf:entity/machines/stfr/states/shutdown_failure/unstable_shield/iterate
execute if score @s terf_data_E matches ..1300 run function terf:entity/machines/stfr/visuals/shield/tick
execute if score @s terf_data_E matches 300.. run scoreboard players add @s terf_data_B 10

scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players operation temp terf_states %= 100 terf_states
execute if score @s terf_data_E matches ..2549 if score temp terf_states matches 0 run function terf:entity/machines/stfr/visuals/stabilizer/all_stab_rods_on
execute if score @s terf_data_E matches ..2549 if score temp terf_states matches 50 run function terf:entity/machines/stfr/visuals/stabilizer/all_stab_rods_off

execute if score @s terf_data_E matches 2550.. run function terf:entity/machines/stfr/visuals/stabilizer/rod_animation_step

execute if score @s terf_data_E matches ..4050 if score @s terf_data_Ab matches ..990 run function terf:entity/machines/stfr/visuals/stabilizer/stabilizer_shield_beam_tick
execute if score @s terf_data_E matches ..4050 if score @s terf_data_Ab matches ..675 run function terf:entity/machines/stfr/visuals/stabilizer/stabilizer_power_beam_tick
function terf:entity/machines/stfr/visuals/stabilizer/rotation/rotate_stabilizers with entity @s data.terf

#stabilizer rotation speed control
scoreboard players operation speed terf_states = @s terf_data_E
scoreboard players remove speed terf_states 300
execute if score speed terf_states matches 200.. run scoreboard players set speed terf_states 200
execute if score speed terf_states matches ..-1 run scoreboard players set speed terf_states 0
scoreboard players add speed terf_states 100

#speed up during restab
scoreboard players operation temp terf_states = @s terf_data_Ab
scoreboard players remove temp terf_states 400
scoreboard players operation temp terf_states *= 2 terf_states
execute if score temp terf_states matches 401.. run scoreboard players set temp terf_states 400
execute if score temp terf_states matches 1.. run scoreboard players operation speed terf_states += temp terf_states

#slow down during restab
scoreboard players operation temp terf_states = @s terf_data_Ab
scoreboard players remove temp terf_states 990
scoreboard players operation temp terf_states *= 2 terf_states
execute if score temp terf_states matches 1.. run scoreboard players operation speed terf_states -= temp terf_states

execute unless score @s terf_data_E matches 4050.. if score speed terf_states matches 1.. run scoreboard players operation @s terf_data_V += speed terf_states

execute if score @s terf_data_E matches 300..350 run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/steam_ejection
execute if score @s terf_data_E matches 2550..2650 run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/steam_ejection

execute if score @s terf_data_E matches 300.. if score @s terf_data_Ab matches ..695 run particle flash{color:[1,1,1,1]} ~ ~ ~ 1 1 1 0 3 force
execute if score @s terf_data_E matches 300 run scoreboard players set @a[distance=..80] terf_shake_magnitude 5
execute if score @s terf_data_E matches 300 run scoreboard players set @a[distance=..80] terf_shake_frequency 150
execute if score @s terf_data_E matches 300 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.projection',level:1,text:'{"text":"Increasing Shield Projection To Prevent Collapse From Low Internal Pressure Forces!"}'}
execute if score @s terf_data_E matches 600 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.ineffective',level:2,text:'{"text":"Automatic Shutdown Ineffective! ","color":"red"},{"text":"Manual Intervention Required.","color":"gold"}'}

execute if score @s terf_data_E matches 750 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.restab_options',level:1,text:'{"text":"Re-stabilization Options Found:","color":"gold"}'}
execute if score @s terf_data_E matches 751 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"- Stasis Laser Activation"}'}
execute if score @s terf_data_E matches 752 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"- Replace All Fuel Capsules With Water Containing"}'}
execute if score @s terf_data_E matches 753 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'none',level:0,text:'{"text":"Capsules For A Full Core Content Purge"}'}
 
#open stabilizer maintenance trapdoors
execute if score @s terf_data_E matches 760 run function terf:entity/machines/stfr/stab_transform/open_trapdoors/stab_s with entity @s data.terf
execute if score @s terf_data_E matches 770 run function terf:entity/machines/stfr/stab_transform/open_trapdoors/stab_e with entity @s data.terf
execute if score @s terf_data_E matches 785 run function terf:entity/machines/stfr/stab_transform/open_trapdoors/stab_n with entity @s data.terf
execute if score @s terf_data_E matches 780 run function terf:entity/machines/stfr/stab_transform/open_trapdoors/stab_w with entity @s data.terf

execute if score @s terf_data_E matches 1200 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.diameter',level:1,text:'{"text":"Core Diameter Decreasing Due To Extreme Shield Densities! ","color":"red"},{"text":"Core Spin Levels Rising Exponentially!","color":"gold"}'}

#reverse shield permeability aka air gets sucked into the core due to quantum tunneling from the extreme shield density
scoreboard players operation amount terf_states = @s terf_data_E
scoreboard players remove amount terf_states 1300
scoreboard players operation terminated terf_states = amount terf_states

execute if score temp terf_states matches 1.. run scoreboard players operation @s terf_data_N += amount terf_states

execute if score @s terf_data_E matches 1300.. if score @s terf_data_Ab matches ..990 run function terf:entity/machines/stfr/calculations/inject_fuel {id:"terf.iair_pro_max"}

scoreboard players operation terminated terf_states /= 10 terf_states
execute if score terminated terf_states matches 101.. run scoreboard players set terminated terf_states 100
execute if score terminated terf_states matches 1.. if score @s terf_data_E matches ..4050 if score @s terf_data_Ab matches ..695 run function terf:entity/machines/stfr/states/shutdown_failure/suck_particles/iterate

execute if score @s terf_data_E matches 1350 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.permeability',level:1,text:'{"text":"Shield Reverse-Permeability Alert!","color":"red"}'}

execute if score @s terf_data_E matches 1550 run function terf:entity/machines/stfr/states/shutdown_failure/case_implosion

execute if score @s terf_data_E matches 1650 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.foreign',level:1,text:'{"text":"Foreign Material Detected Within Reactor Core! ","color":"red"},{"text":"Systems May Not Behave As Expected!","color":"gold"}'}


execute if score @s terf_data_E matches 1950 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.pressure',level:2,text:'{"text":"Detecting Extreme Core Pressure Buildup! ","color":"red"},{"text":"All Personnel Are To Attempt Re-stabilization Immediately.","color":"gold"}'}

#reactivity rise aka temperature rise
execute if score @s terf_data_E matches 2250.. run scoreboard players add @s terf_data_Af 69
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players remove temp terf_states 2200

execute if score temp terf_states matches 1..255 as @e[tag=terf_shutdown_failure_glow] store result entity @s text_opacity int 1 run scoreboard players get temp terf_states
execute as @e[type=text_display,tag=terf_shutdown_failure_glow,distance=..1] at @s run function terf:entity/machines/stfr/states/shutdown_failure/rotate_text_display
execute if score @s terf_data_E matches 2550 as @e[type=text_display,tag=terf_shutdown_failure_glow,distance=..1] run data modify entity @s transformation.scale set value [.1f,.1f,.1f]

scoreboard players operation temp terf_states *= 2000 terf_states
execute if score temp terf_states matches 1.. run scoreboard players operation @s terf_data_M += temp terf_states
execute if score @s terf_data_M matches ..-1000000 run scoreboard players set @s terf_data_M 2147483647
execute if score @s terf_data_N matches ..-1000000 run scoreboard players set @s terf_data_N 2147483647

execute if score @s terf_data_E matches 2250 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.reactivity',level:2,text:'{"text":"Unknown Reactivity Rise Detected! Analysis pending...","color":"gold"}'}

execute if score @s terf_data_E matches 2550 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.fusion',level:2,text:'{"text":"Fusion Of A New Element Detected! Reconfiguring Systems... Details: ","color":"red"},{"text":"Details: p+Num:8","color":"gold"}'}
execute if score @s terf_data_E matches 2550 run scoreboard players set @a[distance=..80] terf_shake_frequency 300
execute if score @s terf_data_E matches 2850 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.setpoint',level:2,text:'{"text":"Automatic Shield Permeability Setpoint Unreachable Before A Containment Loss Event Occurs! ","color":"red"},{"text":"Awaiting Intervention...","color":"gold"}'}

execute if score @s terf_data_E matches 3150 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.temp_fail',level:1,text:'{"text":"Unable To Monitor Reactor Core Temperature! Switching To Approximation Via. Photon Spectrometers.","color":"red"}'}

execute if score @s terf_data_E matches 4050 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.monitoring_fail',level:3,text:'{"text":"Total Monitoring Failure! Analyzing previous stats...","color":"red"}'}
execute if score @s terf_data_E matches 4050 run tag @s remove terf_core_online
execute if score @s terf_data_E matches 4050 as @e[distance=..1,tag=terf_stfr_shutdown_fail_flare] run data modify entity @s text_opacity set value 128

execute if score @s terf_data_E matches 4050.. run particle end_rod ~ ~ ~ 0.3 0.3 0.3 0 100 force
execute if score @s terf_data_E matches 4050.. run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/smoke

execute if score @s terf_data_E matches 4650 run function terf:entity/machines/stfr/states/shutdown_failure/shield_blast
execute if score @s terf_data_E matches 4650.. run data modify storage terf:temp displays.group_core[0].messages[3][1][-2].color set value "red"
scoreboard players set terminated terf_states 10

#"orbital" particles
execute if score @s terf_data_E matches 4050 run function terf:entity/machines/stfr/states/shutdown_failure/shield_blast
execute if score @s terf_data_E matches 4050.. run data modify storage terf:temp displays.group_core[0].messages[3][1][-1].color set value "red"
execute if score @s terf_data_E matches 4050 run scoreboard players set @a[distance=..80] terf_shake_frequency 200
execute if score @s terf_data_E matches 4050 run scoreboard players set @a[distance=..80] terf_shake_magnitude 10
execute if score @s terf_data_E matches 4050.. run function terf:entity/machines/stfr/states/shutdown_failure/orbit/summon with entity @s data.terf
$execute if score @s terf_data_E matches 4050.. as @e[type=marker,tag=terf_shutdown_fail_orbit,tag=terf_related_$(machine_id)] at @s run function terf:entity/machines/stfr/states/shutdown_failure/orbit/tick

execute if score @s[tag=terf_stab3] terf_data_E matches 4050.. if predicate datapipes_lib:chances/0.1 positioned ~11 ~ ~ run function terf:entity/machines/stfr/explode_stabilizer
execute if score @s[tag=terf_stab5] terf_data_E matches 4050.. if predicate datapipes_lib:chances/0.1 positioned ~-11 ~ ~ run function terf:entity/machines/stfr/explode_stabilizer
execute if score @s[tag=terf_stab1] terf_data_E matches 4050.. if predicate datapipes_lib:chances/0.1 positioned ~ ~11 ~ run function terf:entity/machines/stfr/explode_stabilizer
execute if score @s[tag=terf_stab6] terf_data_E matches 4050.. if predicate datapipes_lib:chances/0.1 positioned ~ ~-11 ~ run function terf:entity/machines/stfr/explode_stabilizer
execute if score @s[tag=terf_stab2] terf_data_E matches 4050.. if predicate datapipes_lib:chances/0.1 positioned ~ ~ ~11 run function terf:entity/machines/stfr/explode_stabilizer
execute if score @s[tag=terf_stab4] terf_data_E matches 4050.. if predicate datapipes_lib:chances/0.1 positioned ~ ~ ~-11 run function terf:entity/machines/stfr/explode_stabilizer

execute if score @s terf_data_E matches 4350 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.instability',level:4,text:'{"text":"Extreme Shield Instability! Systems Predict A Complete Containment Failure In T-30 Seconds!","color":"red"}'}

#rays
execute if score @s terf_data_E matches 4640.. summon item_display run function terf:entity/machines/stfr/states/shutdown_failure/rays/summon
execute as @e[type=minecraft:item_display,tag=terf_stfr_ray] at @s run function terf:entity/machines/stfr/states/shutdown_failure/rays/tick
execute if score @s terf_data_E matches 4950.. as @e[type=minecraft:item_display,tag=terf_stfr_ray,distance=..1] at @s run rotate @s ~1 ~-1

execute if score @s terf_data_E matches 4950 run function terf:entity/machines/stfr/states/shutdown_failure/shield_blast
execute if score @s terf_data_E matches 4950.. run data modify storage terf:temp displays.group_core[0].messages[3][1][-3].color set value "red"
execute if score @s terf_data_E matches 4950 run function terf:entity/machines/mainframe/crash_connected_mainframe
execute if score @s terf_data_E matches 4950 run scoreboard players set @a[distance=..80] terf_shake_frequency 100
execute if score @s terf_data_E matches 4950 run scoreboard players set @a[distance=..80] terf_shake_magnitude 30
scoreboard players set terminated terf_states 10
data modify storage terf:temp args set from entity @s data.terf
data modify storage terf:temp args.max_duration set value 20
execute if score @s terf_data_E matches 4950.. summon text_display run function terf:entity/machines/stfr/states/meltdown/dust/summon with storage terf:temp args
execute if score @s terf_data_E matches 4950.. run particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 1 1 force
execute if score @s terf_data_E matches 4950.. run particle minecraft:firework ~ ~ ~ 0 0 0 1 100 force
$execute if score @s terf_data_E matches 4950.. as @e[type=text_display,tag=terf_stfr_meltdown_dust,tag=terf_related_$(machine_id)] at @s run function terf:entity/machines/stfr/states/meltdown/dust/as

execute if score @s terf_data_E matches 5150 run function terf:require/run_n_times {n:20,command:'playsound terf:charge_up.heavy_startup master @a[distance=0..] ~ ~ ~ 10 2'}
scoreboard players set terminated terf_states 50
execute if score @s terf_data_E matches 5150 run function terf:entity/machines/stfr/states/overload/shield_explosion_beams/iterate
execute if score @s terf_data_E matches 5200 run function terf:entity/machines/stfr/states/overload/shield_explosion_beams/iterate
execute if score @s terf_data_E matches 5250 run function terf:entity/machines/stfr/states/overload/shield_explosion_beams/iterate
execute if score @s terf_data_E matches 5300 run function terf:entity/machines/stfr/states/detonation/detonate_reactor
#4650: anomaly starts glowing
#4950: anomaly collapses, particles swirl
#5250: explosion

#restabilization, or not
execute if score @s terf_data_Ab matches -1 run return run scoreboard players add @s terf_data_E 1
scoreboard players add @s terf_data_Ab 1

execute if score @s terf_data_Ab matches 100 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.restab_inject',level:0,text:'{"text":"Injecting Coolant Into Reactor Core To Reduce Stabilizer Backpressure..."}'}

execute if score @s terf_data_Ab matches 395 run scoreboard players set @s terf_data_U 299
execute if score @s terf_data_Ab matches 395 run tag @s add terf_stfr_surge_unabortable
execute if score @s terf_data_Ab matches 400 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.shut_fail.restab_overdrive',level:2,text:'{"text":"Overdriving Fuel Channel Fields For The Venting Of Core Contents! ","color":"gold"},{"text":"Stabilizer Damage Will Occur.","color":"red"}'}
execute if score @s terf_data_Ab matches 400 run scoreboard players add @a[distance=..256] terf_data_P 20
execute if score @s terf_data_Ab matches 400..675 run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/steam_ejection
execute if score @s terf_data_Ab matches 675..990 run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/flame

execute if score @s terf_data_Ab matches 695 run function terf:entity/machines/stfr/states/shutdown_failure/restabilization_activate with entity @s data.terf

#stabilizer leak shader
scoreboard players set a terf_states 0
scoreboard players set b terf_states 0

scoreboard players operation r terf_states = @s terf_data_Ab
scoreboard players remove r terf_states 694
execute if score r terf_states matches 256.. run scoreboard players set r terf_states 255

scoreboard players operation g terf_states = @s terf_data_Ab
scoreboard players remove g terf_states 694
scoreboard players operation g terf_states *= 2 terf_states
scoreboard players add g terf_states 60
execute if score g terf_states matches 256.. run scoreboard players set g terf_states 255

scoreboard players operation temp terf_states = @s terf_data_Ab
scoreboard players remove temp terf_states 990
scoreboard players operation temp terf_states *= 4 terf_states
execute if score temp terf_states matches 1.. run scoreboard players operation g terf_states -= temp terf_states

execute if score g terf_states matches ..-1 run scoreboard players set g terf_states 0

function terf:require/argb_to_int
$execute as @e[type=minecraft:item_display,tag=terf_related_$(machine_id),tag=terf_stfr_shutdown_fail_leak] run function terf:entity/machines/stfr/states/shutdown_failure/as_leaks

#execute if score @s terf_data_Ab matches 695..990 run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/steam_vent
execute if score @s terf_data_Ab matches 695..970 run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/plasma_vent
execute if score @s terf_data_Ab matches 695..990 run playsound entity.player.breath master @a[distance=0..] ~ ~ ~ 10 0.5
execute if score @s terf_data_Ab matches 695..990 run playsound entity.player.breath master @a[distance=0..] ~ ~ ~ 10 0.6
execute if score @s terf_data_Ab matches 695..990 run particle flash{color:[1,1,1,1]} ~ ~ ~ 0 0 0 0 10 force

execute if score @s terf_data_Ab matches 990 run function terf:entity/machines/stfr/states/shutdown_failure/restabilize with entity @s data.terf
execute if score @s terf_data_Ab matches 990.. run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/smoke
execute if score @s terf_data_Ab matches 990.. if predicate datapipes_lib:chances/10 as @a[distance=..256] if score @s terf_shake_magnitude matches 1.. run scoreboard players remove @s terf_shake_magnitude 1

#make stabilizer rotation end up aligned to blocks
execute if score @s terf_data_Ab matches 695 run scoreboard players set @s terf_data_V 0
execute if score @s terf_data_Ab matches 695.. if score speed terf_states matches ..30 if score @s terf_data_V matches ..337721 run scoreboard players add @s terf_data_V 30
execute if score @s terf_data_Ab matches 695.. if score @s terf_data_V matches 337721.. run scoreboard players set @s terf_data_V 337720

#explode receptacles
scoreboard players set succeeded terf_states 0
execute if score @s terf_data_Ab matches 800 run scoreboard players set succeeded terf_states 1
execute if score @s terf_data_Ab matches 855 run scoreboard players set succeeded terf_states 1
execute if score @s terf_data_Ab matches 870 run scoreboard players set succeeded terf_states 1
execute if score @s terf_data_Ab matches 920 run scoreboard players set succeeded terf_states 1
execute if score @s terf_data_Ab matches 940 run scoreboard players set succeeded terf_states 1
execute if score @s terf_data_Ab matches 950 run scoreboard players set succeeded terf_states 1
$execute if score succeeded terf_states matches 1 as @e[type=minecraft:interaction,tag=terf_related_$(machine_id),tag=terf_receptacle,sort=random,limit=1] at @s run function terf:entity/machines/stfr/states/shutdown_failure/explode_receptacle with entity @s data.terf

execute if score @s terf_data_Ab matches 1200 run function terf:entity/machines/stfr/states/shutdown_failure/restabilization_end with entity @s data.terf

execute if score @s terf_data_Ab matches 1400 run function terf:entity/machines/stfr/stabilizers_off
execute if score @s terf_data_Ab matches 1500.. run function terf:entity/machines/multiblock_core_kill

#panel glitch effect
execute if score @s terf_data_Ab matches ..695 run return fail
execute if score @s terf_data_Ab matches 991.. run return run scoreboard players reset @s terf_connected_mainframe

data modify storage terf:temp displays.structure[].messages[] set value {text:"O",obfuscated:1b,color:black}
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch
function terf:entity/machines/stfr/states/shutdown_failure/panel_glitch

execute unless score @s terf_data_Ab matches 990 run return fail
data modify storage terf:temp displays.structure[].messages[] set value {text:""}
data modify storage terf:temp displays.group_core[].messages[] set value {text:""}
data modify storage terf:temp displays.group_main[].messages[] set value {text:""}
function terf:entity/machines/mainframe/crash_connected_mainframe

#100: inject
#400: start
#695: mid
#990: end