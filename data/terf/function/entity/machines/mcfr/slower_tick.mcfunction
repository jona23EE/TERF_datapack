execute if score @s datapipes_lib_power_storage matches 1.. run scoreboard players operation @s datapipes_lib_power_storage *= 200 terf_states
execute if score @s datapipes_lib_power_storage matches 1.. run scoreboard players operation @s datapipes_lib_power_storage /= @s terf_data_B
execute if score @s datapipes_lib_power_storage matches 1.. run scoreboard players operation @s terf_data_A += @s datapipes_lib_power_storage
execute if score @s datapipes_lib_power_storage matches 1.. run scoreboard players set @s datapipes_lib_power_storage 0

function terf:entity/machines/mcfr/checks/start
$execute positioned ~ ~$(height) ~ run function terf:entity/machines/mcfr/slower_tick_top with entity @s data.terf

execute store result storage terf:temp temp[0].max int 20000 run scoreboard players get @s terf_data_B
execute store result storage terf:temp temp[1].max int 20000 run scoreboard players get @s terf_data_B
execute store result storage terf:temp temp[2].max int 20000 run scoreboard players get @s terf_data_B
execute store result storage terf:temp temp[3].max int 10000 run scoreboard players get @s terf_data_B

#check where fluid pipes are
execute if block ~ ~-2 ~ granite_slab[type=double] run data modify entity @s data.power set value {checks:"if block ~ ~-2 ~ red_glazed_terracotta"}
execute if block ~ ~-2 ~1 granite_slab[type=double] run data modify entity @s data.power set value {checks:"if block ~ ~-2 ~1 red_glazed_terracotta"}
execute if block ~1 ~-2 ~ granite_slab[type=double] run data modify entity @s data.power set value {checks:"if block ~1 ~-2 ~ red_glazed_terracotta"}
execute if block ~1 ~-2 ~1 granite_slab[type=double] run data modify entity @s data.power set value {checks:"if block ~1 ~-2 ~1 red_glazed_terracotta"}

execute if block ~ ~-2 ~ waxed_cut_copper run data modify entity @s data.terf.mainframe_logistics.config.input_coords set value "~ ~-2 ~"
execute if block ~ ~-2 ~1 waxed_cut_copper run data modify entity @s data.terf.mainframe_logistics.config.input_coords set value "~ ~-2 ~1"
execute if block ~1 ~-2 ~ waxed_cut_copper run data modify entity @s data.terf.mainframe_logistics.config.input_coords set value "~1 ~-2 ~"
execute if block ~1 ~-2 ~1 waxed_cut_copper run data modify entity @s data.terf.mainframe_logistics.config.input_coords set value "~1 ~-2 ~1"

execute if block ~ ~-2 ~ smooth_basalt run data modify storage terf:temp temp[0] merge value {outpos:"~ ~-2 ~", checks:"if block ~ ~-2 ~ red_glazed_terracotta"}
execute if block ~ ~-2 ~1 smooth_basalt run data modify storage terf:temp temp[0] merge value {outpos:"~ ~-2 ~1", checks:"if block ~ ~-2 ~1 red_glazed_terracotta"}
execute if block ~1 ~-2 ~ smooth_basalt run data modify storage terf:temp temp[0] merge value {outpos:"~1 ~-2 ~", checks:"if block ~1 ~-2 ~ red_glazed_terracotta"}
execute if block ~1 ~-2 ~1 smooth_basalt run data modify storage terf:temp temp[0] merge value {outpos:"~1 ~-2 ~1", checks:"if block ~1 ~-2 ~1 red_glazed_terracotta"}

execute if block ~ ~-2 ~ waxed_cut_copper run data modify storage terf:temp temp[3] merge value {outpos:"~ ~-2 ~", checks:"if block ~ ~-2 ~ red_glazed_terracotta"}
execute if block ~ ~-2 ~1 waxed_cut_copper run data modify storage terf:temp temp[3] merge value {outpos:"~ ~-2 ~1", checks:"if block ~ ~-2 ~1 red_glazed_terracotta"}
execute if block ~1 ~-2 ~ waxed_cut_copper run data modify storage terf:temp temp[3] merge value {outpos:"~1 ~-2 ~", checks:"if block ~1 ~-2 ~ red_glazed_terracotta"}
execute if block ~1 ~-2 ~1 waxed_cut_copper run data modify storage terf:temp temp[3] merge value {outpos:"~1 ~-2 ~1", checks:"if block ~1 ~-2 ~1 red_glazed_terracotta"}

#mainframe update buffering
execute if score NETratetimer terf_states >= NETrate terf_states if score @s terf_connected_mainframe_buffer = @s terf_connected_mainframe_buffer run scoreboard players operation @s terf_connected_mainframe = @s terf_connected_mainframe_buffer
execute if score NETratetimer terf_states >= NETrate terf_states unless score @s terf_connected_mainframe_buffer = @s terf_connected_mainframe_buffer run scoreboard players reset @s terf_connected_mainframe
execute if score NETratetimer terf_states >= NETrate terf_states run scoreboard players reset @s terf_connected_mainframe_buffer
