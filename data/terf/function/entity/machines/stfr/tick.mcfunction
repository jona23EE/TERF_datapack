#execute as @s[tag=!terf_stfr_v3] run return run function terf:entity/machines/stfr/update_shutdown

#terf_data_A = reactor status    0=offline 1=starting 2=startupconfirmed 3=online 4=stopping 5=overload 6=phase2meltdown 7=detonating 8=reaction loss 9=underloadrestabilization 10=in_stasis 11=manualrestabilization 12=startupoverload 13=underload 14=sculkbreakout 15=selfdestruct 16=stabloss
#terf_data_B = shield intensity | precision: 100
#terf_data_C = system noise cooldown (it would be hard to sync with uptime if i did modulo)
#terf_data_D = shield roation state

#terf_data_E = event timer

#terf_data_F = stabilizer ofset
#terf_data_G = stabilizer input
#terf_data_H = power lasers
#terf_data_I = pressure vent
#terf_data_J = fuel injection
#terf_data_K = cooling lasers

#terf_data_L = core spin | precision: 1000
#terf_data_M = core temp | precision: 1000
#terf_data_N = core pressure | precision: 1000
#terf_data_O = case pressure | precision: 10000
#terf_data_P = case temp | precision: 100000
#terf_data_Q = fuel stored local | precision: 1000
#terf_data_R = fuel stored in core | precision: 1000
#terf_data_S = previous broadcast warning level
#terf_data_T = uptime in ticks
#terf_data_U = timer dedicated to only the power surge
#terf_data_V = stabilizer rotation state
#terf_data_W = stabilizer animation state
#terf_data_X = previous coolant amount

#terf_data_Y = core temp saved for auto mode
#terf_data_Z = core spin saved for auto mode
#terf_data_Aa = case pressure saved for auto mode
#terf_data_Ab = event logistics
#terf_data_Ac = radiation surge (when you tase multiblock core)
#terf_data_Ad = capacitor charge
#terf_data_Ae = broadcast limit

#terf_data_Af = event storage
#terf_data_Ag = event storage
#terf_data_Ah = event storage

#Do not continue if the machine is half loaded
execute unless loaded ~ ~ ~14 run return fail
execute unless loaded ~ ~ ~-14 run return fail
execute unless loaded ~14 ~ ~ run return fail
execute unless loaded ~-14 ~ ~ run return fail

#setup
scoreboard players set spin_slow_adder terf_states 0
scoreboard players set core_scale terf_states 100
scoreboard players set core_spin_adder terf_states 0
scoreboard players set shield_stress terf_states 0
scoreboard players set cooling_rate terf_states 0
scoreboard players set rad_generation terf_states 0
scoreboard players set heat_transfer_rate terf_states 0
scoreboard players set fuel_stored_local_divided terf_states 0
scoreboard players set fuel_usage terf_states 0
scoreboard players set temp_shield_stress terf_states 0
scoreboard players set pressure_shield_stress terf_states 0
scoreboard players set spin_shield_stress terf_states 0
scoreboard players set core_pressure terf_states 0
scoreboard players set case_pressure terf_states 0

scoreboard players set core_temp_change terf_states 0
scoreboard players set core_spin_change terf_states 0
scoreboard players set case_temp_change terf_states 0

scoreboard players set working_turbines terf_states 0
scoreboard players set turbine_count terf_states 0
scoreboard players set turbine_output terf_states 0
scoreboard players operation calc terf_states = @s terf_connected_mainframe
$execute as @e[type=marker,tag=terf_linked_to_$(machine_id),tag=terf_largeturbine] if score @s terf_connected_mainframe = calc terf_states run function terf:entity/machines/stfr/calculations/get_turbine_stats

#change uptime for modulo
execute unless score @s terf_data_A matches 0 run scoreboard players add @s terf_data_T 1

#basic calculations
execute if score ETratetimer terf_states matches 10.. if score @s terf_data_Ae matches 1.. run scoreboard players remove @s terf_data_Ae 3

scoreboard players operation core_spin_divided terf_states = @s terf_data_L
scoreboard players operation core_spin_divided terf_states /= 1000 terf_states

scoreboard players operation core_temp_divided terf_states = @s terf_data_M
scoreboard players operation core_temp_divided terf_states /= 1000 terf_states

scoreboard players operation case_pressure_divided terf_states = @s terf_data_O
scoreboard players operation case_pressure_divided terf_states /= 10000 terf_states

scoreboard players operation case_temp_divided terf_states = @s terf_data_P
scoreboard players operation case_temp_divided terf_states /= 100000 terf_states

scoreboard players operation shield_intensity_divided terf_states = @s terf_data_B
scoreboard players operation shield_intensity_divided terf_states /= 100 terf_states

execute store result score lubricant_amount terf_states run data get entity @s data.fluids[2].amount
execute store result score coolant_amount terf_states run data get entity @s data.fluids[1].amount
execute store result score steam_amount terf_states run data get entity @s data.fluids[0].amount

################################################

#maintenance
scoreboard players set stab_1_maintenance terf_states 0
scoreboard players set stab_2_maintenance terf_states 0
scoreboard players set stab_3_maintenance terf_states 0
scoreboard players set stab_4_maintenance terf_states 0
scoreboard players set stab_5_maintenance terf_states 0
scoreboard players set stab_6_maintenance terf_states 0
scoreboard players set case_maintenance terf_states 0
scoreboard players set maintenance terf_states 0

function terf:entity/machines/stfr/execute_as_maintenances with entity @s data.terf

#structure checks, pipe checks etc.
execute if score NETratetimer terf_states >= NETrate terf_states run function terf:entity/machines/stfr/slower_tick

scoreboard players set working_stabs terf_states 6
execute if entity @s[tag=!terf_stab1] run scoreboard players remove working_stabs terf_states 1
execute if entity @s[tag=!terf_stab2] run scoreboard players remove working_stabs terf_states 1
execute if entity @s[tag=!terf_stab3] run scoreboard players remove working_stabs terf_states 1
execute if entity @s[tag=!terf_stab4] run scoreboard players remove working_stabs terf_states 1
execute if entity @s[tag=!terf_stab5] run scoreboard players remove working_stabs terf_states 1
execute if entity @s[tag=!terf_stab6] run scoreboard players remove working_stabs terf_states 1

function terf:entity/machines/stfr/generate_panel_text with entity @s data.terf

#update states
execute if score @s terf_data_A matches 0 run function terf:entity/machines/stfr/states/offline/tick
execute if score @s terf_data_A matches 1 run function terf:entity/machines/stfr/states/startup/tick
execute if score @s terf_data_A matches 2 run function terf:entity/machines/stfr/states/startup_confirmed/tick
execute if score @s terf_data_A matches 3 run function terf:entity/machines/stfr/states/online/tick with entity @s data.fluids[2]
execute if score @s terf_data_A matches 4 run function terf:entity/machines/stfr/states/shutdown/tick
execute if score @s terf_data_A matches 5 run function terf:entity/machines/stfr/states/overload/tick with entity @s data.terf
execute if score @s terf_data_A matches 6 run function terf:entity/machines/stfr/states/meltdown/tick with entity @s data.terf
execute if score @s terf_data_A matches 7 run function terf:entity/machines/stfr/states/detonation/tick
execute if score @s terf_data_A matches 8 run function terf:entity/machines/stfr/states/reaction_loss/tick
execute if score @s terf_data_A matches 9 run function terf:entity/machines/stfr/states/reaction_loss/reignition_tick
execute if score @s terf_data_A matches 10 run function terf:entity/machines/stfr/states/in_stasis/tick
execute if score @s terf_data_A matches 11 run function terf:entity/machines/stfr/states/manual_restabilization/tick with entity @s data.terf
execute if score @s terf_data_A matches 12 run function terf:entity/machines/stfr/states/startup_overload/tick
execute if score @s terf_data_A matches 13 run function terf:entity/machines/stfr/states/underload/tick
execute if score @s terf_data_A matches 14 run function terf:entity/machines/stfr/states/sculk_breakout/tick
execute if score @s terf_data_A matches 15 run function terf:entity/machines/stfr/states/self_destruct/tick
execute if score @s terf_data_A matches 16 run function terf:entity/machines/stfr/states/stabilizer_loss/tick
execute if score @s terf_data_A matches 17 run function terf:entity/machines/stfr/states/shutdown_failure/tick with entity @s data.terf

execute if score @s terf_data_U matches 3.. run function terf:entity/machines/stfr/emergency_controls/power_surge/tick
execute if score @s terf_data_Ac matches 1.. run function terf:entity/machines/stfr/emergency_controls/radiation_surge/tick
execute if entity @s[tag=terf_case_shield] run function terf:entity/machines/stfr/emergency_controls/case_shield/tick
execute if entity @s[tag=terf_case_shield_primed] if score @s[tag=!terf_case] terf_data_Ad matches 60001.. if score @s terf_data_A matches 3 run tag @s add terf_case_shield
execute if entity @s[tag=!terf_case_shield_primed] run tag @s remove terf_case_shield

execute store result entity @s data.fluids[1].amount int 1 run scoreboard players get coolant_amount terf_states
execute store result entity @s data.fluids[0].amount int 1 run scoreboard players get steam_amount terf_states

################################################

execute if block ~ ~-10 ~ #terf:neth_and_barrier run tag @s add terf_indestructible
execute if block ~ ~10 ~ #terf:neth_and_barrier run tag @s add terf_indestructible
execute if block ~ ~ ~-10 #terf:neth_and_barrier run tag @s add terf_indestructible
execute if block ~ ~ ~10 #terf:neth_and_barrier run tag @s add terf_indestructible
execute if block ~-10 ~ ~ #terf:neth_and_barrier run tag @s add terf_indestructible
execute if block ~10 ~ ~ #terf:neth_and_barrier run tag @s add terf_indestructible
execute unless score @s terf_data_A matches 0 run tag @s add terf_indestructible

#display stuff on control panels
execute if entity @s[tag=terf_controls_locked] unless score NETratetimer terf_states >= NETrate terf_states run return fail

data modify storage terf:temp displays.group_core[].color set from storage terf:temp displays.group_core[0].messages[0].screen_color

tag @s remove terf_cp_connected
scoreboard players operation calc terf_states = @s terf_connected_mainframe
$execute at @e[type=marker,tag=terf_linked_to_$(machine_id),tag=terf_stfr_controller] if score @e[type=marker,distance=..0.01,limit=1] terf_connected_mainframe = calc terf_states if block ~ ~ ~ loom if block ^-1 ^ ^ waxed_cut_copper run function terf:entity/machines/stfr_control_panel/as_core_at_control_panel

#redstone probe integration
execute unless score NETratetimer terf_states >= NETrate terf_states run return fail
scoreboard players operation calc terf_states = @s terf_connected_mainframe
$execute as @e[type=marker,tag=terf_linked_to_$(machine_id),tag=terf_redstone_probe] at @s run function terf:entity/machines/redstone_probe/machine_tick
