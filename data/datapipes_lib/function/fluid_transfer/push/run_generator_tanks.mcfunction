scoreboard players set total_amount datapipes_lib 0

#turn on pipes
$execute positioned $(outpos) run $(pipe_on)

#count up the total amount of this fluid in the network
$execute as @e[type=marker,tag=datapipes_lib_fluid_generator,tag=fluid_filter_$(id),distance=..2048] at @s run function datapipes_lib:fluid_transfer/push/find_generator_tanks with storage datapipes_lib:temp array[0]

#priorize the fluid going into consumers first, then into fluid tanks, then back into generators
scoreboard players set succeeded datapipes_lib 0
$execute if score total_amount datapipes_lib matches 1.. as @e[type=marker,tag=fluid_filter_$(id),tag=!datapipes_lib_current_fluid_generators,distance=..2048] at @s run function datapipes_lib:fluid_transfer/push/find_consumer_tanks with storage datapipes_lib:temp array[0]
$execute if score total_amount datapipes_lib matches 1.. as @e[type=marker,tag=fluid_filter_$(id),tag=datapipes_lib_current_fluid_consumers,tag=fluid_priority_1,distance=..2048] at @s run function datapipes_lib:fluid_transfer/push/find_consumer_tanks with storage datapipes_lib:temp array[0]
$execute if score total_amount datapipes_lib matches 1.. as @e[type=marker,tag=fluid_filter_$(id),tag=datapipes_lib_current_fluid_generators,tag=fluid_priority_1,distance=..2048] at @s run function datapipes_lib:fluid_transfer/push/find_consumer_tanks with storage datapipes_lib:temp array[0]
$execute if score total_amount datapipes_lib matches 1.. as @e[type=marker,tag=fluid_filter_$(id),tag=datapipes_lib_current_fluid_generators,tag=!fluid_priority_1,distance=..2048] at @s run function datapipes_lib:fluid_transfer/push/find_consumer_tanks with storage datapipes_lib:temp array[0]

#cleanup
tag @e[type=marker,tag=datapipes_lib_current_fluid_generators,distance=..2048] remove datapipes_lib_current_fluid_generators
tag @e[type=marker,tag=datapipes_lib_current_fluid_consumers,distance=..2048] remove datapipes_lib_current_fluid_consumers
$execute positioned $(outpos) run $(pipe_off)
