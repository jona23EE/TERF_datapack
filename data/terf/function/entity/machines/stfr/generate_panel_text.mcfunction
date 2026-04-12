data modify storage terf:temp displays.group_main set value [{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]}]
data modify storage terf:temp displays.group_core set value [{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]}]

scoreboard players set working_systems terf_states 0

#==========| Reactor Status Display
data modify storage terf:temp displays.group_core[0] set value {messages:[\
{text:"Reactor Offline"},\
"",\
"",\
[{text:"\uec11\uec10"},[{text:"\uec12\uec10",color:"black"},{text:"\uec13\uec10",color:"black"},{text:"\uec14\uec10",color:"black"},{text:"\uec15\uec10",color:"black"},{text:"\uec16\uec10",color:"black"}],{text:"\uec17\uec10",color:"black"},{text:"\uec18",color:"white"}]\
],color:"light_gray",has_glowing_text:1b}
execute if entity @s[tag=!terf_case] run data modify storage terf:temp displays.group_core[0].messages[3][3].color set value "red"
#data modify storage terf:temp displays.group_core[0].messages[3][1][].color set value "red"

#==========| Shield Status Display
data modify storage terf:temp displays.group_main[1] set value {messages:[\
" | Shield Status |-",\
{text:"shield offline",color:"gray"},\
"S. Intensity: -%",\
"MSSR: -%"\
],color:"white",has_glowing_text:1b}

execute if entity @s[tag=terf_core_online] run data modify storage terf:temp displays.group_main[1] set value {messages:["| Shield Status |",{text:"normal",color:"green"},["S. Intensity: ",{"score":{"name":"shield_intensity_divided","objective":"terf_states"}},"%"],["MSSR: ",{"score":{"name":"mssr","objective":"terf_states"}},"%"]],color:"white",has_glowing_text:1b}

#==========| Fuel Display
scoreboard players operation calc terf_states = @s terf_data_F
data modify storage terf:temp displays.group_main[5] set value {messages:["","","",""],color:"white",has_glowing_text:1b}

#==========| Core Composition Display
data modify storage terf:temp displays.group_core[2] set value {messages:["Core Composition",[""],[""],["",{"score":{"name":"core_density","objective":"terf_states"}}," mol"]],color:"white",has_glowing_text:1b}
execute if entity @s[tag=!terf_core_online] run data modify storage terf:temp displays.group_core[2].messages[3] set value "-:-"
function terf:entity/machines/stfr_control_panel/core_composition_graph/start

#==========| Shield Stress Display
data modify storage terf:temp displays.group_main[0] set value {messages:["| Shield Stress |",["Pres Strs: ",{"score":{"name":"pressure_shield_stress","objective":"terf_states"}},"%"],["Spin Strs: ",{"score":{"name":"spin_shield_stress","objective":"terf_states"}},"%"],["Rgdt. Strs: ",{"score":{"name":"shield_collapse_stress","objective":"terf_states"}},"%"]],color:"white",has_glowing_text:1b}
execute as @s[tag=!terf_core_online] run data modify storage terf:temp displays.group_main[0].messages set value ["| Shield Stress |","Pres Strs: -%","Spin Strs: -%","Rgdt. Strs: -%"]

#==========| Core Reactivity Graph
data modify storage terf:temp displays.group_core[1] set value {messages:["-| Core Reactivity","","",""],color:"white",has_glowing_text:1b}
execute if score NETratetimer terf_states >= NETrate terf_states run function terf:entity/machines/stfr_control_panel/reactivity_graph/start

data modify storage terf:temp displays.group_core[1].messages[3] set from entity @s data.terf.reactivity_graph

#==========| Lubricant Display
data modify storage terf:temp displays.group_main[9] set value {messages:["--| Lubricant |--",[{"score":{"objective":"terf_states","name":"lubricant_amount"}},"/1000"],"Coolant Level:",[{"score":{"name":"coolant_amount","objective":"terf_states"}},"mB"]],color:"white",has_glowing_text:1b}

#==========| HTR Display
data modify storage terf:temp displays.group_main[8] set value {messages:["| Core Thermals |",["RR: ",{"score":{"objective":"terf_states","name":"total_reaction_rate"}},"r⟨σv⟩"],["HTR: ",{"score":{"name":"heat_transfer_rate_mw","objective":"terf_states"}},"MWₜₕ"],["GAIN: ",{"score":{"name":"core_output_mw","objective":"terf_states"}},"MWₜₕ"]],color:"white",has_glowing_text:1b}
execute if score heat_transfer_rate_divided terf_states matches 1000000.. run data modify storage terf:temp displays.group_main[7].messages[0] set value "HTR: ERROR"

#==========| Generation display
data modify storage terf:temp displays.group_main[7] set value {messages:["-| Generating |-",[{"score":{"name":"rad_generation","objective":"terf_states"}}," MCi"],["CR: ",{"score":{"name":"cooling_rate_mw","objective":"terf_states"}},"MWₜₕ"],[{"score":{"name":"turbine_output","objective":"terf_states"}}," MWₑ"]],color:"white",has_glowing_text:1b}

#==========| Capacitor Charge Display
scoreboard players operation seconds terf_states = @s terf_data_T
scoreboard players operation seconds terf_states /= 20 terf_states

scoreboard players operation minutes terf_states = seconds terf_states
scoreboard players operation minutes terf_states /= 60 terf_states

scoreboard players operation hours terf_states = minutes terf_states
scoreboard players operation hours terf_states /= 60 terf_states

scoreboard players operation minutes terf_states %= 60 terf_states
scoreboard players operation seconds terf_states %= 60 terf_states

scoreboard players reset seconds0 terf_states
scoreboard players reset minutes0 terf_states
execute if score minutes terf_states matches ..9 run scoreboard players set minutes0 terf_states 0
execute if score seconds terf_states matches ..9 run scoreboard players set seconds0 terf_states 0

#calculate capacitor charge digits
scoreboard players operation cap_decimal_0 terf_states = @s terf_data_Ad
scoreboard players operation cap_decimal_1 terf_states = cap_decimal_0 terf_states
scoreboard players operation cap_decimal_2 terf_states = cap_decimal_0 terf_states

scoreboard players operation cap_decimal_0 terf_states /= 10000 terf_states
scoreboard players operation cap_decimal_1 terf_states /= 1000 terf_states
scoreboard players operation cap_decimal_2 terf_states /= 100 terf_states

scoreboard players operation cap_decimal_1 terf_states %= 10 terf_states
scoreboard players operation cap_decimal_2 terf_states %= 10 terf_states

data modify storage terf:temp displays.group_main[6] set value {messages:[\
"Capacitor Charge:",\
[{"score":{"objective":"terf_states","name":"cap_decimal_0"}},".",{"score":{"objective":"terf_states","name":"cap_decimal_1"}},{"score":{"objective":"terf_states","name":"cap_decimal_2"}},"%"],\
"Reactor Uptime: ",\
[{"score":{"objective":"terf_states","name":"hours"}},":",{"score":{"objective":"terf_states","name":"minutes0"}},{"score":{"objective":"terf_states","name":"minutes"}},":",{"score":{"objective":"terf_states","name":"seconds0"}},{"score":{"objective":"terf_states","name":"seconds"}}]\
],color:"white",has_glowing_text:1b}

#==========| Front Displays
data modify storage terf:temp displays.group_main[13] set value {messages:[\
"----| Core |----",\
[{text:"Spin: "},{"score":{"objective":"terf_states","name":"core_spin_divided"}}," RPM"],\
[{text:"T: "},{"score":{"objective":"terf_states","name":"core_temp_3"}},",",{"score":{"objective":"terf_states","name":"core_temp_2"}},",",{"score":{"objective":"terf_states","name":"core_temp_1"}},"°kC"],\
[{text:"P: "},{"score":{"objective":"terf_states","name":"core_pressure"}},"kPa"]\
],color:"white",has_glowing_text:1b}

scoreboard players operation core_temp terf_states = @s terf_data_M

scoreboard players operation core_temp_1 terf_states = core_temp terf_states
scoreboard players operation core_temp_2 terf_states = core_temp terf_states
scoreboard players operation core_temp_3 terf_states = core_temp terf_states

scoreboard players operation core_temp_3 terf_states /= 1000000 terf_states
scoreboard players operation core_temp_2 terf_states /= 1000 terf_states

scoreboard players operation core_temp_1 terf_states %= 1000 terf_states
scoreboard players operation core_temp_2 terf_states %= 1000 terf_states

execute if score core_temp_1 terf_states matches ..99 run data modify storage terf:temp displays.group_main[13].messages[2][4] set value ",0"
execute if score core_temp_1 terf_states matches ..9 run data modify storage terf:temp displays.group_main[13].messages[2][4] set value ",00"

execute if score core_temp_2 terf_states matches ..99 run data modify storage terf:temp displays.group_main[13].messages[2][2] set value ",0"
execute if score core_temp_2 terf_states matches ..9 run data modify storage terf:temp displays.group_main[13].messages[2][2] set value ",00"

execute if score @s terf_data_M matches ..1000000 run scoreboard players reset core_temp_3 terf_states
execute if score @s terf_data_M matches ..1000000 run data modify storage terf:temp displays.group_main[13].messages[2][2] set value ""

execute if score @s terf_data_M matches ..1000 run scoreboard players reset core_temp_2 terf_states
execute if score @s terf_data_M matches ..1000 run data modify storage terf:temp displays.group_main[13].messages[2][4] set value ""




execute if score core_temp terf_states matches 1000000000.. run data modify storage terf:temp displays.group_main[13].messages[2] set value [{text:"T: "},{text:"NaN/Inf",color:"#FF0000"}]

execute as @s[tag=!terf_core_online] run data modify storage terf:temp displays.group_main[13].messages set value ["----| Core |----","Spin: - RPM","T: - °kC","P: - kPa"]

data modify storage terf:temp displays.group_main[14] set value {messages:[\
"----| Case |----",\
[{text:"Pres: "},{"score":{"objective":"terf_states","name":"case_pressure_divided"}},"kPa"],\
[{text:"Temp: "},{"score":{"objective":"terf_states","name":"case_temp_divided"}},"°C"],\
[{text:"SStres: "},{"score":{"objective":"terf_states","name":"shield_stress"}},"%"]\
],color:"white",has_glowing_text:1b}

#controls
scoreboard players operation stabilizer_offset terf_states = @s terf_data_F
data modify storage terf:temp displays.group_main[10] set value {messages:["--------------","Stabilizer Offset",[{"score":{"name":"stabilizer_offset","objective":"terf_states"}},"%"],"--------------"],color:"white",has_glowing_text:1b}

scoreboard players operation shield_permeability terf_states = @s terf_data_G
data modify storage terf:temp displays.group_main[11] set value {messages:["--------------","Shld. Permeability",[{"score":{"name":"shield_permeability","objective":"terf_states"}},"%"],"--------------"],color:"white",has_glowing_text:1b}

scoreboard players operation power_lasers terf_states = @s terf_data_H
data modify storage terf:temp displays.group_main[12] set value {messages:["--------------","Power Lasers",[{"score":{"name":"power_lasers","objective":"terf_states"}},"%"],"--------------"],color:"white",has_glowing_text:1b}

scoreboard players operation pressure_vent terf_states = @s terf_data_I
data modify storage terf:temp displays.group_main[15] set value {messages:["--------------","Pressure Vent",[{"score":{"name":"pressure_vent","objective":"terf_states"}},"%"],"--------------"],color:"white",has_glowing_text:1b}

scoreboard players operation fuel_injection terf_states = @s terf_data_J
data modify storage terf:temp displays.group_main[16] set value {messages:["--------------","Fuel Injection",[{"score":{"name":"fuel_injection","objective":"terf_states"}},"%"],"--------------"],color:"white",has_glowing_text:1b}

scoreboard players operation rf_suppression terf_states = @s terf_data_K
data modify storage terf:temp displays.group_main[17] set value {messages:["--------------","σv RF Suppress.",[{"score":{"name":"rf_suppression","objective":"terf_states"}},"%"],"--------------"],color:"white",has_glowing_text:1b}

scoreboard players operation working_systems terf_states += working_stabs terf_states
execute if score working_turbines terf_states = turbine_count terf_states run scoreboard players add working_systems terf_states 1
execute as @s[tag=terf_case] run scoreboard players add working_systems terf_states 1
execute as @s[tag=!terf_intake_leaking] run scoreboard players add working_systems terf_states 1
execute unless score steam_amount terf_states matches 83580000.. run scoreboard players add working_systems terf_states 1
execute if score @s terf_data_Ac matches 1.. run scoreboard players remove working_systems terf_states 1

#==============================| DISPLAYS THAT DO NOT NEED UPDATING EVERY TICK |==============================
execute unless score NETratetimer terf_states >= NETrate terf_states run return fail

#backpanel controls
data modify storage terf:temp displays.group_main[2] set value {messages:[{text:"/\\"},{text:"Mute Alarms"},{text:"Fit Graph"},{text:"\\/"}],color:white,has_glowing_text:1}
data modify storage terf:temp displays.group_main[3] set value {messages:[{text:"/\\"},{text:"Key"},{text:"SSTB"},{text:"\\/"}],color:white,has_glowing_text:1}
data modify storage terf:temp displays.group_main[4] set value {messages:[{text:"/\\"},{text:"Broadcast"},{text:"Lock Controls"},{text:"\\/"}],color:white,has_glowing_text:1}

#core offline text, which block structure displays
data modify storage terf:temp displays.structure set value [{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""]},{messages:["","","",""],color:light_gray,has_glowing_text:1},{messages:["","","",""],color:light_gray,has_glowing_text:1}]
execute as @s[tag=!terf_breakers_activated] run return run data modify storage terf:temp displays.structure[] set value {messages:["//////////////",{text:"Systems Offline",color:"white"},{text:"Awaiting Startup",color:"white"},"//////////////"],color:gray,has_glowing_text:1}

#structure displays
#==========
data modify storage terf:temp displays.structure[0] set value {messages:[{text:"Stabilizer U: \u2714"},{text:"Stabilizer S: \u2714"},{text:"Stabilizer E: \u2714"},{text:"Stabilizer N: \u2714"}],color:light_gray,has_glowing_text:1b}

execute as @s[tag=terf_breakers_activated] if score stab_1_maintenance terf_states matches 1 run data modify storage terf:temp displays.structure[0].messages[0] set value {text:"Stabilizer U: !!!",color:"yellow"}
execute as @s[tag=!terf_stab1,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[0].messages[0] set value {text:"Stabilizer U: \u26a0",color:"red"}

execute as @s[tag=terf_breakers_activated] if score stab_2_maintenance terf_states matches 1 run data modify storage terf:temp displays.structure[0].messages[1] set value {text:"Stabilizer S: !!!",color:"yellow"}
execute as @s[tag=!terf_stab2,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[0].messages[1] set value {text:"Stabilizer S: \u26a0",color:"red"}

execute as @s[tag=terf_breakers_activated] if score stab_3_maintenance terf_states matches 1 run data modify storage terf:temp displays.structure[0].messages[2] set value {text:"Stabilizer E: !!!",color:"yellow"}
execute as @s[tag=!terf_stab3,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[0].messages[2] set value {text:"Stabilizer E: \u26a0",color:"red"}

execute as @s[tag=terf_breakers_activated] if score stab_4_maintenance terf_states matches 1 run data modify storage terf:temp displays.structure[0].messages[3] set value {text:"Stabilizer N: !!!",color:"yellow"}
execute as @s[tag=!terf_stab4,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[0].messages[3] set value {text:"Stabilizer N: \u26a0",color:"red"}

#==========
data modify storage terf:temp displays.structure[1] set value {messages:[{text:"Stabilizer W: \u2714"},{text:"Stabilizer D: \u2714"},{text:"Case: \u2714"},{text:"Stab. Pistons: \u2714"}],color:light_gray,has_glowing_text:1b}

execute as @s[tag=terf_breakers_activated] if score stab_5_maintenance terf_states matches 1 run data modify storage terf:temp displays.structure[1].messages[0] set value {text:"Stabilizer W: !!!",color:"yellow"}
execute as @s[tag=!terf_stab5,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[1].messages[0] set value {text:"Stabilizer W: \u26a0",color:"red"}

execute as @s[tag=terf_breakers_activated] if score stab_6_maintenance terf_states matches 1 run data modify storage terf:temp displays.structure[1].messages[1] set value {text:"Stabilizer D: !!!",color:"yellow"}
#execute if score @s terf_data_Ac matches 1.. as @s[tag=terf_stab6,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[1].messages[1] set value {text:"Stabilizer D: OL",color:"gold"}
execute as @s[tag=!terf_stab6,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[1].messages[1] set value {text:"Stabilizer D: \u26a0",color:"red"}

execute as @s[tag=terf_breakers_activated] if score case_maintenance terf_states matches 1 run data modify storage terf:temp displays.structure[1].messages[2] set value {text:"Case: !!!",color:"yellow"}
execute as @s[tag=!terf_case,tag=terf_breakers_activated] run data modify storage terf:temp displays.structure[1].messages[2] set value {text:"Case: \u26a0",color:"red"}

execute if entity @s[tag=!terf_stab_pistons] run data modify storage terf:temp displays.structure[1].messages[3] set value {text:"Stab. Pistons: \u26a0",color:"red"}

#==========
data modify storage terf:temp displays.structure[2] set value {messages:[{text:"Cool. Intake: \u2714"},{text:"Steam Buffer: \u2714"},[{text:"Turbines: "},{"score":{"name":"working_turbines","objective":"terf_states"}},"/",{"score":{"name":"turbine_count","objective":"terf_states"}}],""],color:light_gray,has_glowing_text:1b}

execute as @s[tag=terf_intake_leaking] run data modify storage terf:temp displays.structure[2].messages[0] set value {text:"Cool. Intake: \u26a0",color:"red"}

execute as @s[tag=terf_outtake_blocked] unless score steam_amount terf_states matches 83580000.. run data modify storage terf:temp displays.structure[2].messages[1] set value {text:"Steam Buffer: F",color:"gold"}
execute as @s[tag=terf_outtake_blocked] if score steam_amount terf_states matches 83580000.. run data modify storage terf:temp displays.structure[2].messages[1] set value {text:"Steam Buffer: \u26a0",color:"red"}

execute unless score working_turbines terf_states = turbine_count terf_states run data modify storage terf:temp displays.structure[2].messages[2][0].color set value "red"
execute if score turbine_count terf_states matches 0 run data modify storage terf:temp displays.structure[2].messages[2] set value {text:"Turbines: -:-",color:"gray"}

#==========
scoreboard players set lowest_amount terf_states 2147483647
data modify storage terf:temp array set value []
$execute positioned ~20 ~40 ~30 as @e[type=interaction,tag=terf_related_$(machine_id),tag=terf_receptacle,sort=nearest] at @s run function terf:entity/machines/stfr_control_panel/capsule_display/as_all_receptacles with entity @s data.terf
scoreboard players operation @s terf_data_Y = lowest_amount terf_states

data modify storage terf:temp displays.structure[3].messages[0] set value {text:"                     ",underlined:1b}
data modify storage terf:temp displays.structure[4].messages[0] set value {text:"    Fuel Capsules",underlined:1b}

data modify storage terf:temp displays.structure[4].messages[1] set from storage terf:temp array[0]
data modify storage terf:temp displays.structure[4].messages[2] set from storage terf:temp array[1]
data modify storage terf:temp displays.structure[4].messages[3] set from storage terf:temp array[2]
data modify storage terf:temp displays.structure[3].messages[1] set from storage terf:temp array[3]
data modify storage terf:temp displays.structure[3].messages[2] set from storage terf:temp array[4]
data modify storage terf:temp displays.structure[3].messages[3] set from storage terf:temp array[5]

#==========
#color screens
execute unless score working_systems terf_states matches 10 run return run data modify storage terf:temp displays.structure[].color set value "gray"
execute if score maintenance terf_states matches 1 run return run data modify storage terf:temp displays.structure[].color set value "gray"
