scoreboard players add @s terf_data_E 1
execute if score @s terf_data_E matches 860.. run function terf:entity/machines/stfr/states/online/tick

#override control panel text
data modify storage terf:temp displays.group_core[0].messages[0] set value {"text":". Starting .",screen_color:"yellow"}

#close stabilizer maintenance trapdoors
execute if score @s terf_data_E matches 50 run function terf:entity/machines/stfr/stab_transform/close_trapdoors/stab_s with entity @s data.terf
execute if score @s terf_data_E matches 80 run function terf:entity/machines/stfr/stab_transform/close_trapdoors/stab_e with entity @s data.terf
execute if score @s terf_data_E matches 65 run function terf:entity/machines/stfr/stab_transform/close_trapdoors/stab_n with entity @s data.terf
execute if score @s terf_data_E matches 75 run function terf:entity/machines/stfr/stab_transform/close_trapdoors/stab_w with entity @s data.terf

#automatic abortion system
#execute if score @s terf_data_E matches 29 run function terf:entity/machines/stfr/states/startup_confirmed/abort_no_fuel
execute if score @s terf_data_E matches 29..822 if score working_stabs terf_states matches 0 run function terf:entity/machines/stfr/states/startup_confirmed/abort_no_stabilizers

#keep breakers on until 1000
execute if score @s terf_data_E matches ..1000 run tag @s add terf_breaker_interested

#stabilizer rod animation
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players operation temp terf_states %= 50 terf_states
execute if score @s terf_data_E matches ..300 if score temp terf_states matches 25 run function terf:entity/machines/stfr/visuals/stabilizer/all_stab_rods_on
execute if score @s terf_data_E matches ..300 if score temp terf_states matches 0 run function terf:entity/machines/stfr/visuals/stabilizer/all_stab_rods_off

execute if score @s terf_data_E matches 295.. run function terf:entity/machines/stfr/visuals/stabilizer/animation_tick

#system startup sounds
execute if score @s terf_data_E matches 30 run playsound terf:charge_up.corestartup ambient @a[distance=0..] ~ ~ ~ 3
execute if score @s terf_data_E matches 30 run playsound terf:charge_up.corestartup ambient @a[distance=0..] ~ ~ ~ 3
execute if score @s terf_data_E matches 30 run playsound terf:charge_up.corestartup ambient @a[distance=0..] ~ ~ ~ 3
execute if score @s terf_data_E matches 30 run playsound terf:charge_up.corestartup ambient @a[distance=0..] ~ ~ ~ 3
execute if score @s terf_data_E matches 30 run playsound terf:charge_up.corestartup ambient @a[distance=0..] ~ ~ ~ 3
execute if score @s terf_data_E matches 30 run playsound terf:charge_up.heavy_startup ambient @a[distance=0..] ~ ~ ~ 4 1
execute if score @s terf_data_E matches 30 run playsound terf:charge_up.heavy_startup ambient @a[distance=0..] ~ ~ ~ 4 1
execute if score @s terf_data_E matches 100.. run function terf:entity/machines/stfr/sound/system_noise_tick

#start spinning stabilizers
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players remove temp terf_states 200
scoreboard players operation temp terf_states /= 2 terf_states
execute if score temp terf_states matches ..-1 run scoreboard players set temp terf_states 0
execute if score temp terf_states matches 101.. run scoreboard players set temp terf_states 100
scoreboard players operation @s terf_data_V += temp terf_states
execute if score @s terf_data_E matches 200..210 run function terf:entity/machines/stfr/visuals/stabilizer/rotor_particles/steam_ejection

#spin stabilizers faster before firing power lasers
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players remove temp terf_states 763
scoreboard players operation temp terf_states *= 3 terf_states
execute if score temp terf_states matches ..-1 run scoreboard players set temp terf_states 0
execute if score temp terf_states matches 201.. run scoreboard players set temp terf_states 200
scoreboard players operation @s terf_data_V += temp terf_states
execute if score @s terf_data_E matches 763 run playsound terf:charge_up.motor_rampup ambient @a[distance=0..] ~ ~ ~ 4 1

#slow it down after
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players remove temp terf_states 860
scoreboard players operation temp terf_states *= 3 terf_states
execute if score temp terf_states matches ..-1 run scoreboard players set temp terf_states 0
execute if score temp terf_states matches 201.. run scoreboard players set temp terf_states 200
scoreboard players operation @s terf_data_V -= temp terf_states

function terf:entity/machines/stfr/visuals/stabilizer/rotation/rotate_stabilizers with entity @s data.terf

execute if score @s terf_data_E matches 295 if score working_systems terf_states matches 10 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.starting.systemson',level:0,text:'{"text":"Reactor Systems Online! No Errors Detected"}'}
execute if score @s terf_data_E matches 295 unless score working_systems terf_states matches 10 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.starting.systemserror',level:0,text:'{"text":"Reactor Systems Online! "},{"text":"Some Systems May Require Maintenance","color":"gold"}'}

#form shield
execute if score @s terf_data_E matches 375..504 run data modify storage terf:temp displays.group_main[1].messages[1] set value {text:"creating shield",color:dark_green}
execute if score @s terf_data_E matches 585.. run data modify storage terf:temp displays.group_main[1].messages[1] set value {text:"normal","color":"green"}
execute if score @s terf_data_E matches 395..584 run data modify storage terf:temp displays.group_core[0].messages[3][1][].color set value "yellow"
execute if score @s terf_data_E matches 505.. run data modify storage terf:temp displays.group_core[0].messages[3][1][].color set value "white"

execute if score @s terf_data_E matches 350 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.starting.shield',level:0,text:'{"text":"Forming Reactor Core Shield..."}'}
execute if score @s terf_data_E matches 375.. run function terf:entity/machines/stfr/visuals/stabilizer/stabilizer_shield_beam_tick
execute if score @s terf_data_E matches 545.. if score @s terf_data_B matches ..9999 run scoreboard players add @s terf_data_B 100
execute if score @s terf_data_E matches 395..545 run playsound minecraft:block.sand.break ambient @a[distance=0..] ~ ~ ~ 3 0
execute if score @s terf_data_E matches 365..545 run particle minecraft:gust ~ ~.2 ~ 0 0 0 0 1 force
execute if score @s terf_data_E matches 415.. run function terf:entity/machines/stfr/visuals/shield/tick
execute if score @s terf_data_E matches 540 run particle minecraft:gust_emitter_small

execute if score @s terf_data_E matches 395..545 run scoreboard players set shieldstatus terf_states 1
execute if score @s terf_data_E matches 546.. run scoreboard players set shieldstatus terf_states 2

#inject fuel
scoreboard players set injection_multiplier terf_states 100
scoreboard players operation injection_multiplier terf_states *= 24 terf_states
execute if score @s terf_data_E matches 615..756 run data modify storage terf:temp array set from entity @s data.terf.injection_list
execute if score @s terf_data_E matches 615..756 run function terf:entity/machines/stfr/calculations/iterate_injection_list with storage terf:temp array[0]

execute if score @s terf_data_E matches 585 run tag @s add terf_core_online
execute if score @s terf_data_E matches 585 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.starting.injecting',level:0,text:'{"text":"Reactor Shield Formed! Injecting Fuel Into Reactor Core..."}'}
execute if score @s terf_data_E matches 615..832 run particle minecraft:dust{color:[0.1,0.0,0.3],scale:1} ~ ~ ~ 0.3 0.3 0.3 0 10 force
execute if score @s terf_data_E matches 615..756 run function terf:entity/machines/stfr/visuals/stabilizer/stabilizer_power_beam_tick
execute if score @s terf_data_E matches 615..756 run playsound minecraft:block.fire.extinguish ambient @a[distance=..35] ~ ~ ~ 0.1 0 0.1

#ignite core
execute if score @s terf_data_E matches 763 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.starting.firinglasers',level:0,text:'{"text":"Firing Power Lasers For Reactor Ignition..."}'}

execute if score @s terf_data_E matches 763..793 run scoreboard players add @a[distance=..80] terf_data_P 1
scoreboard players operation temp terf_states = @s terf_data_E
scoreboard players operation temp terf_states %= 2 terf_states
execute if score temp terf_states matches 0 run scoreboard players add @a[distance=..80] terf_data_P 1

execute if score @s terf_data_E matches 823..860 run playsound minecraft:block.note_block.snare ambient @a[distance=0..] ~ ~ ~ 4 2
execute if score @s terf_data_E matches 823..860 run particle minecraft:explosion ~ ~ ~ 0 0 0 0.3 10 force
execute if score @s terf_data_E matches 823..860 run scoreboard players add @s terf_data_M 1111232
execute if score @s terf_data_E matches 844 run playsound minecraft:block.beacon.activate ambient @a[distance=0..] ~ ~ ~ 8 2
execute if score @s terf_data_E matches 844 run playsound minecraft:block.beacon.activate ambient @a[distance=0..] ~ ~ ~ 8 2

execute if score @s terf_data_E matches 848 run particle minecraft:gust ~3.5 ~ ~ 0 0 0 0.1 2 force
execute if score @s terf_data_E matches 848 run particle minecraft:gust ~-3.5 ~ ~ 0 0 0 0.1 2 force
execute if score @s terf_data_E matches 848 run particle minecraft:gust ~ ~3.5 ~ 0 0 0 0.1 2 force
execute if score @s terf_data_E matches 848 run particle minecraft:gust ~ ~-3.5 ~ 0 0 0 0.1 2 force
execute if score @s terf_data_E matches 848 run particle minecraft:gust ~ ~ ~3.5 0 0 0 0.1 2 force
execute if score @s terf_data_E matches 848 run particle minecraft:gust ~ ~ ~-3.5 0 0 0 0.1 2 force

#activate core
execute if score @s terf_data_E matches 860 run function terf:entity/machines/stfr/states/startup_confirmed/activate
execute if score @s terf_data_E matches 860.. run function terf:entity/machines/stfr/visuals/core/tick

#finish startup
execute if score @s terf_data_E matches 1030 run tag @s add terf_low_core_spin
execute if score @s terf_data_E matches 1030 run function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:'stfr.starting.complete',level:0,text:'{"text":"Reactor Startup Sequence Complete. Stabilized Thermonuclear Fusion Reactor Core Online"}'}
execute if score @s terf_data_E matches 1030 run tag @s remove terf_core_starting_alarm
execute if score @s terf_data_E matches 1030.. run scoreboard players set @s terf_data_A 3
