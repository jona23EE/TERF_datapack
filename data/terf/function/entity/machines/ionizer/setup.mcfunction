tag @s add datapipes_lib_power_consumer
data modify entity @s data.power set value {checks:'if block ~ ~-3 ~ red_glazed_terracotta'}
scoreboard players set @s datapipes_lib_power_max 150000
scoreboard players set @s datapipes_lib_power_storage 0

scoreboard players set @s terf_data_A 0
tag @s add datapipes_lib_fluid_generator
tag @s add fluid_filter_terf.liquified_lapis
tag @s add fluid_filter_terf.lapis_slurry
data modify entity @s data.fluids append value {max:1000,amount:0,id:"terf.liquified_lapis",changetype:"",outpos:"^ ^-1 ^1",checks:"positioned ^ ^-1 ^1 if function terf:require/observer_fluid_checks"}
data modify entity @s data.fluids append value {max:1000,amount:0,id:"terf.lapis_slurry",outpos:"^ ^-1 ^-1",checks:"positioned ^ ^-1 ^-1 if function terf:require/observer_fluid_checks",pipe_on:'function terf:require/observer_output {cmd:"datapipes_lib:require/pipe_presets/lightning_rod/pipes_on"}',pipe_off:'function terf:require/observer_output {cmd:"datapipes_lib:require/pipe_presets/lightning_rod/pipes_off"}'}
