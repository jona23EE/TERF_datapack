#count up amounts
execute store result score core_amount terf_states run data get storage terf:temp stfr_dedicated.array[0].core_amount
scoreboard players operation core_density terf_states += core_amount terf_states

execute store result score case_amount terf_states run data get storage terf:temp stfr_dedicated.array[0].case_amount
scoreboard players operation case_density terf_states += case_amount terf_states

#core shc has the accuracy of 10 meaning 1 million "amount" is 1 mole
execute store result storage terf:temp args.multiplier float 0.00001 run scoreboard players get core_amount terf_states
function terf:entity/machines/stfr/calculations/get_shc with storage terf:temp args
scoreboard players operation core_shc terf_states += shc_per_mole terf_states

#if the fluid has a fusion function
function terf:entity/machines/stfr/calculations/fusion with storage terf:temp stfr_dedicated.array[0].fusion

#pressure vent, remove from case amount and add to output tanks (TO DO)
execute if entity @s[tag=!terf_case,tag=!terf_case_shield] run function terf:entity/machines/stfr/calculations/case_leak

scoreboard players operation venting_rate terf_states = case_amount terf_states
scoreboard players operation venting_rate terf_states *= @s terf_data_I
scoreboard players operation venting_rate terf_states /= stfr_pressure_vent_divider terf_states
scoreboard players operation case_amount terf_states -= venting_rate terf_states

#shield permeability, remove from core amount and add to case amount
scoreboard players operation venting_rate terf_states = core_amount terf_states
scoreboard players operation venting_rate terf_states *= @s terf_data_G
scoreboard players operation venting_rate terf_states /= stfr_shield_permeability_divider terf_states
scoreboard players operation core_amount terf_states -= venting_rate terf_states
scoreboard players operation case_amount terf_states += venting_rate terf_states

#save values
execute store result storage terf:temp stfr_dedicated.array[0].case_amount int 1 run scoreboard players get case_amount terf_states
execute store result storage terf:temp stfr_dedicated.array[0].core_amount int 1 run scoreboard players get core_amount terf_states

#continue iterating
scoreboard players remove stfr_array_length terf_states 1
data modify storage terf:temp stfr_dedicated.array append from storage terf:temp stfr_dedicated.array[0]
data remove storage terf:temp stfr_dedicated.array[0]
execute if score stfr_array_length terf_states matches 1.. run function terf:entity/machines/stfr/calculations/iterate_core_contents
