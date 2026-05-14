tag @s add terf_warp_core_coords_checked

function terf:entity/machines/warp_core/parse_screens with entity @s data.terf

scoreboard players set @s terf_data_B 2147483647
scoreboard players set @s terf_data_C 2147483647
scoreboard players set @s terf_data_D 2147483647

#set args
execute store result storage terf:temp args.offset_x int -1 run scoreboard players get @s terf_data_R
execute store result storage terf:temp args.offset_y int -1 run scoreboard players get @s terf_data_S
execute store result storage terf:temp args.offset_z int -1 run scoreboard players get @s terf_data_T

execute store result storage terf:temp args.size_x int 1 run scoreboard players get @s terf_data_U
execute store result storage terf:temp args.size_y int 1 run scoreboard players get @s terf_data_V
execute store result storage terf:temp args.size_z int 1 run scoreboard players get @s terf_data_W

execute store result storage terf:temp args.target_x int 1 run scoreboard players get @s terf_data_X
execute store result storage terf:temp args.target_y int 1 run scoreboard players get @s terf_data_Y
execute store result storage terf:temp args.target_z int 1 run scoreboard players get @s terf_data_Z

data modify storage terf:temp args.dimension set from entity @s data.terf.warp_core.dim

data modify storage terf:temp argrs.machine_id set from entity @s data.terf.machine_id

## Validate target coordinates at the target coordinates
function terf:entity/machines/warp_core/validate/target_coordinates with storage terf:temp args
#dont continue if validating target coordinates fail
execute if score @s terf_data_B matches 1.. run return fail

## Validate ship coordinates at the current location
function terf:entity/machines/warp_core/validate/ship_coordinates with storage terf:temp args
#dont continue if validating ship coordinates fail
execute if score @s terf_data_C matches 1.. run return fail
