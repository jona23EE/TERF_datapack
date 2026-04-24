data modify entity @s data.terf.multiblock_function set value 'run function terf:entity/machines/mcfr/tick with entity @s data.terf'

tag @s add datapipes_lib_power_consumer
tag @s add datapipes_lib_fluid_generator
tag @s add fluid_filter_terf.hydrogen
tag @s add fluid_filter_water
tag @s add fluid_filter_terf.high_pressure_steam
tag @s add fluid_filter_terf.helium
tag @s add terf_mcfr
execute if block ~ ~ ~ white_glazed_terracotta[facing=west] run tp @s ~ ~ ~-1
execute if block ~ ~ ~ white_glazed_terracotta[facing=south] run tp @s ~-1 ~ ~-1
execute if block ~ ~ ~ white_glazed_terracotta[facing=east] run tp @s ~-1 ~ ~

data modify entity @s data.fluids append value {max:100000,amount:0,id:"water",outpos:"",checks:""}
data modify entity @s data.fluids append value {max:200000,amount:0,id:"terf.high_pressure_steam",outpos:"",checks:"",pipe_on:"function datapipes_lib:require/custom_pipe/pipes_on {axis:quartz_pillar,corner:chiseled_quartz_block}",pipe_off:"function datapipes_lib:require/custom_pipe/pipes_off {axis:quartz_pillar,corner:chiseled_quartz_block}"}
data modify entity @s data.fluids append value {max:100000,amount:0,id:"terf.hydrogen",outpos:"",checks:"",changetype:"terf:entity/machines/mcfr/changetype"}
data modify entity @s data.fluids append value {max:100000,amount:0,id:"empty",outpos:"",checks:"",pipe_on:'function datapipes_lib:require/pipe_presets/lightning_rod/pipes_on',pipe_off:'function datapipes_lib:require/pipe_presets/lightning_rod/pipes_off'}
function terf:entity/machines/mcfr/changetype {new_id:terf.hydrogen}

scoreboard players add @s datapipes_lib_power_storage 0
scoreboard players set @s datapipes_lib_power_max 10000
data modify entity @s data.terf.height set value 0

data modify entity @s data.terf.machine_name set value MCFR
data modify entity @s data.terf.mainframe_logistics.config set value {is_output:1,load:1}
tag @s add terf_mainframe_interested