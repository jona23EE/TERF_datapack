#Load chunks
$execute in $(dimension) positioned $(target_x) 0 $(target_z) run forceload add ~ ~ ~$(size_x) ~$(size_z)
$forceload add ~ ~ ~$(size_x) ~$(size_z)

#Kill entities in the way of the area
$execute align xyz in $(dimension) positioned $(target_x) $(target_y) $(target_z) as @e[dx=$(size_x),dy=$(size_y),dz=$(size_z),tag=!terf_unwarpable] run damage @s 69420 terf:warp_field

#Teleport entities
execute align xyz run summon marker ~ ~ ~ {UUID:[I;1101100,1101101,1100001,1101111]}
execute store result score x terf_states run data get entity 0010cd2c-0010-cd2d-0010-c8e10010cd37 Pos[0]
execute store result score y terf_states run data get entity 0010cd2c-0010-cd2d-0010-c8e10010cd37 Pos[1]
execute store result score z terf_states run data get entity 0010cd2c-0010-cd2d-0010-c8e10010cd37 Pos[2]
kill 0010cd2c-0010-cd2d-0010-c8e10010cd37
$scoreboard players set x2 terf_states $(target_x)
$scoreboard players set y2 terf_states $(target_y)
$scoreboard players set z2 terf_states $(target_z)
$data modify storage terf:temp args set value {dimension:'$(dimension)'}
execute store result storage terf:temp args.x int 1 run scoreboard players operation x2 terf_states -= x terf_states
execute store result storage terf:temp args.y int 1 run scoreboard players operation y2 terf_states -= y terf_states
execute store result storage terf:temp args.z int 1 run scoreboard players operation z2 terf_states -= z terf_states
$execute align xyz positioned ~-.001 ~-.001 ~-.001 as @e[dx=$(size_x),dy=$(size_y),dz=$(size_z),predicate=datapipes_lib:not_riding,tag=!terf_unwarpable] at @s run function terf:entity/machines/warp_core/states/warp/teleport with storage terf:temp args
$execute as @e[type=text_display,distance=0..,tag=terf_related_$(machine_id)] at @s in $(dimension) run tp @s ~$(x) ~$(y) ~$(z)

#Remove oxygen
$fill ~ ~ ~ ~$(size_x) ~$(size_y) ~$(size_z) air replace void_air

#Teleport blocks
$clone ~ ~ ~ ~$(size_x) ~$(size_y) ~$(size_z) to $(dimension) $(target_x) $(target_y) $(target_z) masked move

#kill potentially duped items left behind by mojank's /clone
$execute align xyz positioned ~-.001 ~-.001 ~-.001 as @e[type=!player,dx=$(size_x),dy=$(size_y),dz=$(size_z),tag=!terf_unwarpable] run kill @s

#run afterwarp functions
$execute align xyz in $(dimension) positioned $(target_x) $(target_y) $(target_z) as @e[dx=$(size_x),dy=$(size_y),dz=$(size_z),tag=!terf_unwarpable] run function terf:entity/machines/warp_core/after_warp with entity @s data.terf

#give advancement
$execute align xyz in $(dimension) positioned $(target_x) $(target_y) $(target_z) as @a[dx=$(size_x),dy=$(size_y),dz=$(size_z),tag=!terf_unwarpable] run advancement grant @s only terf:warp_core

#unload chunks
$execute in $(dimension) positioned $(target_x) 0 $(target_z) run forceload remove ~ ~ ~$(size_x) ~$(size_z)
$forceload remove ~ ~ ~$(size_x) ~$(size_z)
