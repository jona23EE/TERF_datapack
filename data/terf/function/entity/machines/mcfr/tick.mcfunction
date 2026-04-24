#terf_data_A = reactor temperature (accuracy * 10000)
#terf_data_B = height
#terf_data_C = waste stuck inside of catalyst
#terf_data_D = fuel per waste
#terf_data_E = waste buffer
#terf_data_F = fuel buffer
#terf_data_G = ignition temperature
#terf_data_H = power output

#do not continue if the entire machine is not loaded
execute unless loaded ~2 ~ ~2 run return fail
execute unless loaded ~2 ~ ~-1 run return fail
execute unless loaded ~-1 ~ ~2 run return fail
execute unless loaded ~-1 ~ ~-1 run return fail

#load fluid amounts
data modify storage terf:temp temp set from entity @s data.fluids
execute store result score coolant_amount terf_states run data get storage terf:temp temp[0].amount
execute store result score steam_amount terf_states run data get storage terf:temp temp[1].amount
execute store result score fuel_amount terf_states run data get storage terf:temp temp[2].amount
execute store result score waste_amount terf_states run data get storage terf:temp temp[3].amount

#basic calculations
#passive heat dissapation
execute if score @s terf_data_A matches 100.. run scoreboard players remove @s terf_data_A 100

scoreboard players operation core_temp_divided terf_states = @s terf_data_A
scoreboard players operation core_temp_divided terf_states /= 10000 terf_states

#make fuel go from the core to the output tank
scoreboard players operation pressure terf_states = fuel_amount terf_states
scoreboard players operation pressure terf_states += waste_amount terf_states
scoreboard players operation pressure terf_states += @s terf_data_C
scoreboard players operation pressure terf_states /= @s terf_data_B
scoreboard players operation pressure terf_states *= core_temp_divided terf_states

execute if score NETratetimer terf_states >= NETrate terf_states run function terf:entity/machines/mcfr/slower_tick with entity @s data.terf

tag @s remove terf_indestructible
execute if score @s terf_data_A >= @s terf_data_G run function terf:entity/machines/mcfr/calculations
execute if score core_temp_divided terf_states matches ..999 if entity @s[tag=terf_has_text_displays] run function terf:entity/machines/mcfr/visuals/kill_text_displays with entity @s data.terf

scoreboard players operation temp terf_states = @s terf_data_C
scoreboard players operation temp terf_states /= 100 terf_states
scoreboard players operation temp terf_states /= @s terf_data_B
scoreboard players operation @s terf_data_C -= temp terf_states
scoreboard players operation waste_amount terf_states += temp terf_states

#save fluid amounts
execute store result storage terf:temp temp[0].amount int 1 run scoreboard players get coolant_amount terf_states
execute store result storage terf:temp temp[1].amount int 1 run scoreboard players get steam_amount terf_states
execute store result storage terf:temp temp[2].temperature int 1 run scoreboard players get core_temp_divided terf_states
execute store result storage terf:temp temp[2].amount int 1 run scoreboard players get fuel_amount terf_states
execute store result storage terf:temp temp[3].amount int 1 run scoreboard players get waste_amount terf_states
data modify entity @s data.fluids set from storage terf:temp temp

#never leave terf:temp temp an array
data remove storage terf:temp temp

#debug
#title @a[distance=..20] actionbar [{"text":"Temp:"},{"score":{"objective":"terf_states","name":"core_temp_divided"}},{"text":" | Reaction Rate:"},{"score":{"objective":"terf_states","name":"reaction_rate"}},{"text":" | Fuel:"},{"score":{"objective":"terf_states","name":"fuel_amount"}},{"text":" | Waste:"},{"score":{"objective":"terf_states","name":"waste_amount"}},{"text":" | Pressure:"},{"score":{"objective":"terf_states","name":"pressure"}}]

#redstone probe integration
execute unless score NETratetimer terf_states >= NETrate terf_states run return fail
scoreboard players operation calc terf_states = @s terf_connected_mainframe
$execute as @e[type=marker,tag=terf_linked_to_$(machine_id),tag=terf_redstone_probe] at @s run function terf:entity/machines/redstone_probe/machine_tick