#special case for when terf_oldmapadditions is installed
execute if score oldmapadditions_installed terfmap_states matches 1 if dimension minecraft:overworld unless predicate terf:in_upper_map run return run scoreboard players set @s terf_data_C 2147483647

#load ship chunks
$forceload add ~ ~ ~$(size_x) ~$(size_z)

#check if the target is outside of the world with a block that we know never exists
tag @s add terf_ship_blocks_outside_world
$execute unless block ~ ~ ~ red_glazed_terracotta unless block ~$(size_x) ~$(size_y) ~$(size_z) red_glazed_terracotta run tag @s remove terf_ship_blocks_outside_world
$execute if entity @s[tag=terf_ship_blocks_outside_world] run return run forceload remove ~ ~ ~$(size_x) ~$(size_z)

#special cases for each machine
execute as @e[type=minecraft:marker,tag=terf_multiblockcore,distance=..512] at @s run function terf:entity/machines/warp_core/validate/warp_on with entity @s data.terf

#load an area as big as maximum wc size
execute in terf:intermediary_technical_storage_dimension positioned -30000000 0 -30000000 run forceload add ~ ~ ~151 ~151

#no, i cant just use clone to count blocks because mojang thought it would be funny if barriers didnt count towards "Successfully cloned ... block(s)" in /clone
#clone blocks to storage dimension and count ship blocks
$execute store result score @s terf_data_D run clone ~ ~ ~ ~$(size_x) ~$(size_y) ~$(size_z) to terf:intermediary_technical_storage_dimension -30000000 0 -30000000 masked
#replace all blocks in the storage dimension with #terf:unwarpable using fill, basically counting how many blocks are not #terf:unwarpable
$execute in terf:intermediary_technical_storage_dimension positioned -30000000 0 -30000000 store result score @s terf_data_C run fill ~ ~ ~ ~$(size_x) ~$(size_y) ~$(size_z) air replace #terf:unwarpable
$execute in terf:intermediary_technical_storage_dimension positioned -30000000 0 -30000000 run fill ~ ~ ~ ~$(size_x) ~$(size_y) ~$(size_z) air replace

#special cases for each machine
execute as @e[type=minecraft:marker,tag=terf_multiblockcore,distance=..512] at @s run function terf:entity/machines/warp_core/validate/warp_off with entity @s data.terf

#unload ship chunks
$forceload remove ~ ~ ~$(size_x) ~$(size_z)
