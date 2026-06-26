#terf_data_A = reactor status    0=offline 1=starting 2=startupconfirmed 3=online 4=stopping 5=overload 6=phase2meltdown 7=detonating 8=underload 9=underloadrestabilization 10=in_stasis 11=manualrestabilization 12=startupoverload 13=underload 14=sculkbreakout
#terf_data_B = shield intensity | precision: 100
#terf_data_C = system noise cooldown (it would be hard to sync with uptime if i did modulo)
#terf_data_D = shield roation state

#terf_data_E = event timer

#terf_data_F = stabilizer offset
#terf_data_G = shield permeability
#terf_data_H = power lasers
#terf_data_I = pressure vent
#terf_data_J = fuel injection
#terf_data_K = rf suppression

#terf_data_L = core spin | precision: 1000
#terf_data_M = core temp in kilokelvins
#terf_data_N = core temp decimals
#terf_data_O = core density buffer
#terf_data_P = case temp | precision: 100000
#terf_data_Q = peak reactivity
#terf_data_R = reactivity peak
#terf_data_S = bcd functional turbines
#terf_data_T = uptime in ticks
#terf_data_U = timer dedicated to only the power surge
#terf_data_V = stabilizer rotation state
#terf_data_W = stabilizer animation state
#terf_data_X = previous coolant amount

#terf_data_Y = lowest fuel capsule amount
#terf_data_Z = UNASSIGNED
#terf_data_Aa = UNASSIGNED
#terf_data_Ab = event logistics
#terf_data_Ac = radiation surge (when you tase multiblock core)
#terf_data_Ad = capacitor charge
#terf_data_Ae = core humming cooldown (it would be hard to sync with uptime if i did modulo)

#====================| How the loss of stabilizers should affect controls
scoreboard players operation stabilizer_loss_multiplier terf_states = working_stabs terf_states
execute if score stabilizer_loss_multiplier terf_states matches 5.. run scoreboard players set stabilizer_loss_multiplier terf_states 4

#====================| Maxwellian RF Suppression
scoreboard players operation temp terf_states = @s terf_data_K
scoreboard players operation temp terf_states *= stabilizer_loss_multiplier terf_states

scoreboard players set reaction_rate_multiplier terf_states 400
scoreboard players operation reaction_rate_multiplier terf_states -= temp terf_states
scoreboard players operation reaction_rate_multiplier terf_states /= 4 terf_states
#reaction_rate_multiplier has an accuracy of 100

#====================| React core contents and vent them into case according to permeability
#MAKE IT SURE variables do not conflict
data modify storage terf:temp stfr_dedicated set value {array:[]}
data modify storage terf:temp stfr_dedicated.array set from entity @s data.terf.core_contents

#1 KeV = 11604 kilokelvins
execute store result storage terf:temp stfr_dedicated.core_stats.input float 0.00008617718028266115132712857635 run scoreboard players get @s terf_data_M
scoreboard players set core_density terf_states 0
scoreboard players set case_density terf_states 0
scoreboard players set total_reaction_rate terf_states 0
scoreboard players set rad_generation terf_states 0
scoreboard players set core_output_kw terf_states 0
scoreboard players set core_shc terf_states 0
execute store result score stfr_array_length terf_states run data get storage terf:temp stfr_dedicated.array
#execute if score stfr_array_length terf_states matches 100.. run return run function terf:entity/machines/stfr/states/glitchdown/start
function terf:entity/machines/stfr/calculations/iterate_core_contents

#heat core according to its thermal capacity and the output
scoreboard players operation core_output_mw terf_states = core_output_kw terf_states
scoreboard players operation core_output_mw terf_states /= 10000 terf_states

scoreboard players operation temp terf_states = core_output_kw terf_states
scoreboard players operation temp terf_states /= core_shc terf_states
scoreboard players operation core_temp_change terf_states += temp terf_states

scoreboard players operation temp terf_states = core_output_kw terf_states
scoreboard players operation temp terf_states %= core_shc terf_states
scoreboard players operation @s terf_data_N += temp terf_states

#calculate core density
#execute store result storage terf:temp args.float double 0.0000001 run scoreboard players get core_density terf_states
#scoreboard players operation temp terf_states = core_density terf_states
#function terf:entity/machines/stfr/calculations/multiply_float with storage terf:temp args
#execute store result score @s terf_data_O run data get storage terf:temp args.float
scoreboard players operation @s terf_data_O = core_density terf_states

#divide ts
scoreboard players operation rad_generation terf_states /= 12 terf_states

#save core contents from rebuilt array 
data modify entity @s data.terf.core_contents set from storage terf:temp stfr_dedicated.array

#====================| Core temp decimal translation math
scoreboard players operation temp terf_states = @s terf_data_N
scoreboard players operation temp terf_states /= 10000 terf_states
scoreboard players operation @s terf_data_N %= 10000 terf_states
scoreboard players operation core_temp_change terf_states += temp terf_states

#calculate case pressure
execute store result storage terf:temp args.float double 0.000001 run scoreboard players get case_density terf_states
scoreboard players operation temp terf_states = @s terf_data_P
scoreboard players add temp terf_states 100000000
execute if score temp terf_states matches ..-1 run scoreboard players set temp terf_states 2147483647
function terf:entity/machines/stfr/calculations/multiply_float with storage terf:temp args
execute store result score case_pressure terf_states run data get storage terf:temp args.float
scoreboard players operation case_pressure_divided terf_states = case_pressure terf_states
scoreboard players operation case_pressure_divided terf_states /= 10000 terf_states

execute if score case_pressure_divided terf_states matches 214000.. run data modify storage terf:temp displays.group_main[14].messages[1] set value [{"text":"Pres: "},{"text":"Error",color:"#FF0000"}]
execute if score case_temp_divided terf_states matches 5420.. run data modify storage terf:temp displays.group_main[14].messages[2] set value [{"text":"Temp: "},{"text":"Error",color:"#FF0000"}]

#calculate core pressure
scoreboard players operation core_pressure terf_states = @s terf_data_O

#calculate the absolute value for core spin
scoreboard players operation core_spin_absolute terf_states = core_spin_divided terf_states
execute if score core_spin_divided terf_states matches ..-1 run scoreboard players operation core_spin_absolute terf_states /= -1 terf_states

#====================| Fuel Injection
scoreboard players operation injection_multiplier terf_states = @s terf_data_J
scoreboard players operation injection_multiplier terf_states *= 24 terf_states

#Ok so, each fluid should get an array value with ratios like [{id:"terf.deuterium",amount:2},{id:"terf.hydrogen",amount:3}]
#this array is generated every time a non empty fuel capsule gets inserted and locked.

#the amount of fuel that should be injected into the core is amount*fuel_injection

#the fuel for each fluid should be removed from a random capsule matching the id every tick, if it cannot find a capsule with the matching id it should display a danger broadcast.
#if the capsules fluid amount is lower than the requested fluid amount, its gonna add the capsules amount to core and set its id to empty

data modify storage terf:temp array set from entity @s data.terf.injection_list
function terf:entity/machines/stfr/calculations/iterate_injection_list with storage terf:temp array[0]

#====================| Calculate shield stress
#calculate mssr
scoreboard players operation mssr terf_states = core_spin_absolute terf_states
scoreboard players operation mssr terf_states /= stfr_mssr_divider terf_states

#calculate pressure shield stress
scoreboard players operation pressure_shield_stress terf_states = core_pressure terf_states
scoreboard players operation pressure_shield_stress terf_states /= stfr_pressure_shield_stress_divider terf_states
scoreboard players operation pressure_shield_stress terf_states -= mssr terf_states
execute if score pressure_shield_stress terf_states matches ..-1 run scoreboard players set pressure_shield_stress terf_states 0

#calculate unknown shield stress
scoreboard players set shield_collapse_stress terf_states 1000000
scoreboard players operation shield_collapse_stress terf_states -= core_pressure terf_states
scoreboard players operation shield_collapse_stress terf_states /= 1000 terf_states
execute if score shield_collapse_stress terf_states matches ..-1 run scoreboard players set shield_collapse_stress terf_states 0

scoreboard players operation unknown_shield_stress terf_states = shield_collapse_stress terf_states

#calculate core spin shield stress and its exponential rise after awhile
scoreboard players operation spin_stress_exp terf_states = core_spin_absolute terf_states
scoreboard players operation spin_stress_exp terf_states /= stfr_spin_shield_stress_exp_divider terf_states
scoreboard players operation spin_stress_exp terf_states -= stfr_spin_shield_stress_exp_subtractor terf_states

scoreboard players operation spin_shield_stress terf_states = core_spin_absolute terf_states
scoreboard players operation spin_shield_stress terf_states /= stfr_spin_shield_stress_divider terf_states
execute if score spin_stress_exp terf_states matches 0.. run scoreboard players operation spin_shield_stress terf_states += spin_stress_exp terf_states

#add together all factors to get the shield stress
scoreboard players operation shield_stress terf_states = pressure_shield_stress terf_states 
scoreboard players operation shield_stress terf_states += spin_shield_stress terf_states 
scoreboard players operation shield_stress terf_states += unknown_shield_stress terf_states 

#====================| Calcualte spin change
#calculate how fast the core spin slows
scoreboard players operation spin_slow_rate terf_states = core_spin_absolute terf_states
execute if score core_spin_absolute terf_states matches 3000.. run scoreboard players add spin_slow_rate terf_states 1
execute if score core_spin_absolute terf_states matches 3000.. run scoreboard players operation spin_slow_rate terf_states += case_pressure_divided terf_states
scoreboard players operation spin_slow_rate terf_states /= 4 terf_states
scoreboard players add spin_slow_rate terf_states 50

#slow core spin during events
scoreboard players operation spin_slow_rate terf_states += spin_slow_adder terf_states

#calculate core spin change from the stabilizer offset control
scoreboard players operation core_spin_change terf_states = @s terf_data_F
scoreboard players operation core_spin_change terf_states *= 120 terf_states
scoreboard players operation core_spin_change terf_states *= stabilizer_loss_multiplier terf_states

execute if score @s terf_data_U matches 600.. run scoreboard players operation core_spin_change terf_states *= 10 terf_states

#slow core spin
execute if score @s terf_data_L matches 3500.. run scoreboard players operation core_spin_change terf_states -= spin_slow_rate terf_states
execute if score @s terf_data_L matches ..-3500 run scoreboard players operation core_spin_change terf_states += spin_slow_rate terf_states
execute if score @s terf_data_L matches 20..3499 run scoreboard players remove core_spin_change terf_states 10
execute if score @s terf_data_L matches -3499..-20 run scoreboard players add core_spin_change terf_states 10
execute if score @s terf_data_L matches 1..19 run scoreboard players remove core_spin_change terf_states 1
execute if score @s terf_data_L matches -19..0 run scoreboard players add core_spin_change terf_states 1

#====================| Calcualte power laser heating and its capacitor charge usage
scoreboard players operation power_laser_heating_rate terf_states = @s terf_data_H
scoreboard players operation power_laser_heating_rate terf_states *= 50 terf_states

#account for stabilizer loss
scoreboard players operation power_laser_heating_rate terf_states *= stabilizer_loss_multiplier terf_states
scoreboard players operation power_laser_heating_rate terf_states /= 4 terf_states

#if there is not enough capacitor charge
execute if score power_laser_heating_rate terf_states > @s terf_data_Ad run scoreboard players operation power_laser_heating_rate terf_states = @s terf_data_Ad
scoreboard players operation @s terf_data_Ad -= power_laser_heating_rate terf_states

#since 10 capacitor charge is 1 MWs or megajoule
scoreboard players operation power_laser_heating_rate terf_states *= 1000 terf_states

#power surge
execute if score @s terf_data_U matches 600.. run scoreboard players operation power_laser_heating_rate terf_states *= 10 terf_states

#apply
scoreboard players operation power_laser_heating_rate terf_states /= core_shc terf_states
scoreboard players operation core_temp_change terf_states += power_laser_heating_rate terf_states

#====================| Boil coolant, cool case and charge capacitors
scoreboard players operation cooling_rate terf_states = @s terf_data_P
#dont start boiling till 100c
scoreboard players remove cooling_rate terf_states 10000000
execute if score cooling_rate terf_states matches ..-1 run scoreboard players set cooling_rate terf_states 0
scoreboard players operation cooling_rate terf_states /= stfr_cooling_rate_divider terf_states

scoreboard players operation cooling_rate_mw terf_states = cooling_rate terf_states
scoreboard players operation cooling_rate_mw terf_states /= 10 terf_states

scoreboard players operation coolant_boil_rate terf_states = cooling_rate terf_states

#"steal" some heat energy from coolant boil rate to charge capacitors instead, using thermoelectric generators i guess
scoreboard players set max_capacitor_charge terf_states 1000000
scoreboard players operation capacitor_charge_rate terf_states = max_capacitor_charge terf_states
scoreboard players operation capacitor_charge_rate terf_states -= @s terf_data_Ad
#limit max charging rate (in 0.1mw)
execute if score capacitor_charge_rate terf_states matches 1001.. run scoreboard players set capacitor_charge_rate terf_states 1000
execute if score capacitor_charge_rate terf_states > coolant_boil_rate terf_states run scoreboard players operation capacitor_charge_rate terf_states = coolant_boil_rate terf_states
scoreboard players operation coolant_boil_rate terf_states -= capacitor_charge_rate terf_states
scoreboard players operation @s terf_data_Ad += capacitor_charge_rate terf_states

#boiling 1 mb/t of water takes 6.7 mw (god DAMN I CANT ESCAPE SIX SEVEN) or 67000 cooling_rate
scoreboard players operation coolant_boil_rate terf_states /= 67 terf_states

#if there is not enough coolant, stop cooling
execute unless score coolant_amount terf_states >= coolant_boil_rate terf_states run scoreboard players set cooling_rate terf_states 0

scoreboard players operation case_temp_change terf_states -= cooling_rate terf_states

#decrease coolant level and increase steam level, technically 1mb of water is 1670 steam but thats unfeasable because at max power steam would reach int limit in 5s
scoreboard players operation coolant_removed terf_states = coolant_amount terf_states
execute if score coolant_amount terf_states >= coolant_boil_rate terf_states run scoreboard players operation coolant_amount terf_states -= coolant_boil_rate terf_states
scoreboard players operation coolant_removed terf_states -= coolant_amount terf_states
scoreboard players operation coolant_removed terf_states *= 167 terf_states
scoreboard players operation steam_amount terf_states += coolant_removed terf_states

###################################################################################################
#apply calculations
#check if steam buffer is full
execute if score NETratetimer terf_states = NETratehalf terf_states run tag @s remove terf_outtake_blocked
execute if score NETratetimer terf_states = NETratehalf terf_states if score steam_amount terf_states > coolant_removed terf_states run tag @s add terf_outtake_blocked

#case leaking stuff
execute as @s[tag=!terf_case,tag=!terf_case_shield] run function terf:entity/machines/stfr/actions/case/leak

#case boom
execute if score case_pressure_divided terf_states matches 81156.. if predicate datapipes_lib:chances/1 as @s[tag=terf_case] run function terf:entity/machines/stfr/actions/case/blowout
execute if score case_pressure_divided terf_states matches 95156.. if predicate datapipes_lib:chances/0.3 as @s[tag=terf_case] run function terf:entity/machines/stfr/actions/case/explosion

#case fire
execute if score case_temp_divided terf_states matches 1000.. run function terf:entity/machines/stfr/actions/case/fire
execute if score case_temp_divided terf_states matches 1084.. if predicate datapipes_lib:chances/3 run function terf:entity/machines/stfr/actions/case/degrade

data modify storage terf:temp args set value {command:'summon minecraft:text_display ^ ^ ^4 {Tags:["terf_particle","terf_humongous_fire"],billboard:center,text:{"text":"\\ueff5","color":"#111111"},background:0,view_range:730,brightness:{sky:15,block:15},teleport_duration:2,alignment:center}'}
execute store result storage terf:temp args.yaw float 1 run random value 0..360
execute store result storage terf:temp args.pitch float 1 run random value -85..0
execute if score case_temp_divided terf_states matches 1500.. if predicate datapipes_lib:chances/20 run function datapipes_lib:require/run_rotated with storage terf:temp args
execute if score case_temp_divided terf_states matches 1500.. run scoreboard players remove @s terf_data_P 30000

#====================| Transfer core temp to case temp | radiative heat transfer is negligable because the shield blocks the spectrums
#calculate htr
scoreboard players operation temp terf_states = core_spin_absolute terf_states
scoreboard players add temp terf_states 69000

#divide by 70
execute store result storage terf:temp args.float double 0.0000000000000001428571428571428571428571428571 run scoreboard players get temp terf_states
scoreboard players operation temp terf_states = case_pressure terf_states
scoreboard players add temp terf_states 4200000
function terf:entity/machines/stfr/calculations/multiply_float with storage terf:temp args

scoreboard players operation temp terf_states = @s terf_data_M
execute if score temp terf_states matches 2000001.. run scoreboard players set temp terf_states 2000000
function terf:entity/machines/stfr/calculations/multiply_float with storage terf:temp args

#divide by 35 and multiply by 1000 for integer division
execute store result storage terf:temp args.float double 0.2857142857142857142857142857143 run data get storage terf:temp args.float 10000

execute store result score heat_transfer_rate terf_states run data get storage terf:temp args.float
execute if score heat_transfer_rate terf_states matches ..-1 run scoreboard players set heat_transfer_rate terf_states 0

#change stats
scoreboard players operation temp terf_states = heat_transfer_rate terf_states

#divide in respect of the integer limit
scoreboard players operation heat_transfer_rate_mw terf_states = heat_transfer_rate terf_states
scoreboard players operation heat_transfer_rate_mw terf_states /= 1000 terf_states
execute if score core_temp_divided terf_states > case_temp_divided terf_states run scoreboard players operation case_temp_change terf_states += heat_transfer_rate_mw terf_states
scoreboard players operation heat_transfer_rate_mw terf_states /= 10 terf_states

#divide by the cores specific heat capacity
scoreboard players operation temp terf_states /= core_shc terf_states
execute if score core_temp_divided terf_states > case_temp_divided terf_states run scoreboard players operation core_temp_change terf_states -= temp terf_states

#====================| Change shield intensity
#intensity decrease
scoreboard players operation intensity_decrease terf_states = shield_stress terf_states
scoreboard players operation intensity_decrease terf_states /= 50 terf_states
execute if score @s terf_data_B matches 3.. if score shield_stress terf_states matches 100.. run scoreboard players operation @s terf_data_B -= intensity_decrease terf_states
execute if score working_stabs terf_states matches ..0 if score @s terf_data_B matches 100.. run scoreboard players remove @s terf_data_B 100

#intensity increase
execute if score @s terf_data_B matches ..10000 if score shield_stress terf_states matches ..99 run scoreboard players add @s terf_data_B 1

#change core stats
scoreboard players operation @s terf_data_L += core_spin_change terf_states
scoreboard players operation @s terf_data_M += core_temp_change terf_states
scoreboard players operation @s terf_data_P += case_temp_change terf_states
execute if score @s terf_data_P matches ..-27315000 run scoreboard players set @s terf_data_P 2147483647

################################################

#other functionalities
function terf:entity/machines/stfr/calculations/extra

execute if score steam_amount terf_states matches 83580000.. if predicate datapipes_lib:chances/1 run function terf:entity/machines/stfr/actions/stabilizer/eject_steam

################################################

#set limits
execute if score coolant_amount terf_states matches ..-1 run scoreboard players set coolant_amount terf_states 0
execute if score steam_amount terf_states matches 83580001.. run scoreboard players set steam_amount terf_states 83580000