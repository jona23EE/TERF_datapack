#terf_data_A = state: 0=offline | 1=warping | 2=overload | 3=detonation
#terf_data_B = blocked blocks count
#terf_data_C = immovable blocks count
#terf_data_D = ship blocks count
#terf_data_E = event timer
#terf_data_F = amount of power stored divided by the amount of power required for 1 block set in the config

#terf_data_R = ship offset x
#terf_data_S = ship offset y
#terf_data_T = ship offset z

#terf_data_U = ship size x
#terf_data_V = ship size y
#terf_data_W = ship size z

#terf_data_X = target x coordinates
#terf_data_Y = target y coordinates
#terf_data_Z = target z coordinates

#Do not continue if the warp core is half loaded
execute unless loaded ~ ~ ~3 run return fail
execute unless loaded ~ ~ ~-3 run return fail
execute unless loaded ~3 ~ ~ run return fail
execute unless loaded ~-3 ~ ~ run return fail

particle end_rod

#======================== Slower Tick Function ========================
execute if score NETratetimer terf_states >= NETrate terf_states run function terf:entity/machines/warp_core/slower_tick

#======================== Run States ========================
execute if score @s terf_data_A matches 1 run function terf:entity/machines/warp_core/states/warp/tick with entity @s data.terf
execute if score @s terf_data_A matches 2 run function terf:entity/machines/warp_core/states/overload/tick with entity @s data.terf
execute if score @s terf_data_A matches 3 run function terf:entity/machines/warp_core/states/detonation/tick

#======================== Display stuff on connected control panels ========================

#structure screen
data modify storage terf:temp displays.structure set value {color:white,has_glowing_text:1b,messages:[{text:"Confinement: \u2714",color:"green"},{text:"Coils: \u2714",color:"green"},{text:"Injector U: \u2714",color:"green"},{text:"Injector D: \u2714",color:"green"}]}
execute if entity @s[tag=!terf_containment] run data modify storage terf:temp displays.structure.messages[0] set value {text:"Confinement: \u26a0",color:"red"}
execute if entity @s[tag=!terf_coils] run data modify storage terf:temp displays.structure.messages[1] set value {text:"Coils: \u26a0",color:"red"}
execute if entity @s[tag=!terf_injector_u] run data modify storage terf:temp displays.structure.messages[2] set value {text:"Injector U: \u26a0",color:"red"}
execute if entity @s[tag=!terf_injector_d] run data modify storage terf:temp displays.structure.messages[3] set value {text:"Injector D: \u26a0",color:"red"}

data modify storage terf:temp displays.power set value {}

#power screen
scoreboard players operation power_stored terf_states = @s terf_data_F
scoreboard players operation power_required terf_states = @s terf_data_D
scoreboard players operation power_buffer terf_states = @s datapipes_lib_power_storage

data modify storage terf:temp displays.power set value {color:cyan,has_glowing_text:1b,messages:[\
{text:"MWt/m³ Stored:",color:"white"},\
{"score":{"objective":"terf_states","name":"power_stored"}},\
[{text:"/"},{"score":{"objective":"terf_states","name":"power_required"}},{text:"m³"}],\
[{text:"Buffer: "},{"score":{"objective":"terf_states","name":"power_buffer"}}]\
]}
execute if score @s terf_data_D matches 2147483647 run data modify storage terf:temp displays.power.messages[2] set value "/ -:- m³"

#fuel screen
scoreboard players operation temp terf_states = 1 terf_states
scoreboard players operation temp2 terf_states = 1 terf_states
scoreboard players operation temp3 terf_states = 20 terf_states
data modify storage terf:temp displays.fuel set value {color:cyan,has_glowing_text:1b,messages:[{text:"Fuel Stored:",color:"white"},[{text:"Interface U: "},{"score":{"objective":"terf_states","name":"temp"}}],[{text:"Interface D: "},{"score":{"objective":"terf_states","name":"temp2"}}],[{text:"Required: "},{"score":{"objective":"terf_states","name":"temp3"}}]]}

#status screen
data modify storage terf:temp displays.status set value {color:cyan,has_glowing_text:1b,messages:["Warp Core Status",{text:"Not Ready",color:"white"},"",""]}
execute if entity @s[tag=terf_ready] run data modify storage terf:temp displays.status.messages[1] set value {text:"Ready",color:"green"}

execute unless score @s terf_data_F >= @s terf_data_D run data modify storage terf:temp displays.status set value {color:yellow,has_glowing_text:1b,messages:["Warp Core Status",{text:"Not enough",color:"gold"},{text:"Power",color:"gold"},""]}

scoreboard players operation blocked terf_states = @s terf_data_C
execute unless score @s terf_data_C matches 0 run data modify storage terf:temp displays.status set value {color:red,has_glowing_text:1b,messages:["Warp Core Status",{text:"Ship Contains",color:"red"},{text:"Immovable Blocks!",color:"red"},[{text:"x",color:"red"},{"score":{"objective":"terf_states","name":"blocked"}}]]}

execute if entity @s[tag=terf_ship_blocks_outside_world] run data modify storage terf:temp displays.status set value {color:red,has_glowing_text:1b,messages:["Warp Core Status",{text:"Ship Bounds",color:"red"},{text:"Outside Of The",color:"red"},{text:"World!",color:"red"}]}

scoreboard players operation immovable terf_states = @s terf_data_B
execute unless score @s terf_data_B matches 0 run data modify storage terf:temp displays.status set value {color:orange,has_glowing_text:1b,messages:["Warp Core Status",{text:"Target Coords",color:"gold"},{text:"Blocked!",color:"gold"},[{text:"x",color:"gold"},{"score":{"objective":"terf_states","name":"immovable"}}]]}

execute if entity @s[tag=terf_target_blocks_outside_world] run data modify storage terf:temp displays.status set value {color:orange,has_glowing_text:1b,messages:["Warp Core Status",{text:"Target Bounds",color:"gold"},{text:"Outside Of The",color:"gold"},{text:"World!",color:"gold"}]}

execute if score @s terf_data_A matches 1 if score @s terf_data_E matches ..250 run data modify storage terf:temp displays.status set value {color:cyan,has_glowing_text:1b,messages:["Warp Core Status",{text:"Charging Up",color:"white"},{text:"Antimatter",color:"white"},[{text:"Hyperdrives...",color:"white"}]]}
execute if score @s terf_data_A matches 1 if score @s terf_data_E matches ..250 run data modify storage terf:temp displays.status.color set value "cyan"

#run on all panels
scoreboard players operation calc terf_states = @s terf_connected_mainframe
$execute at @e[type=marker,tag=terf_linked_to_$(machine_id),tag=terf_warp_core_panel] if score @e[type=marker,distance=..0.01,limit=1] terf_connected_mainframe = calc terf_states if block ^-1 ^ ^ loom if block ^ ^ ^1 waxed_cut_copper run function terf:entity/machines/warp_core_panel/as_core_at_control_panel

#======================== Show range fields ========================
execute if entity @s[tag=!terf_warp_core_show_range] run return fail

scoreboard players operation x terf_states = @s terf_data_U
scoreboard players operation y terf_states = @s terf_data_V
scoreboard players operation z terf_states = @s terf_data_W
execute store result storage terf:temp args.size_x int 1000 run scoreboard players add x terf_states 1
execute store result storage terf:temp args.size_y int 1000 run scoreboard players add y terf_states 1
execute store result storage terf:temp args.size_z int 1000 run scoreboard players add z terf_states 1

#ship position
data modify storage terf:temp args.color set value [0,1,1]

execute store result score x terf_states run data get entity @s Pos[0]
execute store result score y terf_states run data get entity @s Pos[1]
execute store result score z terf_states run data get entity @s Pos[2]
scoreboard players operation x terf_states -= @s terf_data_R
scoreboard players operation y terf_states -= @s terf_data_S
scoreboard players operation z terf_states -= @s terf_data_T
execute store result storage terf:temp args.x int 1 run scoreboard players get x terf_states
execute store result storage terf:temp args.y int 1 run scoreboard players get y terf_states
execute store result storage terf:temp args.z int 1 run scoreboard players get z terf_states

function terf:entity/machines/warp_core/visuals/particle_cube with storage terf:temp args

#target position
data modify storage terf:temp args.color set value [1,.5,0]
data modify storage terf:temp args.dim set from entity @s data.terf.warp_core.dim

execute store result storage terf:temp args.x int 1 run scoreboard players get @s terf_data_X
execute store result storage terf:temp args.y int 1 run scoreboard players get @s terf_data_Y
execute store result storage terf:temp args.z int 1 run scoreboard players get @s terf_data_Z

function terf:entity/machines/warp_core/visuals/particle_cube_dimension with storage terf:temp args