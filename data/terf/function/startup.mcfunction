data remove storage terf:constants fluid_dictionary
#==================================================| Scoreboard Objectives |==================================================
scoreboard objectives add terf_coas_click minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add terf_leftgame minecraft.custom:minecraft.leave_game
scoreboard objectives add terf_deaths deathCount
scoreboard objectives add terf_usedcreeperspawnegg minecraft.used:minecraft.creeper_spawn_egg
scoreboard objectives add terf_snowballs_thrown minecraft.used:minecraft.snowball
scoreboard objectives add terf_trigger trigger
scoreboard objectives add terf_states dummy
scoreboard objectives add terf_scorelink dummy
scoreboard objectives add terf_connected_mainframe_buffer dummy
scoreboard objectives add terf_connected_mainframe dummy
scoreboard objectives add terf_shake_magnitude dummy
scoreboard objectives add terf_shake_frequency dummy
scoreboard objectives add terf_broke_glass_0 minecraft.mined:minecraft.glass_pane
scoreboard objectives add terf_broke_glass_1 minecraft.mined:minecraft.glass
scoreboard objectives add terf_broke_lapis_block minecraft.mined:minecraft.lapis_block
scoreboard objectives add terf_placed_lapis_block minecraft.used:minecraft.lapis_block

scoreboard objectives add terf_data_A dummy
scoreboard objectives add terf_data_B dummy
scoreboard objectives add terf_data_C dummy
scoreboard objectives add terf_data_D dummy
scoreboard objectives add terf_data_E dummy
scoreboard objectives add terf_data_F dummy
scoreboard objectives add terf_data_G dummy
scoreboard objectives add terf_data_H dummy
scoreboard objectives add terf_data_I dummy
scoreboard objectives add terf_data_J dummy
scoreboard objectives add terf_data_K dummy
scoreboard objectives add terf_data_L dummy
scoreboard objectives add terf_data_M dummy
scoreboard objectives add terf_data_N dummy
scoreboard objectives add terf_data_O dummy
scoreboard objectives add terf_data_P dummy
scoreboard objectives add terf_data_Q dummy
scoreboard objectives add terf_data_R dummy
scoreboard objectives add terf_data_S dummy
scoreboard objectives add terf_data_T dummy
scoreboard objectives add terf_data_U dummy
scoreboard objectives add terf_data_V dummy
scoreboard objectives add terf_data_W dummy
scoreboard objectives add terf_data_X dummy
scoreboard objectives add terf_data_Y dummy
scoreboard objectives add terf_data_Z dummy
scoreboard objectives add terf_data_Aa dummy
scoreboard objectives add terf_data_Ab dummy
scoreboard objectives add terf_data_Ac dummy
scoreboard objectives add terf_data_Ad dummy
scoreboard objectives add terf_data_Ae dummy
scoreboard objectives add terf_data_Af dummy
scoreboard objectives add terf_data_Ag dummy
scoreboard objectives add terf_data_Ah dummy
scoreboard objectives add terf_data_Ai dummy
scoreboard objectives add terf_data_Aj dummy
scoreboard objectives add terf_data_Ak dummy
scoreboard objectives add terf_data_Al dummy
scoreboard objectives add terf_data_Am dummy
scoreboard objectives add terf_data_An dummy
scoreboard objectives add terf_data_Ao dummy

#==================================================| Set Configs And Detect Syntax Errors |==================================================
scoreboard players set debug_features terf_states 0

gamerule max_command_sequence_length 2147483647
gamerule max_command_forks 2147483647
gamerule max_block_modifications 2147483647

execute in terf:intermediary_technical_storage_dimension run gamerule max_command_sequence_length 2147483647
execute in terf:intermediary_technical_storage_dimension run gamerule max_command_forks 2147483647
execute in terf:intermediary_technical_storage_dimension run gamerule max_block_modifications 2147483647

scoreboard players set hassyntaxerrors terf_states 1
execute store success score hassyntaxerrors terf_states run function terf:config
execute if score hassyntaxerrors terf_states matches 0 run tellraw @a [{"text":"["},{"text":"S","color":"red"},{"text":"Y","color":"gold"},{"text":"S","color":"yellow"},{"text":"T","color":"green"},{"text":"E","color":"aqua"},{"text":"M","color":"green"},{"text":"] "},{"text":"SYNTAX ERRORS! Config loading failed!","color":"red"}]
execute if score hassyntaxerrors terf_states matches 0 run playsound terf:vase master @a[distance=0..] ~ ~ ~ 10000000000000

#convert configs into more usable values
scoreboard players operation medium_turbine_steam_per_drum terf_states = medium_turbine_mw_per_drum terf_states
scoreboard players operation medium_turbine_steam_per_drum terf_states *= medium_turbine_gen_divider terf_states

scoreboard players operation medium_turbine_mw_per_drum terf_states *= 100 terf_states

#base turbine capacity
scoreboard players set large_turbine_steam_capacity terf_states 2000

scoreboard players operation large_turbine_steam_capacity terf_states *= 10 terf_states
scoreboard players operation large_turbine_steam_capacity terf_states *= NETrate terf_states
scoreboard players operation large_turbine_steam_capacity terf_states /= 67 terf_states

scoreboard players operation large_turbine_water_capacity terf_states = large_turbine_steam_capacity terf_states
scoreboard players operation large_turbine_steam_capacity terf_states *= 167 terf_states

#==================================================| Misc |==================================================
#falling block unloading temp thingy
forceload add 30000000 19999999
execute in terf:intermediary_technical_storage_dimension run forceload add 29999999 29999999

#gametime syncer
execute in terf:intermediary_technical_storage_dimension positioned 30000000 255 30000000 unless block ~ ~ ~ repeating_command_block run setblock ~ ~ ~ minecraft:repeating_command_block{TrackOutput:1b,auto:1b,Command:"."}
scoreboard players operation game_time terf_states = real_time terf_states

#no idea what this is used for
kill @e[tag=terf_tempentity]

#disabled because non papermc servers have global gamerules
#execute in terf:orbit_earth run function terf:space_setup
#execute in terf:orbit_end run function terf:space_setup

#==================================================| Custom Fluids |==================================================
#n=neutrons | p=protons | y=gamma rays | e+=positrons | v=electron neutrinos | e=electrons
#in_per_out (input per output) is the amount of the input fluid required to make 1 of the output fluid (for example 4 means you need 4 hydrogen for 1 helium, -6 means 1 hydrogen makes 6 helium) 
#required and released keV is per input

#set fluid properties
data modify storage terf:constants fluid_dictionary.empty set value {chem:{text:"Empty",color:"#696969"}, name:"Empty", color_hex:"#696969", color_dec:6908265, temp:20, replacable:1}
data modify storage terf:constants fluid_dictionary.water set value {chem:{text:"H²O",color:"#3C4DE6"}, name:"Water", color_hex:"#3C4DE6", color_dec:3952102, temp:20}
data modify storage terf:constants fluid_dictionary.terf.depleted_water set value {chem:{text:"P²O",color:"#3C4DE6"}, name:"Depleted Water", color_hex:"#3C4DE6", color_dec:3952102, temp:20}
data modify storage terf:constants fluid_dictionary.terf.heavy_water set value {chem:{text:"D²O",color:"#2c38a3"}, name:"Heavy Water", color_hex:"#2c38a3", color_dec:2898083, temp:20}
data modify storage terf:constants fluid_dictionary.terf.high_pressure_steam set value {chem:{text:"H²O",color:"#998181"}, name:"High Pressure Steam", color_hex:"#998181", color_dec:10060161, temp:210, pressure:10}
data modify storage terf:constants fluid_dictionary.terf.mineral_magma set value {chem:{text:"?",color:"#C36E29"}, name:"Mineral Magma", color_hex:"#C36E29", color_dec:12807721, temp:700}
data modify storage terf:constants fluid_dictionary.terf.gold_slurry set value {chem:{text:"Au(aq)",color:"#A18900"}, name:"Gold Slurry", color_hex:"#A18900", color_dec:10586368, temp:20, lubricant:10}
data modify storage terf:constants fluid_dictionary.terf.hydrogen set value {chem:{text:"H",color:"#3A74FF"}, name:"Hydrogen", color_hex:"#3A74FF", color_dec:3831039, temp:20, flammability:5, toxicity:2, fusion:{in_per_out:4, result:"terf.helium", required_keV:600, released_keV:6200, particles:{n:0,p:0,y:2,e+:2,v:2,e:0}}}
data modify storage terf:constants fluid_dictionary.terf.antihydrogen set value {chem:{text:"H̄",color:"#3A74FF"}, name:"Antihydrogen", color_hex:"#3A74FF", antimatter:1, color_dec:3831039, temp:20, pressure:100, shc_per_mole:27.15129792, flammability:5, toxicity:2, fusion:{reactivity_function:"terf:fluid_functions/antihydrogen_reactivity", reactivity_peak:200000, peak_kev:2715, in_per_out:4, result:"terf.antihelium", required_keV:0, released_keV:999999, kev_total:3650}}
data modify storage terf:constants fluid_dictionary.terf.deuterium set value {chem:{text:"D",color:"#2A64EF"}, name:"Deuterium", color_hex:"#2A64EF", color_dec:2778351, temp:20, flammability:5, toxicity:2, shc_per_mole:27.15129792, fusion:{reactivity_function:"terf:fluid_functions/deuterium_reactivity", reactivity_peak:200000, peak_kev:2715, in_per_out:4, result:"terf.helium", kev_total:3650}}
data modify storage terf:constants fluid_dictionary.terf.oxygen set value {chem:{text:"O²",color:"#81CFFF"}, name:"Oxygen", color_hex:"#81CFFF", color_dec:8507391, temp:20, corrosivity:1}
data modify storage terf:constants fluid_dictionary.terf.helium set value {chem:{text:"He",color:"#FC7703"}, name:"Helium", color_hex:"#FC7703", color_dec:16545539, temp:20, toxicity:1, shc_per_mole:20.785512186}
data modify storage terf:constants fluid_dictionary.terf.palladium_group_sludge set value {chem:{text:"Pd(aq)",color:"#80A4B1"}, name:"Palladium Group Sludge", color_hex:"#80A4B1", color_dec:8430769, temp:20}
data modify storage terf:constants fluid_dictionary.terf.lapis_slurry set value {chem:{text:"Laζ⁺",color:"#1C4D9C"}, name:"Lapis Slurry", color_hex:"#2A64EF", color_dec:1854876, temp:40, toxicity:2, shc_per_mole:40.0, fusion:{reactivity_function:"terf:fluid_functions/lapis_slurry_reactivity", reactivity_peak:30000, peak_kev:2715, in_per_out:4, result:"terf.ionized_sulfur_trioxide", kev_total:3650}}
data modify storage terf:constants fluid_dictionary.terf.ionized_sulfur_trioxide set value {chem:{text:"SO₃⁺(g)",color:"#ECDB21"}, name:"Ionized Sulfur Trioxide", color_hex:"#ECDB21", color_dec:323621933, temp:290,corrosivity:10,toxicity:10,flammability:5}
data modify storage terf:constants fluid_dictionary.terf.liquified_lapis set value {chem:{text:"La(I)",color:"#1C4D9C"}, name:"Liquified Lapis", color_hex:"#1C4D9C", color_dec:1854876, temp:20}


#==================================================| Custom Items |==================================================
#set the constants of materials, aka link their ids to a components so functions can summon or give them
data modify storage terf:constants materials.copper_dust set value {item_name:"Copper Dust",item_model:"terf:material/bright/dust_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_plate set value {item_name:"Copper Plate",item_model:"terf:material/bright/plate_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_foil set value {item_name:"Copper Foil",item_model:"terf:material/bright/foil_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_rod set value {item_name:"Copper Rod",item_model:"terf:material/bright/rod_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_bar set value {item_name:"Copper Bar",item_model:"terf:material/bright/rod_long_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_bolt set value {item_name:"Copper Bolt",item_model:"terf:material/bright/bolt_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_wire set value {item_name:"Copper Wire",item_model:"terf:material/bright/wire_fine_overlay",custom_model_data:{colors:[I;14840394,16777215]}}
data modify storage terf:constants materials.copper_ring set value {item_name:"Copper Ring",item_model:"terf:material/bright/ring_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_screw set value {item_name:"Copper Screw",item_model:"terf:material/bright/screw_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_rotor set value {item_name:"Copper Rotor",item_model:"terf:material/bright/rotor_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.copper_spring set value {item_name:"Copper Spring",item_model:"terf:material/bright/spring_overlay",custom_model_data:{colors:[I;14840394,16770769]}}
data modify storage terf:constants materials.small_copper_spring set value {item_name:"Small Copper Spring",item_model:"terf:material/bright/spring_small_overlay",custom_model_data:{colors:[I;14840394,16770769]}}

data modify storage terf:constants materials.copper_extrusion_mold_bar set value {item_name:"Copper Extrusion Mold: Bar",item_model:"terf:material/dull/extrusion_mold_bar_secondary",custom_model_data:{colors:[I;14840394,16777215,16770769]},custom_data:{tag:"extrusion_mold_bar"},max_stack_size:1,max_damage:100}
data modify storage terf:constants materials.copper_extrusion_mold_roller set value {item_name:"Copper Extrusion Mold: Roller",item_model:"terf:material/dull/extrusion_mold_roller_secondary",custom_model_data:{colors:[I;14840394,16777215,14840394]},custom_data:{tag:"extrusion_mold_roller"},max_stack_size:1,max_damage:100}
data modify storage terf:constants materials.copper_extrusion_mold_threading set value {item_name:"Copper Extrusion Mold: Threading",item_model:"terf:material/dull/extrusion_mold_threading_secondary",custom_model_data:{colors:[I;14840394,16777215,14840394]},custom_data:{tag:"extrusion_mold_threading"},max_stack_size:1,max_damage:100}

data modify storage terf:constants materials.netherite_dust set value {item_name:"Netherite Dust",item_model:"terf:material/metallic/dust_secondary",custom_model_data:{colors:[I;5984593,4868425]}}
data modify storage terf:constants materials.netherite_plate set value {item_name:"Netherite Plate",item_model:"terf:material/metallic/plate_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_foil set value {item_name:"Netherite Foil",item_model:"terf:material/bright/foil_overlay",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_rod set value {item_name:"Netherite Rod",item_model:"terf:material/metallic/rod_overlay",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_bar set value {item_name:"Netherite Bar",item_model:"terf:material/metallic/rod_long_overlay",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_bolt set value {item_name:"Netherite Bolt",item_model:"terf:material/metallic/bolt_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_wire set value {item_name:"Netherite Wire",item_model:"terf:material/bright/wire_fine_secondary",custom_model_data:{colors:[I;5984593,16777215,4868425]}}
data modify storage terf:constants materials.netherite_ring set value {item_name:"Netherite Ring",item_model:"terf:material/bright/ring_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_screw set value {item_name:"Netherite Screw",item_model:"terf:material/metallic/screw_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_rotor set value {item_name:"Netherite Rotor",item_model:"terf:material/bright/rotor_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.netherite_spring set value {item_name:"Netherite Spring",item_model:"terf:material/bright/spring_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]}}
data modify storage terf:constants materials.small_netherite_spring set value {item_name:"Small Netherite Spring",item_model:"terf:material/bright/spring_small_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]}}

data modify storage terf:constants materials.netherite_extrusion_mold_bar set value {item_name:"Netherite Extrusion Mold: Bar",item_model:"terf:material/dull/extrusion_mold_bar_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]},custom_data:{tag:"extrusion_mold_bar"},max_stack_size:1,max_damage:6000}
data modify storage terf:constants materials.netherite_extrusion_mold_roller set value {item_name:"Netherite Extrusion Mold: Roller",item_model:"terf:material/dull/extrusion_mold_roller_secondary",custom_model_data:{colors:[I;5984593,16777215,10066072]},custom_data:{tag:"extrusion_mold_roller"},max_stack_size:1,max_damage:6000}
data modify storage terf:constants materials.netherite_extrusion_mold_threading set value {item_name:"Netherite Extrusion Mold: Threading",item_model:"terf:material/dull/extrusion_mold_threading_secondary",custom_model_data:{colors:[I;5984593,10066072,4868425]},custom_data:{tag:"extrusion_mold_threading"},max_stack_size:1,max_damage:6000}

data modify storage terf:constants materials.gold_dust set value {item_name:"Gold Dust",item_model:"terf:material/shiny/dust_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_plate set value {item_name:"Gold Plate",item_model:"terf:material/shiny/plate_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_foil set value {item_name:"Gold Foil",item_model:"terf:material/shiny/foil_overlay",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_rod set value {item_name:"Gold Rod",item_model:"terf:material/shiny/rod_overlay",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_bar set value {item_name:"Gold Bar",item_model:"terf:material/shiny/rod_long_overlay",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_bolt set value {item_name:"Gold Bolt",item_model:"terf:material/shiny/bolt_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_wire set value {item_name:"Gold Wire",item_model:"terf:material/shiny/wire_fine_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_ring set value {item_name:"Gold Ring",item_model:"terf:material/shiny/ring_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_screw set value {item_name:"Gold Screw",item_model:"terf:material/shiny/screw_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_rotor set value {item_name:"Gold Rotor",item_model:"terf:material/shiny/rotor_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.gold_spring set value {item_name:"Gold Spring",item_model:"terf:material/shiny/spring_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}
data modify storage terf:constants materials.small_gold_spring set value {item_name:"Small Gold Spring",item_model:"terf:material/shiny/spring_small_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]}}

data modify storage terf:constants materials.gold_extrusion_mold_bar set value {item_name:"Gold Extrusion Mold: Bar",item_model:"terf:material/dull/extrusion_mold_bar_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]},custom_data:{tag:"extrusion_mold_bar"},max_stack_size:1,max_damage:32}
data modify storage terf:constants materials.gold_extrusion_mold_roller set value {item_name:"Gold Extrusion Mold: Roller",item_model:"terf:material/dull/extrusion_mold_roller_secondary",custom_model_data:{colors:[I;16707885,16777215]},custom_data:{tag:"extrusion_mold_roller"},max_stack_size:1,max_damage:32}
data modify storage terf:constants materials.gold_extrusion_mold_threading set value {item_name:"Gold Extrusion Mold: Threading",item_model:"terf:material/dull/extrusion_mold_threading_secondary",custom_model_data:{colors:[I;16707885,16777215,15375360]},custom_data:{tag:"extrusion_mold_threading"},max_stack_size:1,max_damage:32}

data modify storage terf:constants materials.iron_dust set value {item_name:"Iron Dust",item_model:"terf:material/dull/dust",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_plate set value {item_name:"Iron Plate",item_model:"terf:material/dull/plate",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_foil set value {item_name:"Iron Foil",item_model:"terf:material/dull/foil",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_rod set value {item_name:"Iron Rod",item_model:"terf:material/dull/rod",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_bar set value {item_name:"Iron Bar",item_model:"terf:material/dull/rod_long",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_bolt set value {item_name:"Iron Bolt",item_model:"terf:material/dull/bolt",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_wire set value {item_name:"Iron Wire",item_model:"terf:material/dull/wire_fine_overlay",custom_model_data:{colors:[I;16777215,16777215]}}
data modify storage terf:constants materials.iron_ring set value {item_name:"Iron Ring",item_model:"terf:material/dull/ring",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_screw set value {item_name:"Iron Screw",item_model:"terf:material/dull/screw",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_rotor set value {item_name:"Iron Rotor",item_model:"terf:material/dull/rotor",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.iron_spring set value {item_name:"Iron Spring",item_model:"terf:material/dull/spring",custom_model_data:{colors:[I;16777215]}}
data modify storage terf:constants materials.small_iron_spring set value {item_name:"Small Iron Spring",item_model:"terf:material/dull/spring_small",custom_model_data:{colors:[I;16777215]}}

data modify storage terf:constants materials.iron_extrusion_mold_bar set value {item_name:"Iron Extrusion Mold: Bar",item_model:"terf:material/dull/extrusion_mold_bar_secondary",custom_model_data:{colors:[I;16777215]},custom_data:{tag:"extrusion_mold_bar"},max_stack_size:1,max_damage:200}
data modify storage terf:constants materials.iron_extrusion_mold_roller set value {item_name:"Iron Extrusion Mold: Roller",item_model:"terf:material/dull/extrusion_mold_roller_secondary",custom_model_data:{colors:[I;16777215]},custom_data:{tag:"extrusion_mold_roller"},max_stack_size:1,max_damage:200}
data modify storage terf:constants materials.iron_extrusion_mold_threading set value {item_name:"Iron Extrusion Mold: Threading",item_model:"terf:material/dull/extrusion_mold_threading_secondary",custom_model_data:{colors:[I;16777215]},custom_data:{tag:"extrusion_mold_threading"},max_stack_size:1,max_damage:200}

data modify storage terf:constants materials.amethyst_dust set value {item_name:"Amethyst Dust",item_model:"terf:material/shiny/dust_secondary",custom_model_data:{colors:[I;13542398,16777215,10584063]}}

data modify storage terf:constants materials.terf:palladium_group_metal set value {item_name:"Palladium Group Metal",item_model:"terf:material/lapis/gem_secondary",custom_model_data:{colors:[I;8430769,8223868]}}
data modify storage terf:constants materials.terf:palladium_group_metal_dust set value {item_name:"Palladium Group Metal Dust",item_model:"terf:material/dull/dust_secondary",custom_model_data:{colors:[I;8430769,8223868]}}
data modify storage terf:constants materials.terf:nanopore_palladium_catalyst set value {item_name:"Nanopore Palladium Catalyst",item_model:"terf:material/dull/gem_overlay",custom_model_data:{colors:[I;8430769,14605789]}}

data modify storage terf:constants materials.terf:heat_sink set value {item_name:"Heat Sink",item_model:"terf:part/heat_sink"}
data modify storage terf:constants materials.terf:motor_hv set value {item_name:"Brushless Motor",item_model:"terf:part/motor_hv"}
data modify storage terf:constants materials.terf:electron_thruster set value {item_name:"Electron Thruster",item_model:"terf:part/electron_thruster"}
data modify storage terf:constants materials.terf:laser_diode_lv set value {item_name:"Low Voltage Laser Diode",item_model:"terf:part/laser_diode_lv"}
data modify storage terf:constants materials.terf:laser_diode_hv set value {item_name:"High Voltage Laser Diode",item_model:"terf:part/laser_diode_hv"}
data modify storage terf:constants materials.terf:battery_mv set value {item_name:"Medium Voltage Battery",item_model:"terf:part/battery_mv"}
data modify storage terf:constants materials.terf:heat_sink set value {item_name:"Heat Sink",item_model:"terf:part/heat_sink"}
data modify storage terf:constants materials.terf:magnetron set value {item_name:"Magnetron",item_model:"terf:part/magnetron"}

#tools | Syntax tips: Put a space after every , in the root object | long stuff like lore always goes last, the first things should always be id:, item_name:, item_model:, custom_data:
data modify storage terf:constants materials.terf:multiblock_core set value {id:creeper_spawn_egg, item_name:"Multiblock Core", item_model:"terf:visual/multiblock_core", entity_data:{id:"minecraft:marker", Tags:["terf_multiblockcore"]}, lore:[{"text":"Controller of all multiblock","italic":false},{"text":"structures!","italic":false},{"text":"Right click on the ground to","italic":false,"color":"gray"},{"text":"place it, then put the","italic":false,"color":"gray"},{"text":"required block into it.","italic":false,"color":"gray"},{"text":"Break the block in it to","italic":false,"color":"gray"},{"text":"get it back.","italic":false,"color":"gray"},{"text":"!!! ROTATION MATTERS !!!","italic":false,"color":"red"}]}

data modify storage terf:constants materials.terf:art_base set value {id:creeper_spawn_egg, item_name:"A.R.T Base", item_model:"terf:visual/art/base", custom_data:{terf:{}}, rarity:rare , max_stack_size:1, entity_data:{id:"minecraft:item_display",Rotation:[0f,0f],Tags:["terf_vehicle","terf_art"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-0.125f,0f],scale:[1f,1f,1f]},item:{id:"minecraft:carrot_on_a_stick",count:1,components:{item_model:"terf:visual/art/base"}}}, lore:[{"text":"Right click with an A.R.T Mount and an A.R.T Turret to assemble.","italic":false}]}

data modify storage terf:constants materials.terf:multimeter set value {id:carrot_on_a_stick, item_name:"Multimeter", item_model:"terf:tool/multimeter", custom_data:{rechargable:1b,terf:{click:"terf:entity/player/tool/multimeter/activated"}}}

data modify storage terf:constants materials.terf:dosimeter set value {id:carrot_on_a_stick, item_name:"Dosimeter", item_model:"terf:tool/dosimeter", custom_data:{terf:{held:"terf:entity/player/tool/dosimeter/held"}}}

data modify storage terf:constants materials.terf:hard_hat set value {id:carrot_on_a_stick, item_name:"Hard Hat", item_model:"terf:tool/hard_hat", custom_data:{terf:{click:"terf:entity/player/tool/hard_hat/activated",click_offhand:""}}, lore:[{"text":"Cosmetic","italic":false,"color":"gray"},{"text":"Right click to equip","italic":false,"color":"dark_purple"},{"text":"Trust me, I\'m an engineer!","italic":false,"color":"green"}]}

data modify storage terf:constants materials.terf:laser_pistol set value {id:carrot_on_a_stick, item_name:"Laser Pistol", item_model:"terf:tool/laser_pistol", custom_data:{rechargable:1b,terf:{held:"terf:entity/player/tool/laser_pistol/held",held_offhand:"terf:entity/player/tool/laser_pistol/held_offhand",click:"terf:entity/player/tool/laser_pistol/activated",click_offhand:"terf:entity/player/tool/laser_pistol/activated_offhand"}}, rarity:rare, max_damage:10000, lore:[{"text":"Hold in offhand for scope","italic":false},"",{"text":"When in Main Hand:","italic":false,"color":"gray"},{"text":" 0.2 Tool Cooldown","italic":false,"color":"dark_green"}]}

data modify storage terf:constants materials.terf:taser set value {id:carrot_on_a_stick, item_name:"Taser", item_model:"terf:tool/taser", custom_data:{rechargable:1b, terf:{rechargable:1b,click:"terf:entity/player/tool/taser/activated",click_offhand:"terf:entity/player/tool/taser/activated_offhand"}}, rarity:rare, max_damage:10000, damage_resistant:{types:"#minecraft:is_fire"}, lore:["",{"text":"When in Main Hand:","italic":false,"color":"gray"},{"text":" 1.5 Tool Cooldown","italic":false,"color":"dark_green"}]}

data modify storage terf:constants materials.terf:wrench set value {id:carrot_on_a_stick, item_name:"Wrench", item_model:"terf:tool/wrench", custom_data:{terf:{click:"terf:entity/player/tool/wrench/activated"}}, max_damage:500, attribute_modifiers:[{type:"attack_damage",amount:2,slot:mainhand,id:"attack_damage",operation:add_value}]}

data modify storage terf:constants materials.terf:photon_cannon set value {id:carrot_on_a_stick, item_name:"Photon Cannon", item_model:"terf:tool/photon_cannon", custom_data:{rechargable:1b,terf:{click:"terf:entity/player/tool/photon_cannon/activated"}}, rarity:rare, max_damage:100000, damage_resistant:{types:"#minecraft:is_fire"}, lore:["",{"text":"When in Main Hand:","italic":false,"color":"gray"},{"text":" 3 Tool Cooldown","italic":false,"color":"dark_green"}]}
data modify storage terf:constants materials.terf:overdrive_photon_cannon set value {id:carrot_on_a_stick, enchantment_glint_override:true, item_name:{text:"Overdrive Photon Cannon",color:"#FF0000"}, item_model:"terf:tool/photon_cannon", custom_data:{rechargable:1b,terf:{click:"terf:entity/vehicle/mrt/shoot"}}, rarity:rare, max_damage:100000, damage_resistant:{types:"#minecraft:is_fire"}}

data modify storage terf:constants materials.terf:linker set value {id:carrot_on_a_stick, item_name:"Linker", item_model:"terf:tool/linker", custom_data:{terf:{click:"terf:entity/player/tool/linker/activated",click_offhand:""}}, lore:[{"text":"Links: 0","italic":false,"color":"dark_gray"},{"text":"Right-click on an interactable block to add/remove to the list","italic":false,"color":"gray"},{"text":"Shift-ctrl-right-click while not moving to clear the list","italic":false,"color":"gray"},{"text":"Right-click on a machines multiblock core to apply list","italic":false,"color":"gray"}]}

data modify storage terf:constants materials.terf:plasma_pickaxe set value {id:netherite_pickaxe, item_name:"Plasma Pickaxe", item_model:"terf:tool/plasma_pickaxe", custom_data:{rechargable:1b}, max_damage:2000, rarity:epic, attribute_modifiers:[{type:"attack_damage",amount:13,slot:mainhand,id:"attack_damage",operation:add_value},{type:"attack_speed",amount:-3,slot:mainhand,id:"attack_speed",operation:add_value}], tool:{rules:[{speed:40,correct_for_drops:true,blocks:"#mineable/pickaxe"},{speed:10,blocks:"#mineable/shovel"},{speed:40,blocks:"#mineable/axe"},{speed:5,blocks:"#mineable/hoe"}]}}

data modify storage terf:constants materials.terf:fluid_id set value {id:carrot_on_a_stick, item_name:"Fluid ID Tool", item_model:"terf:tool/fluid_id", custom_data:{terf:{click:"terf:entity/player/tool/fluid_id/activated",click_offhand:""}}}

data modify storage terf:constants materials.terf:crane_remote set value {id:carrot_on_a_stick, item_name:"Crane Remote", item_model:"terf:tool/crane_remote", custom_data:{terf:{held:"terf:entity/player/tool/crane_remote/held",click:"terf:entity/player/tool/crane_remote/activated",click_offhand:""}},lore:[{"text":"Right-click the direction you want the crane to go","italic":false,"color":"gray"},{"text":"Look down and Right-click to lower winch","italic":false,"color":"gray"},{"text":"Look down and Shift-right-click to raise winch","italic":false,"color":"gray"},{"text":"Look up and Right-click to detach payload","italic":false,"color":"gray"}]}

data modify storage terf:constants materials.terf:syringe set value {id:carrot_on_a_stick, item_name:"Syringe", item_model:"terf:tool/syringe", custom_data:{terf:{click:"terf:entity/player/tool/syringe/activated",click_offhand:""}}, custom_model_data:{colors:[I;0],floats:[0]}}

data modify storage terf:constants materials.terf:monocular set value {id:carrot_on_a_stick, item_name:"Neutron Monocular", item_model:"terf:tool/binoculars", custom_data:{terf:{click:"terf:entity/player/tool/monocular/activated",held:"terf:entity/player/tool/monocular/held"}}, rarity:rare}

data modify storage terf:constants materials.terf:capsule_housing set value {id:carrot_on_a_stick, item_name:"Capsule Housing", item_model:"terf:part/capsule_housing"}

data modify storage terf:constants materials.terf:electromagnetic_capsule set value {id:carrot_on_a_stick, item_name:"Electromagnetic Capsule", item_model:"terf:tool/electromagnetic_capsule", custom_data:{terf:{capsule_contents:[{id:"empty",amount:0,max:2000}],click:"terf:entity/player/tool/capsule/activated",click_offhand:""}}, custom_model_data:{colors:[I;6908265],floats:[0]}, max_damage:1000000}
data modify storage terf:constants materials.terf:electromagnetic_capsule_full set value {id:carrot_on_a_stick, item_name:"Electromagnetic Capsule", item_model:"terf:tool/electromagnetic_capsule", custom_data:{terf:{capsule_contents:[{id:"terf.antihydrogen",amount:2000,max:2000}],click:"terf:entity/player/tool/capsule/activated",click_offhand:""}}, custom_model_data:{colors:[I;6908265],floats:[0]}, max_damage:1000000}

data modify storage terf:constants materials.terf:pressurized_capsule set value {id:carrot_on_a_stick, item_name:"Pressurized Capsule", item_model:"terf:tool/pressurized_capsule", custom_data:{terf:{capsule_contents:[{id:"empty",amount:0,max:100000}],click:"terf:entity/player/tool/capsule/activated",click_offhand:""}}, custom_model_data:{colors:[I;6908265],floats:[0]}, max_damage:100000}

data modify storage terf:constants materials.terf:shrink_ray set value {item_name:"Shrink Ray", item_model:"terf:tool/shrink_ray", custom_data:{rechargable:1b,terf:{click:"terf:entity/player/tool/shrink_ray/activated",click_offhand:"terf:entity/player/tool/shrink_ray/activated_offhand"}}, max_stack_size:1, max_damage:100000, damage:0, rarity:epic, consumable:{consume_seconds:1000000}, lore:[{"text":"Right-click to shrink entity","italic":false,"color":"gray"},{"text":"Shift-right-click to grow entity","italic":false,"color":"gray"},{"text":"Look straight down to use on yourself","italic":false,"color":"gray"}]}

data modify storage terf:constants materials.terf:maintenance_scanner set value {id:carrot_on_a_stick, item_name:"Maintenance Scanner", item_model:"terf:tool/crane_remote", custom_data:{rechargable:1b,terf:{click:"terf:entity/player/tool/maintenance_scanner/activated"}}, max_damage:100000, damage:0}

data modify storage terf:constants materials.terf:tau_cannon set value {item_name:"Tau Cannon", item_model:"terf:tool/tau_cannon", rarity:epic, custom_data:{rechargable:1b,terf:{held:"terf:entity/player/tool/tau_cannon/held",held_offhand:"terf:entity/player/tool/tau_cannon/held_offhand",click:"terf:entity/player/tool/tau_cannon/activated"}}, max_stack_size:1, max_damage:100000, damage:0, damage_resistant:{types:"#minecraft:is_fire"}, consumable:{consume_seconds:1000000}}

data modify storage terf:constants materials.terf:fire_extinguisher set value {item_name:"Fire Extinguisher", item_model:"terf:tool/fire_extinguisher", custom_data:{terf:{click:"terf:entity/player/tool/fire_extinguisher/activated",click_offhand:"terf:entity/player/tool/fire_extinguisher/activated_offhand"}}, max_stack_size:1, max_damage:2000, damage:0, rarity:common, consumable:{consume_seconds:1000000}}

data modify storage terf:constants materials.terf:custom_button set value {id:carrot_on_a_stick, item_name:"Custom Button", item_model:"birch_button", custom_data:{terf:{held:"terf:entity/player/tool/custom_button/held/start",click:"terf:entity/player/tool/custom_button/activated/start"}}, max_stack_size:64}

data modify storage terf:constants materials.terf:alarm_light set value {id:carrot_on_a_stick, item_name:"Alarm Light", item_model:"terf:visual/alarm_light/body", custom_data:{terf:{click:"terf:entity/player/tool/alarm_light/activated"}}, max_stack_size:64}

data modify storage terf:constants materials.terf:electron_bomb set value {id:carrot_on_a_stick, item_name:"Electron Bomb", item_model:"terf:tool/electron_bomb", rarity:epic, max_damage:2000000000, damage:2000000000, custom_data:{rechargable:1b,terf:{timer:200,click:"terf:entity/player/tool/electron_bomb/activated",click_offhand:""}}}

data modify storage terf:constants materials.terf:gravity_gun set value {item_name:"Gravity Gun", item_model:"terf:tool/electron_bomb", rarity:epic, max_damage:100000, max_stack_size:1, damage_resistant:{types:"#minecraft:is_fire"}, consumable:{consume_seconds:1000000}, custom_data:{rechargable:1b,terf:{click:"terf:entity/player/tool/gravity_gun/activated",click_offhand:""}}}

#==================================================| Custom Recipes |==================================================
##crusher
data modify storage terf:constants recipes.crusher.minecraft:ice set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:snowball",count:1}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:packed_ice set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:snowball",count:9}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:bone set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:bone_meal",count:6}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:blaze_rod set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:blaze_powder",count:4}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:redstone set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:red_dye"}}',t:100}

data modify storage terf:constants recipes.crusher.minecraft:stone set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:cobblestone"}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:cobblestone set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:gravel"}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:gravel set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:sand"}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:white_wool set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:string",count:4}}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:amethyst_block set value {z:'function terf:require/custom_item_summon {count:4,id:amethyst_dust}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:sugar_cane set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:sugar",count:2}}',t:40}
data modify storage terf:constants recipes.crusher.minecraft:tnt set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:gunpowder",count:5}}',t:50}

data modify storage terf:constants recipes.crusher.minecraft:netherite_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:netherite_dust}',t:300}

data modify storage terf:constants recipes.crusher.minecraft:gold_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:gold_dust}',t:60}
data modify storage terf:constants recipes.crusher.minecraft:raw_gold set value {z:'function terf:require/custom_item_summon {count:2,id:gold_dust}',t:60}
data modify storage terf:constants recipes.crusher.minecraft:raw_gold_block set value {z:'function terf:require/custom_item_summon {count:18,id:gold_dust}',t:660}

data modify storage terf:constants recipes.crusher.minecraft:copper_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:copper_dust}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:raw_copper set value {z:'function terf:require/custom_item_summon {count:2,id:copper_dust}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:raw_copper_block set value {z:'function terf:require/custom_item_summon {count:18,id:copper_dust}',t:1100}

data modify storage terf:constants recipes.crusher.minecraft:iron_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:iron_dust}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:raw_iron set value {z:'function terf:require/custom_item_summon {count:2,id:iron_dust}',t:100}
data modify storage terf:constants recipes.crusher.minecraft:raw_iron_block set value {z:'function terf:require/custom_item_summon {count:18,id:iron_dust}',t:1100}

data modify storage terf:constants recipes.crusher.terf:palladium_group_metal set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:palladium_group_metal_dust"}',t:1000}

##electrolyzer
data modify storage terf:constants recipes.electrolyzer.water set value {1:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:1,amount:20,id:"terf.hydrogen"}',2:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:2,amount:10,id:"terf.oxygen"}',a:30,t:30}
data modify storage terf:constants recipes.electrolyzer.terf.heavy_water set value {1:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:1,amount:20,id:"terf.deuterium"}',2:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:2,amount:10,id:"terf.oxygen"}',a:30,t:30}


data modify storage terf:constants recipes.ionizer.terf.liquified_lapis set value {1:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:1,amount:20,id:"terf.lapis_slurry"}',a:30,t:30}

##wet mill
data modify storage terf:constants recipes.wet_mill.gold_dust set value {z:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:0,amount:200,id:"terf.gold_slurry"}',a:200}
data modify storage terf:constants recipes.wet_mill.terf:palladium_group_metal_dust set value {z:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:0,amount:1000,id:"terf.palladium_group_sludge"}',a:1000}
data modify storage terf:constants recipes.wet_mill.minecraft:lapis_lazuli set value {z:'function datapipes_lib:fluid_transfer/add_fluid_safe {tank:0,amount:1000,id:"terf.liquified_lapis"}',a:1000}

##hadron collider
data modify storage terf:constants recipes.hadron_collider.minecraft:slime_block.minecraft:coal set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:diamond",count:2b}}',l:75,x:7,a:1,b:6}
data modify storage terf:constants recipes.hadron_collider.minecraft:diamond.minecraft:redstone set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:netherite_scrap"}}',l:80,x:12,a:2,b:16}
data modify storage terf:constants recipes.hadron_collider.minecraft:iron_ingot.minecraft:iron_nugget set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:gold_nugget",count:12b}}',l:40,x:3,a:1,b:12}
data modify storage terf:constants recipes.hadron_collider.minecraft:iron_nugget.minecraft:gold_nugget set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:glowstone_dust",count:2}}',l:80,x:4,a:2,b:2}
data modify storage terf:constants recipes.hadron_collider.minecraft:iron_ingot.minecraft:gold_ingot set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:copper_ingot",count:2}}',l:28,x:3,a:1,b:1}
data modify storage terf:constants recipes.hadron_collider.minecraft:copper_ingot.minecraft:stone set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:iron_ingot",count:4}}',l:69,x:3,a:1,b:24}
data modify storage terf:constants recipes.hadron_collider.minecraft:netherite_ingot.minecraft:glass set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:nether_star",count:1}}',l:25,x:35,a:8,b:64}
data modify storage terf:constants recipes.hadron_collider.minecraft:gold_nugget.minecraft:iron_nugget set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:redstone",count:1}}',l:5,x:5,a:1,b:1}
data modify storage terf:constants recipes.hadron_collider.minecraft:charcoal.minecraft:charcoal set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:coal",count:7}}',l:50,x:3,a:4,b:4}
data modify storage terf:constants recipes.hadron_collider.minecraft:slime_ball.netherite_dust set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:ender_pearl",count:1}}',l:100,x:210,a:1,b:2}
data modify storage terf:constants recipes.hadron_collider.minecraft:red_bed.minecraft:ancient_debris set value {z:'function terf:entity/black_hole/summon',l:100,x:24,a:1,b:4}

data modify storage terf:constants recipes.hadron_collider.minecraft:nether_star.minecraft:netherite_scrap set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:netherite_upgrade_smithing_template",count:1}}',l:100,x:100,a:1,b:7}

##opencore
data modify storage terf:constants recipes.opencore.minecraft:netherite_scrap set value {fail:['scoreboard players set length terf_states 100','function terf:entity/machines/hadron_collider/ring/explosion','function terf:entity/machines/opencore/explosions/fire','function terf:entity/machines/opencore/explosions/main_effects'],z:'summon item ~ ~ ~ {Item:{id:"minecraft:netherite_ingot",count:8}}',x:5000,a:8,in_desc:"neth. scrap",out_desc:"8x neth. ingot",operations:[{min:1328,max:9999,time:1200,desc:"MELT",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:1000,max:1328,time:1200,desc:"SPONGIFY",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:18300,max:30000,time:1200,desc:"FUSE",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:16100,time:1200,desc:"FORM",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:7000,max:8000,time:1200,desc:"COOL",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:100,time:1200,desc:"SOLIDIFY",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:22,time:1200,desc:"SHUTDOWN",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"}]}
data modify storage terf:constants recipes.opencore.minecraft:glowstone_dust set value {fail:['function terf:entity/machines/opencore/explosions/fire','function terf:entity/machines/opencore/explosions/main_effects'],z:'summon item ~ ~ ~ {Item:{id:"minecraft:blaze_powder",count:24}}',x:5000,a:32,in_desc:"glowstn. dust",out_desc:"24x blaze powder",operations:[{min:22000,max:22500,time:1200,desc:"BURN",core:"particle dust{color:[0.4,1.0,1.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:10,time:1200,desc:"COOL",core:"particle dust{color:[0.0,1.0,0.8],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:22,time:1200,desc:"SHUTDOWN",core:"particle dust{color:[0,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"}]}
data modify storage terf:constants recipes.opencore.minecraft:emerald_block set value {fail:['scoreboard players set length terf_states 400','function terf:entity/machines/hadron_collider/ring/explosion','function terf:entity/machines/opencore/explosions/main_effects'],z:'summon item ~ ~ ~ {Item:{id:"minecraft:diamond_block",count:3}}',x:7200,a:4,in_desc:"emerald block",out_desc:"3x diamond block",operations:[{min:1410,max:1510,time:1200,desc:"MELT",core:"particle dust{color:[1.0,0.5,0.5],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:-135,max:-23,time:1200,desc:"QUENCH",core:"particle dust{color:[0.05,0.05,0.00],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:126100,max:133200,time:2400,desc:"FUSE",core:"particle dust{color:[1,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:300,max:400,time:2400,desc:"CRYSTALIZE",core:"particle dust{color:[0,1,0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:22,time:1200,desc:"SHUTDOWN",core:"particle dust{color:[0,1,0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"}]}
data modify storage terf:constants recipes.opencore.minecraft:quartz set value {fail:['summon tnt ~ ~ ~ {fuse:0}','scoreboard players add @a[distance=..32] terf_data_A 995427','function terf:entity/machines/opencore/explosions/main_effects'],z:'summon item ~ ~ ~ {Item:{id:"minecraft:amethyst_shard",count:20}}',x:900,a:20,in_desc:"quartz",out_desc:"20x amethyst shard",operations:[{min:116,max:116,time:2400,desc:"EXPOSE",core:"particle dust{color:[1,1,0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:22,time:1200,desc:"SHUTDOWN",core:"particle dust{color:[0.8,1,1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"}]}
data modify storage terf:constants recipes.opencore.minecraft:amethyst_block set value {fail:['function terf:entity/machines/opencore/explosions/main_effects','scoreboard players add @a[distance=..32] terf_data_A 995427','function terf:require/run_n_times {command:"function terf:entity/photon_ball/summon_random_direction",n:100}'],z:'summon item ~ ~ ~ {Item:{id:"minecraft:ochre_froglight",count:1}}',x:6000,a:4,in_desc:"amethyst block",out_desc:"ochre froglight",operations:[{min:-140,max:-130,time:600,desc:"FORM",core:"particle dust{color:[1.0,1.0,1.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:135,max:135,time:1000,desc:"BIOLY.1",core:"particle dust{color:[0.4,1.0,0.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:15,max:130,time:100,desc:"CORELY.1",core:"particle dust{color:[0.4,1.0,1.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:141,max:141,time:1000,desc:"BIOLY.2",core:"particle dust{color:[0.6,1.0,0.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:15,max:130,time:100,desc:"CORELY.2",core:"particle dust{color:[0.6,1.0,1.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:145,max:145,time:1000,desc:"BIOLY.3",core:"particle dust{color:[0.8,1.0,0.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:15,max:130,time:100,desc:"CORELY.3",core:"particle dust{color:[0.8,1.0,1.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:2515,max:2555,time:600,desc:"MK. SHELL",core:"particle dust{color:[0.2,0.1,0.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:22,time:1200,desc:"SHUTDOWN",core:"particle dust{color:[0.2,0.1,0.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"}]}
data modify storage terf:constants recipes.opencore.minecraft:netherite_block set value {fail:['function terf:require/run_n_times {n:20000,command:"function terf:entity/machines/opencore/explosions/push_blocks"}','function terf:entity/explosion/large_explosion/summon','function terf:entity/machines/opencore/explosions/main_effects','function terf:entity/machines/opencore/explosions/fire'],z:'summon item ~ ~ ~ {Item:{id:"minecraft:heavy_core",count:1}}',x:10000,a:1,in_desc:"netherite block",out_desc:"heavy core",operations:[{min:1000,max:250000,time:1200,desc:"PREPARE",core:"particle dust{color:[0.1,0.1,0.1],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:2000,max:2500,time:1200,desc:"MELT",core:"particle dust{color:[1.0,0.2,0.0],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:110000,max:129000,time:1210,desc:"EXPOSE",core:'function datapipes_lib:require/run_in_all_directions {accuracy:10000,command:"particle portal ~ ~ ~ ^ ^ ^10000000000 0.0000000002 0 force"}'},{min:1100,max:30105,time:2000,desc:"CRYSTALIZE",core:"particle dust{color:[0.2,0.3,0.8],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:-272,max:-272,time:600,desc:"HARDEN",core:"particle dust{color:[0.8,0.8,0.8],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:40,time:600,desc:"FORM",core:"particle dust{color:[0.5,0.5,0.6],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"},{min:0,max:22,time:1200,desc:"SHUTDOWN",core:"particle dust{color:[0.5,0.5,0.6],scale:3} ~ ~ ~ 0 0 0 0.1 1 force"}]}

##electric blast furnace
data modify storage terf:constants recipes.ebf.minecraft:chicken set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:cooked_chicken"}}',t:60}
data modify storage terf:constants recipes.ebf.minecraft:sand set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:glass"}}',t:10}
data modify storage terf:constants recipes.ebf.amethyst_dust set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:amethyst_shard"}}',t:60}
data modify storage terf:constants recipes.ebf.iron_dust set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:iron_ingot"}}',t:30}
data modify storage terf:constants recipes.ebf.gold_dust set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:gold_ingot"}}',t:20}
data modify storage terf:constants recipes.ebf.copper_dust set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:copper_ingot"}}',t:40}

##electric press
data modify storage terf:constants recipes.electric_press.minecraft:blaze_powder set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:blaze_rod"}}',a:5}
data modify storage terf:constants recipes.electric_press.minecraft:honeycomb set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:slime_ball"}}',a:1}
data modify storage terf:constants recipes.electric_press.minecraft:honeycomb_block set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:slime_ball",count:4}}',a:1}
data modify storage terf:constants recipes.electric_press.minecraft:string set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:leather"}}',a:8}
data modify storage terf:constants recipes.electric_press.minecraft:netherite_scrap set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:ancient_debris"}}',a:1}

##dem
data modify storage terf:constants recipes.dem.blue_glazed_terracotta set value {z:'function terf:require/add_fluid_to_receptacle {amount:1,id:"terf.daonium",rid:0}',a:1000,b:0,t:24072474,m:100}

##rolling mill
data modify storage terf:constants recipes.rolling_mill.minecraft:copper_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:copper_plate}',t:60}
data modify storage terf:constants recipes.rolling_mill.copper_plate set value {z:'function terf:require/custom_item_summon {count:4,id:copper_foil}',t:60}
data modify storage terf:constants recipes.rolling_mill.copper_rod set value {z:'function terf:require/custom_item_summon {count:4,id:copper_wire}',t:60}

data modify storage terf:constants recipes.rolling_mill.minecraft:gold_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:gold_plate}',t:20}
data modify storage terf:constants recipes.rolling_mill.gold_plate set value {z:'function terf:require/custom_item_summon {count:4,id:gold_foil}',t:20}
data modify storage terf:constants recipes.rolling_mill.gold_rod set value {z:'function terf:require/custom_item_summon {count:4,id:gold_wire}',t:20}

data modify storage terf:constants recipes.rolling_mill.minecraft:iron_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:iron_plate}',t:100}
data modify storage terf:constants recipes.rolling_mill.iron_plate set value {z:'function terf:require/custom_item_summon {count:4,id:iron_foil}',t:100}
data modify storage terf:constants recipes.rolling_mill.iron_rod set value {z:'function terf:require/custom_item_summon {count:4,id:iron_wire}',t:100}

data modify storage terf:constants recipes.rolling_mill.minecraft:netherite_ingot set value {z:'function terf:require/custom_item_summon {count:1,id:netherite_plate}',t:200}
data modify storage terf:constants recipes.rolling_mill.netherite_plate set value {z:'function terf:require/custom_item_summon {count:4,id:netherite_foil}',t:200}
data modify storage terf:constants recipes.rolling_mill.netherite_rod set value {z:'function terf:require/custom_item_summon {count:4,id:netherite_wire}',t:200}

##extrusion press
data modify storage terf:constants recipes.extrusion_press.minecraft:copper_ingot.extrusion_mold_bar set value {z:'function terf:require/custom_item_summon {count:1,id:copper_bar}',t:120}
data modify storage terf:constants recipes.extrusion_press.copper_bar.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:copper_spring}',t:120}
data modify storage terf:constants recipes.extrusion_press.copper_rod.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:small_copper_spring}',t:120}
data modify storage terf:constants recipes.extrusion_press.copper_bolt.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:copper_ring}',t:120}
data modify storage terf:constants recipes.extrusion_press.copper_bolt.extrusion_mold_threading set value {z:'function terf:require/custom_item_summon {count:1,id:copper_screw}',t:120}

data modify storage terf:constants recipes.extrusion_press.minecraft:gold_ingot.extrusion_mold_bar set value {z:'function terf:require/custom_item_summon {count:1,id:gold_bar}',t:40}
data modify storage terf:constants recipes.extrusion_press.gold_bar.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:gold_spring}',t:40}
data modify storage terf:constants recipes.extrusion_press.gold_rod.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:small_gold_spring}',t:40}
data modify storage terf:constants recipes.extrusion_press.gold_bolt.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:gold_ring}',t:40}
data modify storage terf:constants recipes.extrusion_press.gold_bolt.extrusion_mold_threading set value {z:'function terf:require/custom_item_summon {count:1,id:gold_screw}',t:40}

data modify storage terf:constants recipes.extrusion_press.minecraft:iron_ingot.extrusion_mold_bar set value {z:'function terf:require/custom_item_summon {count:1,id:iron_bar}',t:200}
data modify storage terf:constants recipes.extrusion_press.iron_bar.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:iron_spring}',t:200}
data modify storage terf:constants recipes.extrusion_press.iron_rod.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:small_iron_spring}',t:200}
data modify storage terf:constants recipes.extrusion_press.iron_bolt.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:iron_ring}',t:200}
data modify storage terf:constants recipes.extrusion_press.iron_bolt.extrusion_mold_threading set value {z:'function terf:require/custom_item_summon {count:1,id:iron_screw}',t:200}

data modify storage terf:constants recipes.extrusion_press.minecraft:netherite_ingot.extrusion_mold_bar set value {z:'function terf:require/custom_item_summon {count:1,id:netherite_bar}',t:400}
data modify storage terf:constants recipes.extrusion_press.netherite_bar.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:netherite_spring}',t:400}
data modify storage terf:constants recipes.extrusion_press.netherite_rod.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:small_netherite_spring}',t:400}
data modify storage terf:constants recipes.extrusion_press.netherite_bolt.extrusion_mold_roller set value {z:'function terf:require/custom_item_summon {count:1,id:netherite_ring}',t:400}
data modify storage terf:constants recipes.extrusion_press.netherite_bolt.extrusion_mold_threading set value {z:'function terf:require/custom_item_summon {count:1,id:netherite_screw}',t:400}

##shearing press
data modify storage terf:constants recipes.shearing_press.copper_bar set value {z:'function terf:require/custom_item_summon {count:2,id:copper_rod}',t:30}
data modify storage terf:constants recipes.shearing_press.copper_rod set value {z:'function terf:require/custom_item_summon {count:2,id:copper_bolt}',t:30}
data modify storage terf:constants recipes.shearing_press.copper_spring set value {z:'function terf:require/custom_item_summon {count:2,id:small_copper_spring}',t:30}

data modify storage terf:constants recipes.shearing_press.gold_bar set value {z:'function terf:require/custom_item_summon {count:2,id:gold_rod}',t:30}
data modify storage terf:constants recipes.shearing_press.gold_rod set value {z:'function terf:require/custom_item_summon {count:2,id:gold_bolt}',t:30}
data modify storage terf:constants recipes.shearing_press.gold_spring set value {z:'function terf:require/custom_item_summon {count:2,id:small_gold_spring}',t:30}

data modify storage terf:constants recipes.shearing_press.iron_bar set value {z:'function terf:require/custom_item_summon {count:2,id:iron_rod}',t:30}
data modify storage terf:constants recipes.shearing_press.iron_rod set value {z:'function terf:require/custom_item_summon {count:2,id:iron_bolt}',t:30}
data modify storage terf:constants recipes.shearing_press.iron_spring set value {z:'function terf:require/custom_item_summon {count:2,id:small_iron_spring}',t:30}

data modify storage terf:constants recipes.shearing_press.netherite_bar set value {z:'function terf:require/custom_item_summon {count:2,id:netherite_rod}',t:30}
data modify storage terf:constants recipes.shearing_press.netherite_rod set value {z:'function terf:require/custom_item_summon {count:2,id:netherite_bolt}',t:30}
data modify storage terf:constants recipes.shearing_press.netherite_spring set value {z:'function terf:require/custom_item_summon {count:2,id:small_netherite_spring}',t:30}

##fission fuel loader
data modify storage terf:constants recipes.fission_fuel_loader.load.uranium-235_oxide_pellet set value {z:'summon minecraft:marker ~ ~ ~ {Tags:["terf_fuel_rod","terf_radioactive"],data:{terf:{fuel:{id:"uranium-235_oxide",react:"datapipes_lib:chances/5",nRate:"datapipes_lib:chances/1"}}}}'}
data modify storage terf:constants recipes.fission_fuel_loader.unload.uranium-235_oxide set value {z:''}

##large fluid solidifier
data modify storage terf:constants recipes.large_fluid_solidifier.terf.mineral_magma set value {z:'function terf:entity/machines/large_fluid_solidifier/random_ore', a:1000}
data modify storage terf:constants recipes.large_fluid_solidifier.water set value {z:'function terf:entity/machines/large_fluid_solidifier/random_ice', a:1000}
data modify storage terf:constants recipes.large_fluid_solidifier.terf.palladium_group_sludge set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:nanopore_palladium_catalyst"}', a:1000}

##assembler | the last 10 characters of names are trimmed! | t = Extension decrease per tick | m = Min extension required to complete, starts at 60000000 | s = Command to run when the assembler starts, like summoning an entity for show | z = Command to run when finished
execute unless data storage terf:constants recipes.assembler run data modify storage terf:constants recipes.assembler set value []
data modify storage terf:constants recipes.assembler set value []

data modify storage terf:constants recipes.assembler[{name:"Hoverbike_terf00000"}] set value {name:"ike_terf00000",t:2500,m:49000000,items:[{id:"iron_bar",count:8},{id:"iron_plate",count:24},{id:"iron_screw",count:32},{id:"minecraft:white_carpet",count:1},{id:"minecraft:orange_glazed_terracotta",count:1},{id:"copper_wire",count:16},{id:"terf:magnetron",count:4},{id:"iron_rotor",count:1}],s:'summon item_display ~ ~.35 ~ {Tags:["terf_currententity"],item:{id:"minecraft:carrot_on_a_stick",components:{item_model:"terf:visual/hoverbike",custom_model_data:{colors:[7368816,0]}}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.5f,1.5f,1.5f]}}',z:'function terf:entity/vehicle/hoverbike/summon'}

##fabricator

#parts
data modify storage terf:constants recipes.fabricator.copper_screw.copper_plate.copper_screw.copper_plate.copper_ring.copper_plate.copper_screw.copper_plate.copper_screw set value {z:'function terf:require/custom_item_summon {id:copper_rotor,count:1}'}
data modify storage terf:constants recipes.fabricator.netherite_screw.netherite_plate.netherite_screw.netherite_plate.netherite_ring.netherite_plate.netherite_screw.netherite_plate.netherite_screw set value {z:'function terf:require/custom_item_summon {id:netherite_rotor,count:1}'}
data modify storage terf:constants recipes.fabricator.gold_screw.gold_plate.gold_screw.gold_plate.gold_ring.gold_plate.gold_screw.gold_plate.gold_screw set value {z:'function terf:require/custom_item_summon {id:gold_rotor,count:1}'}
data modify storage terf:constants recipes.fabricator.iron_screw.iron_plate.iron_screw.iron_plate.iron_ring.iron_plate.iron_screw.iron_plate.iron_screw set value {z:'function terf:require/custom_item_summon {id:iron_rotor,count:1}'}

#extrusion molds
data modify storage terf:constants recipes.fabricator.z.copper_plate.z.copper_plate.minecraft:stone_button.copper_plate.z.copper_plate.z set value {z:'function terf:require/custom_item_summon {id:copper_extrusion_mold_bar,count:1}'}
data modify storage terf:constants recipes.fabricator.z.netherite_plate.z.netherite_plate.minecraft:stone_button.netherite_plate.z.netherite_plate.z set value {z:'function terf:require/custom_item_summon {id:netherite_extrusion_mold_bar,count:1}'}
data modify storage terf:constants recipes.fabricator.z.gold_plate.z.gold_plate.minecraft:stone_button.gold_plate.z.gold_plate.z set value {z:'function terf:require/custom_item_summon {id:gold_extrusion_mold_bar,count:1}'}
data modify storage terf:constants recipes.fabricator.z.iron_plate.z.iron_plate.minecraft:stone_button.iron_plate.z.iron_plate.z set value {z:'function terf:require/custom_item_summon {id:iron_extrusion_mold_bar,count:1}'}

data modify storage terf:constants recipes.fabricator.z.copper_plate.z.copper_plate.minecraft:grindstone.copper_plate.z.copper_plate.z set value {z:'function terf:require/custom_item_summon {id:copper_extrusion_mold_roller,count:1}'}
data modify storage terf:constants recipes.fabricator.z.netherite_plate.z.netherite_plate.minecraft:grindstone.netherite_plate.z.netherite_plate.z set value {z:'function terf:require/custom_item_summon {id:netherite_extrusion_mold_roller,count:1}'}
data modify storage terf:constants recipes.fabricator.z.gold_plate.z.gold_plate.minecraft:grindstone.gold_plate.z.gold_plate.z set value {z:'function terf:require/custom_item_summon {id:gold_extrusion_mold_roller,count:1}'}
data modify storage terf:constants recipes.fabricator.z.iron_plate.z.iron_plate.minecraft:grindstone.iron_plate.z.iron_plate.z set value {z:'function terf:require/custom_item_summon {id:iron_extrusion_mold_roller,count:1}'}

data modify storage terf:constants recipes.fabricator.z.copper_plate.z.copper_plate.copper_bolt.copper_plate.z.copper_plate.z set value {z:'function terf:require/custom_item_summon {id:copper_extrusion_mold_threading,count:1}'}
data modify storage terf:constants recipes.fabricator.z.netherite_plate.z.netherite_plate.netherite_bolt.netherite_plate.z.netherite_plate.z set value {z:'function terf:require/custom_item_summon {id:netherite_extrusion_mold_threading,count:1}'}
data modify storage terf:constants recipes.fabricator.z.gold_plate.z.gold_plate.gold_bolt.gold_plate.z.gold_plate.z set value {z:'function terf:require/custom_item_summon {id:gold_extrusion_mold_threading,count:1}'}
data modify storage terf:constants recipes.fabricator.z.iron_plate.z.iron_plate.iron_bolt.iron_plate.z.iron_plate.z set value {z:'function terf:require/custom_item_summon {id:iron_extrusion_mold_threading,count:1}'}

#lv laser diode
data modify storage terf:constants recipes.fabricator.minecraft:iron_nugget.minecraft:glass.minecraft:iron_nugget.gold_plate.minecraft:diamond.gold_plate.minecraft:waxed_lightning_rod.minecraft:waxed_lightning_rod.minecraft:waxed_lightning_rod set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:laser_diode_lv"}'}

#hv laser diode
data modify storage terf:constants recipes.fabricator.netherite_plate.netherite_plate.z.minecraft:diamond_block.minecraft:amethyst_shard.minecraft:waxed_copper_bulb.netherite_plate.netherite_plate.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:laser_diode_hv"}'}

#mv battery
data modify storage terf:constants recipes.fabricator.gold_plate.gold_plate.iron_plate.minecraft:glow_ink_sac.minecraft:coal.minecraft:glow_ink_sac.copper_plate.copper_plate.copper_plate set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:battery_mv"}'}

#heat sink
data modify storage terf:constants recipes.fabricator.z.minecraft:iron_nugget.z.iron_plate.minecraft:heavy_weighted_pressure_plate.iron_plate.z.minecraft:iron_nugget.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:heat_sink"}'}

#magnetron
data modify storage terf:constants recipes.fabricator.gold_plate.minecraft:waxed_lightning_rod.gold_plate.terf:heat_sink.minecraft:copper_grate.terf:heat_sink.terf:heat_sink.minecraft:lodestone.terf:heat_sink set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:magnetron"}'}

#A.R.T Mount
data modify storage terf:constants recipes.fabricator.minecraft:anvil.z.minecraft:anvil.minecraft:iron_block.z.minecraft:iron_block.minecraft:netherite_ingot.netherite_plate.minecraft:netherite_ingot set value {z:'summon item ~ ~ ~ {Item:{id:recovery_compass,components:{max_stack_size:1,rarity:epic,item_name:"A.R.T Mount",item_model:"terf:visual/art/stand",custom_data:{id:"terf:art_mount"}}}}'}

#A.R.T Turret
data modify storage terf:constants recipes.fabricator.terf:art_rail.terf:art_rail.minecraft:waxed_copper_bulb.minecraft:heavy_core.terf:laser_diode_hv.minecraft:netherite_block.terf:art_rail.terf:art_rail.minecraft:waxed_copper_bulb set value {z:'summon item ~ ~ ~ {Item:{id:carrot_on_a_stick,components:{max_stack_size:1,rarity:epic,item_name:"A.R.T Turret",item_model:"terf:visual/art/gun",custom_data:{id:"terf:art_turret"}}}}'}

#A.R.T Rail
data modify storage terf:constants recipes.fabricator.netherite_plate.netherite_plate.netherite_plate.minecraft:anvil.minecraft:anvil.minecraft:anvil.terf:heat_sink.terf:heat_sink.terf:heat_sink set value {z:'summon item ~ ~ ~ {Item:{id:recovery_compass,components:{max_stack_size:1,item_name:"A.R.T Rail",item_model:"terf:part/art_rail",custom_data:{id:"terf:art_rail"}}}}'}

#tools

#multiblock core
data modify storage terf:constants recipes.fabricator.minecraft:redstone.minecraft:iron_ingot.minecraft:copper_block.minecraft:iron_ingot.minecraft:diamond.minecraft:iron_ingot.minecraft:copper_block.minecraft:iron_ingot.minecraft:redstone set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:multiblock_core"}'}

#multimeter
data modify storage terf:constants recipes.fabricator.minecraft:tripwire_hook.minecraft:redstone_torch.minecraft:tripwire_hook.minecraft:iron_chain.minecraft:comparator.minecraft:iron_chain.z.minecraft:iron_nugget.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:multimeter"}'}

#dosimeter
data modify storage terf:constants recipes.fabricator.minecraft:oxidized_copper_bulb.minecraft:note_block.minecraft:iron_nugget.minecraft:redstone.minecraft:observer.minecraft:amethyst_shard.z.z.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:dosimeter"}'}

#hard hat
data modify storage terf:constants recipes.fabricator.z.minecraft:iron_ingot.z.minecraft:iron_nugget.minecraft:leather_helmet.minecraft:iron_nugget.z.minecraft:yellow_dye.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:hard_hat"}'}

#laser pistol
data modify storage terf:constants recipes.fabricator.minecraft:diamond.minecraft:netherite_ingot.minecraft:redstone_block.minecraft:stone_button.minecraft:observer.minecraft:comparator.terf:battery_mv.minecraft:iron_chain.minecraft:waxed_lightning_rod set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:laser_pistol"}'}

#taser
data modify storage terf:constants recipes.fabricator.minecraft:iron_chain.minecraft:netherite_scrap.minecraft:redstone_block.minecraft:redstone_torch.minecraft:stone_button.minecraft:quartz.z.terf:battery_mv.minecraft:waxed_lightning_rod set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:taser"}'}

#wrench
data modify storage terf:constants recipes.fabricator.minecraft:iron_nugget.minecraft:iron_ingot.minecraft:heavy_weighted_pressure_plate.z.minecraft:waxed_lightning_rod.minecraft:iron_nugget.z.minecraft:red_dye.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:wrench"}'}

#photon cannon
data modify storage terf:constants recipes.fabricator.minecraft:redstone_torch.minecraft:netherite_scrap.minecraft:redstone_block.minecraft:glass.minecraft:waxed_copper_bulb.minecraft:waxed_copper_bulb.terf:battery_mv.minecraft:stone_button.minecraft:waxed_lightning_rod set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:photon_cannon"}'}

#linker
data modify storage terf:constants recipes.fabricator.z.iron_plate.iron_plate.minecraft:glass_pane.terf:laser_diode_lv.terf:battery_mv.z.minecraft:stone_button.minecraft:waxed_lightning_rod set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:linker"}'}

#plasma pickaxe
data modify storage terf:constants recipes.fabricator.minecraft:netherite_pickaxe.minecraft:netherite_axe.terf:laser_diode_hv.terf:laser_diode_hv.minecraft:comparator.minecraft:waxed_lightning_rod.z.terf:battery_mv.minecraft:waxed_lightning_rod set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:plasma_pickaxe"}'}

#nuke
#data merge block ~ ~1 ~ {Items:[{Slot:4b,id:"minecraft:creeper_spawn_egg",count:1,components:{"minecraft:max_stack_size":1,"minecraft:item_name":"Nuclear Bomb","minecraft:rarity":"rare","minecraft:custom_proof_data":7921002,"minecraft:entity_data":{id:"minecraft:item_display",Tags:["terf_nuke"],item:{id:"minecraft:creeper_spawn_egg",count:1,components:{"minecraft:custom_proof_data":7921002}}}}}}

#shrink ray
data modify storage terf:constants recipes.fabricator.netherite_plate.copper_plate.terf:battery_mv.minecraft:comparator.minecraft:beacon.terf:laser_diode_hv.netherite_plate.minecraft:stone_button.minecraft:waxed_lightning_rod set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:shrink_ray"}'}

#crane remote
data modify storage terf:constants recipes.fabricator.minecraft:waxed_lightning_rod.minecraft:redstone_torch.minecraft:acacia_sign.copper_plate.terf:battery_mv.minecraft:stone_button.z.copper_plate.minecraft:stone_button set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:crane_remote"}'}

#tau cannon
data modify storage terf:constants recipes.fabricator.copper_plate.netherite_plate.terf:heat_sink.minecraft:calibrated_sculk_sensor.terf:laser_diode_hv.terf:magnetron.copper_plate.minecraft:waxed_oxidized_copper_bulb.minecraft:beacon set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:tau_cannon"}'}

#fire extinguisher
data modify storage terf:constants recipes.fabricator.z.z.minecraft:lever.minecraft:waxed_lightning_rod.minecraft:stone_button.minecraft:lever.iron_plate.minecraft:powder_snow_bucket.iron_plate set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:fire_extinguisher"}'}

#A.R.T base
data modify storage terf:constants recipes.fabricator.netherite_plate.minecraft:iron_block.netherite_plate.minecraft:iron_block.minecraft:netherite_ingot.minecraft:iron_block.netherite_plate.minecraft:iron_block.netherite_plate set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:art_base"}'}

#syringe
data modify storage terf:constants recipes.fabricator.z.minecraft:glass.minecraft:heavy_weighted_pressure_plate.minecraft:glass.z.minecraft:glass.minecraft:waxed_lightning_rod.minecraft:glass.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:syringe"}'}

#neutron monocular
data modify storage terf:constants recipes.fabricator.minecraft:sculk_sensor.minecraft:netherite_scrap.minecraft:petrified_oak_slab.minecraft:netherite_scrap.minecraft:spyglass.minecraft:netherite_scrap.terf:battery_mv.minecraft:netherite_scrap.minecraft:stone_button set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:monocular"}'}

#fluid id tool
data modify storage terf:constants recipes.fabricator.minecraft:observer.minecraft:redstone_torch.minecraft:redstone.z.z.copper_plate.iron_plate.iron_plate.minecraft:glass set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:fluid_id"}'}

#battery module
data modify storage terf:constants recipes.fabricator.minecraft:waxed_lightning_rod.iron_plate.minecraft:waxed_lightning_rod.minecraft:iron_chain.terf:battery_mv.minecraft:iron_chain.iron_plate.minecraft:brown_glazed_terracotta.iron_plate set value {z:'summon item ~ ~ ~ {Item:{id:orange_glazed_terracotta}}'}

#mcfr assembly
data modify storage terf:constants recipes.fabricator.terf:heat_sink.terf:heat_sink.minecraft:waxed_lightning_rod.terf:heat_sink.terf:heat_sink.minecraft:brown_glazed_terracotta.minecraft:waxed_lightning_rod.minecraft:brown_glazed_terracotta.terf:nanopore_palladium_catalyst set value {z:'summon item ~ ~ ~ {Item:{id:white_glazed_terracotta}}'}

#greg music disc
data modify storage terf:constants recipes.fabricator.netherite_rotor.copper_rotor.iron_rotor.gold_rotor.minecraft:netherite_block.gold_rotor.iron_rotor.copper_rotor.netherite_rotor set value {z:'summon item ~ ~ ~ {Item:{id:music_disc_11,components:{jukebox_playable:"terf:aviators_sweet_dreams","item_model":"terf:part/music_disc_greg"}}}'}

#coil
data modify storage terf:constants recipes.fabricator.copper_wire.copper_wire.copper_wire.copper_wire.iron_bolt.copper_wire.copper_wire.copper_wire.copper_wire set value {z:'summon item ~ ~ ~ {Item:{id:petrified_oak_slab}}'}

#capsule housing
data modify storage terf:constants recipes.fabricator.iron_bar.copper_spring.iron_bar.iron_plate.iron_bolt.iron_plate.iron_plate.iron_bolt.iron_plate set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:capsule_housing"}'}

#electromagnetic capsule
data modify storage terf:constants recipes.fabricator.minecraft:petrified_oak_slab.terf:battery_mv.minecraft:petrified_oak_slab.netherite_bar.terf:capsule_housing.netherite_bar.minecraft:petrified_oak_slab.gold_spring.minecraft:petrified_oak_slab set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:electromagnetic_capsule"}'}

#pressurized capsule
data modify storage terf:constants recipes.fabricator.minecraft:iron_block.minecraft:iron_block.minecraft:iron_block.iron_spring.terf:capsule_housing.minecraft:iron_bars.minecraft:dried_kelp.copper_bolt.small_iron_spring set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:pressurized_capsule"}'}

#ender chest
data modify storage terf:constants recipes.fabricator.netherite_bar.minecraft:acacia_sign.minecraft:crying_obsidian.minecraft:chest.minecraft:end_crystal.gold_rotor.minecraft:crying_obsidian.minecraft:ender_eye.minecraft:loom set value {z:'summon item ~ ~ ~ {Item:{id:"minecraft:ender_chest"}}'}

#custom button
data modify storage terf:constants recipes.fabricator.z.minecraft:redstone_torch.z.z.minecraft:birch_button.small_copper_spring.z.minecraft:calibrated_sculk_sensor.z set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:custom_button"}'}

#electron bomb
data modify storage terf:constants recipes.fabricator.terf:nanopore_palladium_catalyst.minecraft:comparator.minecraft:acacia_hanging_sign.terf:electromagnetic_capsule.minecraft:conduit.terf:electromagnetic_capsule.minecraft:observer.minecraft:granite_slab.minecraft:observer set value {z:'function terf:require/custom_item_summon {count:1,id:"terf:electron_bomb"}'}

##==================================================| Custom Multiblocks |==================================================
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ sticky_piston[facing=up]"}].function set value 'function terf:entity/machines/breakers/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ dropper[facing=up]"}].function set value 'function terf:entity/machines/charging_station/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ crafter if block ^-1 ^ ^ crafting_table"}].function set value 'function terf:entity/machines/fabricator/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ piston[facing=up]"}].function set value 'function terf:entity/machines/diesel_generator/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ piston[facing=down]"}].function set value 'function terf:entity/machines/fluid_pump/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ piston"}].function set value 'function terf:entity/machines/purifier/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ cauldron unless block ^ ^ ^-1 sticky_piston"}].function set value 'function terf:entity/machines/hadron_collider/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ decorated_pot"}].function set value 'function terf:entity/machines/wet_mill/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ granite_slab if block ~ ~1 ~ piston"}].function set value 'function terf:entity/machines/gear_elevator/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ granite_slab"}].function set value 'function terf:entity/machines/laser/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ obsidian"}].function set value 'function terf:entity/machines/security_terminal/setup with entity @s data.terf'
data modify storage terf:constants mb_setup_functions[{checks:"if function terf:entity/machines/block_breaker/checks"}].function set value 'function terf:entity/machines/block_breaker/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ dispenser"}].function set value 'function terf:entity/machines/multi_piston/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_copper_block"}].function set value 'function terf:entity/machines/arc_furnace/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_cut_copper if block ^ ^2 ^ piston"}].function set value 'function terf:entity/machines/electric_press/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_cut_copper"}].function set value 'function terf:entity/machines/redstone_probe/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_copper_bulb"}].function set value 'function terf:entity/machines/fission_reactor_panel/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ granite_stairs if block ^ ^1 ^ loom"}].function set value 'function terf:entity/machines/fission_sensor/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ crying_obsidian"}].function set value 'function terf:entity/machines/lamp_controller/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ lapis_block"}].function set value 'function terf:entity/machines/large_fluid_solidifier/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ lodestone if block ^ ^1 ^ granite_slab[type=double]"}].function set value 'function terf:entity/machines/magma_drill/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ loom if block ^ ^-1 ^ waxed_cut_copper"}].function set value 'function terf:entity/machines/opencore_control_panel/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ loom"}].function set value 'function terf:entity/machines/stfr_control_panel/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ smooth_stone"}].function set value 'function terf:entity/machines/turbine_large/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_chiseled_copper"}].function set value 'function terf:entity/machines/turbine_medium/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_oxidized_copper_bulb"}].function set value 'function terf:entity/machines/warp_core_panel/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ observer if function terf:entity/machines/fluid_tank/is_tank"}].function set value 'function terf:entity/machines/fluid_tank/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ white_glazed_terracotta"}].function set value 'function terf:entity/machines/mcfr/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ fire"}].function set value 'tag @s add terf_ifire_pro_max'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ observer[facing=up] if block ~ ~1 ~ dispenser[facing=up] if block ~ ~-1 ~ waxed_cut_copper"}].function set value 'function terf:entity/machines/chimney/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ brown_glazed_terracotta if block ^ ^1 ^ grindstone"}].function set value 'function terf:entity/machines/rolling_mill/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ hopper if block ~ ~1 ~ cauldron"}].function set value 'function terf:entity/machines/crusher/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ hopper"}].function set value 'function terf:entity/machines/crane/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ iron_block"}].function set value 'function terf:entity/machines/opencore/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_oxidized_copper_grate positioned ~ ~13 ~"}].function set value 'function terf:entity/machines/stfr/setup with entity @s data.terf'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_copper_grate"}].function set value 'function terf:entity/machines/warp_core/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ anvil"}].function set value 'function terf:entity/machines/battery_array/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ green_glazed_terracotta"}].function set value 'function terf:entity/machines/pressurizer/setup with entity @s data.terf'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ magenta_glazed_terracotta"}].function set value 'data modify entity @s data.terf.multiblock_function set value "run function terf:entity/machines/conveyor/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ command_block"}].function set value 'data modify entity @s data.terf.multiblock_function set value "run function terf:entity/machines/dev_block/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ observer[facing=down] if block ~ ~1 ~ glass"}].function set value 'function terf:entity/machines/security_turret/setup_top'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ observer[facing=up] if block ~ ~-1 ~ glass"}].function set value 'function terf:entity/machines/security_turret/setup_bottom'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ observer"}].function set value 'data modify entity @s data.terf.multiblock_function set value "run function terf:entity/machines/block_placer/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ brown_glazed_terracotta if block ~ ~1 ~ granite_slab[type=double]"}].function set value 'data modify entity @s data.terf.multiblock_function set value "run function terf:entity/machines/electrolyzer/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ sticky_piston[facing=down]"}].function set value 'data modify entity @s data.terf.multiblock_function set value "run function terf:entity/machines/ore_drill/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ lodestone if block ^ ^1 ^ note_block"}].function set value 'data modify entity @s data.terf.multiblock_function set value "if block ^-1 ^1 ^ loom if block ^1 ^1 ^ loom if block ^ ^2 ^ observer if block ^-1 ^2 ^ observer if block ^1 ^2 ^ observer run return run function terf:entity/machines/mainframe/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ waxed_oxidized_cut_copper"}].function set value 'data modify entity @s data.terf.multiblock_function set value "run function terf:entity/machines/stasis_laser/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ cauldron"}].function set value 'data modify entity @s data.terf.multiblock_function set value "if block ^ ^ ^-1 sticky_piston if block ^-1 ^ ^ sticky_piston if block ^-1 ^ ^-1 waxed_copper_bulb if block ^1 ^ ^-1 brown_glazed_terracotta if block ^1 ^ ^ hopper run return run function terf:entity/machines/fission_fuel_loader/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ quartz_block"}].function set value 'data modify entity @s data.terf.multiblock_function set value "if block ^ ^1 ^ comparator if block ^ ^ ^-1 granite_slab[type=double] if block ^ ^ ^1 iron_chain run return run function terf:entity/machines/variable_resistor/tick"'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ grindstone"}].function set value 'function terf:entity/machines/steam_engine/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ barrel"}].function set value 'function terf:entity/machines/assembler/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ granite_stairs if block ^1 ^1 ^-1 dispenser"}].function set value 'function terf:entity/machines/extrusion_press/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ granite_stairs if block ^1 ^1 ^-1 dropper if block ^1 ^1 ^ iron_trapdoor[open=true]"}].function set value 'function terf:entity/machines/shearing_press/setup with entity @s data.terf'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ respawn_anchor"}].function set value 'function terf:entity/machines/chunk_loader/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ crafter if block ~ ~1 ~ petrified_oak_slab[type=double]"}].function set value 'function terf:entity/machines/ebf/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ polished_blackstone_stairs"}].function set value 'function terf:entity/machines/capsule_interface/setup with entity @s data.terf'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ brown_glazed_terracotta if block ~ ~1 ~ iron_bars"}].function set value 'function terf:entity/machines/deuterium_concentrator/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ redstone_block"}].function set value 'function terf:entity/machines/solar_panel/setup'
data modify storage terf:constants mb_setup_functions[{checks:"if block ~ ~ ~ petrified_oak_slab[type=double]"}].function set value 'data modify entity @s data.terf.multiblock_function set value "run function terf:entity/machines/ionizer/tick"'

#==================================================| Set Constants |==================================================
function terf:block_colors

#set hex values
scoreboard players set 999 terf_states 999
scoreboard players set 1600 terf_states 1600
scoreboard players set 1000 terf_states 1000
scoreboard players set 500 terf_states 500
scoreboard players set 300 terf_states 300
scoreboard players set 150000 terf_states 150000
scoreboard players set 20000 terf_states 20000
scoreboard players set 2000 terf_states 2000
scoreboard players set 10 terf_states 10
scoreboard players set 15 terf_states 15
scoreboard players set 16 terf_states 16
scoreboard players set 20 terf_states 20
scoreboard players set 21 terf_states 21
scoreboard players set 24 terf_states 24
scoreboard players set 70 terf_states 70
scoreboard players set 120 terf_states 120
scoreboard players set 200 terf_states 200
scoreboard players set 60 terf_states 60
scoreboard players set 4888 terf_states 4888
scoreboard players set 1200 terf_states 1200
scoreboard players set 80 terf_states 80
scoreboard players set 40 terf_states 40
scoreboard players set 46 terf_states 46
scoreboard players set 90 terf_states 90
scoreboard players set 99 terf_states 99
scoreboard players set 30 terf_states 30
scoreboard players set 0 terf_states 0
scoreboard players set 1 terf_states 1
scoreboard players set 2 terf_states 2
scoreboard players set 3 terf_states 3
scoreboard players set 4 terf_states 4
scoreboard players set 5 terf_states 5
scoreboard players set 6 terf_states 6
scoreboard players set 7 terf_states 7
scoreboard players set 8 terf_states 8
scoreboard players set 9 terf_states 9
scoreboard players set -1 terf_states -1
scoreboard players set -5 terf_states -5
scoreboard players set -3 terf_states -3
scoreboard players set 100 terf_states 100
scoreboard players set 97 terf_states 97
scoreboard players set 128 terf_states 128
scoreboard players set 150 terf_states 150
scoreboard players set 119 terf_states 119
scoreboard players set 240 terf_states 240
scoreboard players set -180 terf_states -180
scoreboard players set 180 terf_states 180
scoreboard players set 360 terf_states 360
scoreboard players set 800 terf_states 800
scoreboard players set 4214 terf_states 4214
scoreboard players set 50436 terf_states 50436
scoreboard players set 50 terf_states 50
scoreboard players set 13 terf_states 13
scoreboard players set 70000 terf_states 70000
scoreboard players set 1800 terf_states 1800
scoreboard players set 1000 terf_states 1000
scoreboard players set 3000 terf_states 3000
scoreboard players set 5000 terf_states 5000
scoreboard players set 10000 terf_states 10000
scoreboard players set 100000 terf_states 100000
scoreboard players set 1000000 terf_states 1000000
scoreboard players set 10000000 terf_states 10000000
scoreboard players set 1436 terf_states 1436
scoreboard players set 22 terf_states 22
scoreboard players set 8000 terf_states 8000
scoreboard players set 9000 terf_states 9000
scoreboard players set 5600 terf_states 5600
scoreboard players set 141 terf_states 141
scoreboard players set 142 terf_states 142
scoreboard players set 1982 terf_states 1982
scoreboard players set 69 terf_states 69
scoreboard players set 65536 terf_states 65536
scoreboard players set 256 terf_states 256
scoreboard players set 2147483647 terf_states 2147483647
scoreboard players set 512 terf_states 512
scoreboard players set 1024 terf_states 1024
scoreboard players set 2048 terf_states 2048
scoreboard players set 255 terf_states 255
scoreboard players set 246 terf_states 246
scoreboard players set 11604 terf_states 11604
scoreboard players set 74 terf_states 74
scoreboard players set 67 terf_states 67
scoreboard players set 167 terf_states 167
scoreboard players set 16777216 terf_states 16777216
scoreboard players set 12000 terf_states 12000
scoreboard players set 50000 terf_states 50000

data modify storage terf:constants hex.0 set value "00"
data modify storage terf:constants hex.1 set value "01"
data modify storage terf:constants hex.2 set value "02"
data modify storage terf:constants hex.3 set value "03"
data modify storage terf:constants hex.4 set value "04"
data modify storage terf:constants hex.5 set value "05"
data modify storage terf:constants hex.6 set value "06"
data modify storage terf:constants hex.7 set value "07"
data modify storage terf:constants hex.8 set value "08"
data modify storage terf:constants hex.9 set value "09"
data modify storage terf:constants hex.10 set value "0A"
data modify storage terf:constants hex.11 set value "0B"
data modify storage terf:constants hex.12 set value "0C"
data modify storage terf:constants hex.13 set value "0D"
data modify storage terf:constants hex.14 set value "0E"
data modify storage terf:constants hex.15 set value "0F"
data modify storage terf:constants hex.16 set value "10"
data modify storage terf:constants hex.17 set value "11"
data modify storage terf:constants hex.18 set value "12"
data modify storage terf:constants hex.19 set value "13"
data modify storage terf:constants hex.20 set value "14"
data modify storage terf:constants hex.21 set value "15"
data modify storage terf:constants hex.22 set value "16"
data modify storage terf:constants hex.23 set value "17"
data modify storage terf:constants hex.24 set value "18"
data modify storage terf:constants hex.25 set value "19"
data modify storage terf:constants hex.26 set value "1A"
data modify storage terf:constants hex.27 set value "1B"
data modify storage terf:constants hex.28 set value "1C"
data modify storage terf:constants hex.29 set value "1D"
data modify storage terf:constants hex.30 set value "1E"
data modify storage terf:constants hex.31 set value "1F"
data modify storage terf:constants hex.32 set value "20"
data modify storage terf:constants hex.33 set value "21"
data modify storage terf:constants hex.34 set value "22"
data modify storage terf:constants hex.35 set value "23"
data modify storage terf:constants hex.36 set value "24"
data modify storage terf:constants hex.37 set value "25"
data modify storage terf:constants hex.38 set value "26"
data modify storage terf:constants hex.39 set value "27"
data modify storage terf:constants hex.40 set value "28"
data modify storage terf:constants hex.41 set value "29"
data modify storage terf:constants hex.42 set value "2A"
data modify storage terf:constants hex.43 set value "2B"
data modify storage terf:constants hex.44 set value "2C"
data modify storage terf:constants hex.45 set value "2D"
data modify storage terf:constants hex.46 set value "2E"
data modify storage terf:constants hex.47 set value "2F"
data modify storage terf:constants hex.48 set value "30"
data modify storage terf:constants hex.49 set value "31"
data modify storage terf:constants hex.50 set value "32"
data modify storage terf:constants hex.51 set value "33"
data modify storage terf:constants hex.52 set value "34"
data modify storage terf:constants hex.53 set value "35"
data modify storage terf:constants hex.54 set value "36"
data modify storage terf:constants hex.55 set value "37"
data modify storage terf:constants hex.56 set value "38"
data modify storage terf:constants hex.57 set value "39"
data modify storage terf:constants hex.58 set value "3A"
data modify storage terf:constants hex.59 set value "3B"
data modify storage terf:constants hex.60 set value "3C"
data modify storage terf:constants hex.61 set value "3D"
data modify storage terf:constants hex.62 set value "3E"
data modify storage terf:constants hex.63 set value "3F"
data modify storage terf:constants hex.64 set value "40"
data modify storage terf:constants hex.65 set value "41"
data modify storage terf:constants hex.66 set value "42"
data modify storage terf:constants hex.67 set value "43"
data modify storage terf:constants hex.68 set value "44"
data modify storage terf:constants hex.69 set value "45"
data modify storage terf:constants hex.70 set value "46"
data modify storage terf:constants hex.71 set value "47"
data modify storage terf:constants hex.72 set value "48"
data modify storage terf:constants hex.73 set value "49"
data modify storage terf:constants hex.74 set value "4A"
data modify storage terf:constants hex.75 set value "4B"
data modify storage terf:constants hex.76 set value "4C"
data modify storage terf:constants hex.77 set value "4D"
data modify storage terf:constants hex.78 set value "4E"
data modify storage terf:constants hex.79 set value "4F"
data modify storage terf:constants hex.80 set value "50"
data modify storage terf:constants hex.81 set value "51"
data modify storage terf:constants hex.82 set value "52"
data modify storage terf:constants hex.83 set value "53"
data modify storage terf:constants hex.84 set value "54"
data modify storage terf:constants hex.85 set value "55"
data modify storage terf:constants hex.86 set value "56"
data modify storage terf:constants hex.87 set value "57"
data modify storage terf:constants hex.88 set value "58"
data modify storage terf:constants hex.89 set value "59"
data modify storage terf:constants hex.90 set value "5A"
data modify storage terf:constants hex.91 set value "5B"
data modify storage terf:constants hex.92 set value "5C"
data modify storage terf:constants hex.93 set value "5D"
data modify storage terf:constants hex.94 set value "5E"
data modify storage terf:constants hex.95 set value "5F"
data modify storage terf:constants hex.96 set value "60"
data modify storage terf:constants hex.97 set value "61"
data modify storage terf:constants hex.98 set value "62"
data modify storage terf:constants hex.99 set value "63"
data modify storage terf:constants hex.100 set value "64"
data modify storage terf:constants hex.101 set value "65"
data modify storage terf:constants hex.102 set value "66"
data modify storage terf:constants hex.103 set value "67"
data modify storage terf:constants hex.104 set value "68"
data modify storage terf:constants hex.105 set value "69"
data modify storage terf:constants hex.106 set value "6A"
data modify storage terf:constants hex.107 set value "6B"
data modify storage terf:constants hex.108 set value "6C"
data modify storage terf:constants hex.109 set value "6D"
data modify storage terf:constants hex.110 set value "6E"
data modify storage terf:constants hex.111 set value "6F"
data modify storage terf:constants hex.112 set value "70"
data modify storage terf:constants hex.113 set value "71"
data modify storage terf:constants hex.114 set value "72"
data modify storage terf:constants hex.115 set value "73"
data modify storage terf:constants hex.116 set value "74"
data modify storage terf:constants hex.117 set value "75"
data modify storage terf:constants hex.118 set value "76"
data modify storage terf:constants hex.119 set value "77"
data modify storage terf:constants hex.120 set value "78"
data modify storage terf:constants hex.121 set value "79"
data modify storage terf:constants hex.122 set value "7A"
data modify storage terf:constants hex.123 set value "7B"
data modify storage terf:constants hex.124 set value "7C"
data modify storage terf:constants hex.125 set value "7D"
data modify storage terf:constants hex.126 set value "7E"
data modify storage terf:constants hex.127 set value "7F"
data modify storage terf:constants hex.128 set value "80"
data modify storage terf:constants hex.129 set value "81"
data modify storage terf:constants hex.130 set value "82"
data modify storage terf:constants hex.131 set value "83"
data modify storage terf:constants hex.132 set value "84"
data modify storage terf:constants hex.133 set value "85"
data modify storage terf:constants hex.134 set value "86"
data modify storage terf:constants hex.135 set value "87"
data modify storage terf:constants hex.136 set value "88"
data modify storage terf:constants hex.137 set value "89"
data modify storage terf:constants hex.138 set value "8A"
data modify storage terf:constants hex.139 set value "8B"
data modify storage terf:constants hex.140 set value "8C"
data modify storage terf:constants hex.141 set value "8D"
data modify storage terf:constants hex.142 set value "8E"
data modify storage terf:constants hex.143 set value "8F"
data modify storage terf:constants hex.144 set value "90"
data modify storage terf:constants hex.145 set value "91"
data modify storage terf:constants hex.146 set value "92"
data modify storage terf:constants hex.147 set value "93"
data modify storage terf:constants hex.148 set value "94"
data modify storage terf:constants hex.149 set value "95"
data modify storage terf:constants hex.150 set value "96"
data modify storage terf:constants hex.151 set value "97"
data modify storage terf:constants hex.152 set value "98"
data modify storage terf:constants hex.153 set value "99"
data modify storage terf:constants hex.154 set value "9A"
data modify storage terf:constants hex.155 set value "9B"
data modify storage terf:constants hex.156 set value "9C"
data modify storage terf:constants hex.157 set value "9D"
data modify storage terf:constants hex.158 set value "9E"
data modify storage terf:constants hex.159 set value "9F"
data modify storage terf:constants hex.160 set value "A0"
data modify storage terf:constants hex.161 set value "A1"
data modify storage terf:constants hex.162 set value "A2"
data modify storage terf:constants hex.163 set value "A3"
data modify storage terf:constants hex.164 set value "A4"
data modify storage terf:constants hex.165 set value "A5"
data modify storage terf:constants hex.166 set value "A6"
data modify storage terf:constants hex.167 set value "A7"
data modify storage terf:constants hex.168 set value "A8"
data modify storage terf:constants hex.169 set value "A9"
data modify storage terf:constants hex.170 set value "AA"
data modify storage terf:constants hex.171 set value "AB"
data modify storage terf:constants hex.172 set value "AC"
data modify storage terf:constants hex.173 set value "AD"
data modify storage terf:constants hex.174 set value "AE"
data modify storage terf:constants hex.175 set value "AF"
data modify storage terf:constants hex.176 set value "B0"
data modify storage terf:constants hex.177 set value "B1"
data modify storage terf:constants hex.178 set value "B2"
data modify storage terf:constants hex.179 set value "B3"
data modify storage terf:constants hex.180 set value "B4"
data modify storage terf:constants hex.181 set value "B5"
data modify storage terf:constants hex.182 set value "B6"
data modify storage terf:constants hex.183 set value "B7"
data modify storage terf:constants hex.184 set value "B8"
data modify storage terf:constants hex.185 set value "B9"
data modify storage terf:constants hex.186 set value "BA"
data modify storage terf:constants hex.187 set value "BB"
data modify storage terf:constants hex.188 set value "BC"
data modify storage terf:constants hex.189 set value "BD"
data modify storage terf:constants hex.190 set value "BE"
data modify storage terf:constants hex.191 set value "BF"
data modify storage terf:constants hex.192 set value "C0"
data modify storage terf:constants hex.193 set value "C1"
data modify storage terf:constants hex.194 set value "C2"
data modify storage terf:constants hex.195 set value "C3"
data modify storage terf:constants hex.196 set value "C4"
data modify storage terf:constants hex.197 set value "C5"
data modify storage terf:constants hex.198 set value "C6"
data modify storage terf:constants hex.199 set value "C7"
data modify storage terf:constants hex.200 set value "C8"
data modify storage terf:constants hex.201 set value "C9"
data modify storage terf:constants hex.202 set value "CA"
data modify storage terf:constants hex.203 set value "CB"
data modify storage terf:constants hex.204 set value "CC"
data modify storage terf:constants hex.205 set value "CD"
data modify storage terf:constants hex.206 set value "CE"
data modify storage terf:constants hex.207 set value "CF"
data modify storage terf:constants hex.208 set value "D0"
data modify storage terf:constants hex.209 set value "D1"
data modify storage terf:constants hex.210 set value "D2"
data modify storage terf:constants hex.211 set value "D3"
data modify storage terf:constants hex.212 set value "D4"
data modify storage terf:constants hex.213 set value "D5"
data modify storage terf:constants hex.214 set value "D6"
data modify storage terf:constants hex.215 set value "D7"
data modify storage terf:constants hex.216 set value "D8"
data modify storage terf:constants hex.217 set value "D9"
data modify storage terf:constants hex.218 set value "DA"
data modify storage terf:constants hex.219 set value "DB"
data modify storage terf:constants hex.220 set value "DC"
data modify storage terf:constants hex.221 set value "DD"
data modify storage terf:constants hex.222 set value "DE"
data modify storage terf:constants hex.223 set value "DF"
data modify storage terf:constants hex.224 set value "E0"
data modify storage terf:constants hex.225 set value "E1"
data modify storage terf:constants hex.226 set value "E2"
data modify storage terf:constants hex.227 set value "E3"
data modify storage terf:constants hex.228 set value "E4"
data modify storage terf:constants hex.229 set value "E5"
data modify storage terf:constants hex.230 set value "E6"
data modify storage terf:constants hex.231 set value "E7"
data modify storage terf:constants hex.232 set value "E8"
data modify storage terf:constants hex.233 set value "E9"
data modify storage terf:constants hex.234 set value "EA"
data modify storage terf:constants hex.235 set value "EB"
data modify storage terf:constants hex.236 set value "EC"
data modify storage terf:constants hex.237 set value "ED"
data modify storage terf:constants hex.238 set value "EE"
data modify storage terf:constants hex.239 set value "EF"
data modify storage terf:constants hex.240 set value "F0"
data modify storage terf:constants hex.241 set value "F1"
data modify storage terf:constants hex.242 set value "F2"
data modify storage terf:constants hex.243 set value "F3"
data modify storage terf:constants hex.244 set value "F4"
data modify storage terf:constants hex.245 set value "F5"
data modify storage terf:constants hex.246 set value "F6"
data modify storage terf:constants hex.247 set value "F7"
data modify storage terf:constants hex.248 set value "F8"
data modify storage terf:constants hex.249 set value "F9"
data modify storage terf:constants hex.250 set value "FA"
data modify storage terf:constants hex.251 set value "FB"
data modify storage terf:constants hex.252 set value "FC"
data modify storage terf:constants hex.253 set value "FD"
data modify storage terf:constants hex.254 set value "FE"
data modify storage terf:constants hex.255 set value "FF"

data modify storage terf:constants blackbody.0 set value 0
data modify storage terf:constants blackbody.1 set value 0
data modify storage terf:constants blackbody.2 set value 0
data modify storage terf:constants blackbody.3 set value 0
data modify storage terf:constants blackbody.4 set value 0
data modify storage terf:constants blackbody.5 set value 0
data modify storage terf:constants blackbody.6 set value 0
data modify storage terf:constants blackbody.7 set value 0
data modify storage terf:constants blackbody.8 set value 0
data modify storage terf:constants blackbody.9 set value 0
data modify storage terf:constants blackbody.10 set value 0
data modify storage terf:constants blackbody.11 set value 0
data modify storage terf:constants blackbody.12 set value 524288
data modify storage terf:constants blackbody.13 set value 1048576
data modify storage terf:constants blackbody.14 set value 1572864
data modify storage terf:constants blackbody.15 set value 2097152
data modify storage terf:constants blackbody.16 set value 2621440
data modify storage terf:constants blackbody.17 set value 3145728
data modify storage terf:constants blackbody.18 set value 3670016
data modify storage terf:constants blackbody.19 set value 4194304
data modify storage terf:constants blackbody.20 set value 4718592
data modify storage terf:constants blackbody.31 set value 5242880
data modify storage terf:constants blackbody.32 set value 5767168
data modify storage terf:constants blackbody.33 set value 6291456
data modify storage terf:constants blackbody.34 set value 6815744
data modify storage terf:constants blackbody.35 set value 7340032
data modify storage terf:constants blackbody.36 set value 7864320
data modify storage terf:constants blackbody.37 set value 8388608
data modify storage terf:constants blackbody.38 set value 8912896
data modify storage terf:constants blackbody.39 set value 9437184
data modify storage terf:constants blackbody.40 set value 9961472
data modify storage terf:constants blackbody.41 set value 10485760
data modify storage terf:constants blackbody.42 set value 11010048
data modify storage terf:constants blackbody.43 set value 11534336
data modify storage terf:constants blackbody.44 set value 12058624
data modify storage terf:constants blackbody.45 set value 12582912
data modify storage terf:constants blackbody.46 set value 13107200
data modify storage terf:constants blackbody.47 set value 13631488
data modify storage terf:constants blackbody.48 set value 14155776
data modify storage terf:constants blackbody.49 set value 14680064
data modify storage terf:constants blackbody.50 set value 15204352
data modify storage terf:constants blackbody.51 set value 16711680
data modify storage terf:constants blackbody.52 set value 16712192
data modify storage terf:constants blackbody.53 set value 16712704
data modify storage terf:constants blackbody.54 set value 16713216
data modify storage terf:constants blackbody.55 set value 16713728
data modify storage terf:constants blackbody.56 set value 16714240
data modify storage terf:constants blackbody.57 set value 16714752
data modify storage terf:constants blackbody.58 set value 16715008
data modify storage terf:constants blackbody.59 set value 16715520
data modify storage terf:constants blackbody.60 set value 16716032
data modify storage terf:constants blackbody.61 set value 16716288
data modify storage terf:constants blackbody.62 set value 16716800
data modify storage terf:constants blackbody.63 set value 16717056
data modify storage terf:constants blackbody.64 set value 16717568
data modify storage terf:constants blackbody.65 set value 16718080
data modify storage terf:constants blackbody.66 set value 16718336
data modify storage terf:constants blackbody.67 set value 16718848
data modify storage terf:constants blackbody.68 set value 16719104
data modify storage terf:constants blackbody.69 set value 16719616
data modify storage terf:constants blackbody.70 set value 16719872
data modify storage terf:constants blackbody.71 set value 16720128
data modify storage terf:constants blackbody.72 set value 16720640
data modify storage terf:constants blackbody.73 set value 16720896
data modify storage terf:constants blackbody.74 set value 16721152
data modify storage terf:constants blackbody.75 set value 16721664
data modify storage terf:constants blackbody.76 set value 16721920
data modify storage terf:constants blackbody.77 set value 16722176
data modify storage terf:constants blackbody.78 set value 16722688
data modify storage terf:constants blackbody.79 set value 16722944
data modify storage terf:constants blackbody.80 set value 16723200
data modify storage terf:constants blackbody.81 set value 16723456
data modify storage terf:constants blackbody.82 set value 16723968
data modify storage terf:constants blackbody.83 set value 16724224
data modify storage terf:constants blackbody.84 set value 16724480
data modify storage terf:constants blackbody.85 set value 16724736
data modify storage terf:constants blackbody.86 set value 16724992
data modify storage terf:constants blackbody.87 set value 16725504
data modify storage terf:constants blackbody.88 set value 16725760
data modify storage terf:constants blackbody.89 set value 16726016
data modify storage terf:constants blackbody.90 set value 16726272
data modify storage terf:constants blackbody.91 set value 16726528
data modify storage terf:constants blackbody.92 set value 16726784
data modify storage terf:constants blackbody.93 set value 16727040
data modify storage terf:constants blackbody.94 set value 16727296
data modify storage terf:constants blackbody.95 set value 16727552
data modify storage terf:constants blackbody.96 set value 16727808
data modify storage terf:constants blackbody.97 set value 16728064
data modify storage terf:constants blackbody.98 set value 16728320
data modify storage terf:constants blackbody.99 set value 16728576
data modify storage terf:constants blackbody.100 set value 16728832
data modify storage terf:constants blackbody.101 set value 16729088
data modify storage terf:constants blackbody.102 set value 16729344
data modify storage terf:constants blackbody.103 set value 16729600
data modify storage terf:constants blackbody.104 set value 16729856
data modify storage terf:constants blackbody.105 set value 16730112
data modify storage terf:constants blackbody.106 set value 16730368
data modify storage terf:constants blackbody.107 set value 16730624
data modify storage terf:constants blackbody.108 set value 16730880
data modify storage terf:constants blackbody.109 set value 16731136
data modify storage terf:constants blackbody.110 set value 16731392
data modify storage terf:constants blackbody.111 set value 16731648
data modify storage terf:constants blackbody.112 set value 16731904
data modify storage terf:constants blackbody.113 set value 16732160
data modify storage terf:constants blackbody.114 set value 16732160
data modify storage terf:constants blackbody.115 set value 16732416
data modify storage terf:constants blackbody.116 set value 16732672
data modify storage terf:constants blackbody.117 set value 16732928
data modify storage terf:constants blackbody.118 set value 16733184
data modify storage terf:constants blackbody.119 set value 16733440
data modify storage terf:constants blackbody.120 set value 16733696
data modify storage terf:constants blackbody.121 set value 16733696
data modify storage terf:constants blackbody.122 set value 16733952
data modify storage terf:constants blackbody.123 set value 16734208
data modify storage terf:constants blackbody.124 set value 16734464
data modify storage terf:constants blackbody.125 set value 16734720
data modify storage terf:constants blackbody.126 set value 16734720
data modify storage terf:constants blackbody.127 set value 16734976
data modify storage terf:constants blackbody.128 set value 16735232
data modify storage terf:constants blackbody.129 set value 16735488
data modify storage terf:constants blackbody.130 set value 16735744
data modify storage terf:constants blackbody.131 set value 16735744
data modify storage terf:constants blackbody.132 set value 16736000
data modify storage terf:constants blackbody.133 set value 16736256
data modify storage terf:constants blackbody.134 set value 16736512
data modify storage terf:constants blackbody.135 set value 16736512
data modify storage terf:constants blackbody.136 set value 16736768
data modify storage terf:constants blackbody.137 set value 16737024
data modify storage terf:constants blackbody.138 set value 16737024
data modify storage terf:constants blackbody.139 set value 16737280
data modify storage terf:constants blackbody.140 set value 16737536
data modify storage terf:constants blackbody.141 set value 16737792
data modify storage terf:constants blackbody.142 set value 16737792
data modify storage terf:constants blackbody.143 set value 16738048
data modify storage terf:constants blackbody.144 set value 16738304
data modify storage terf:constants blackbody.145 set value 16738304
data modify storage terf:constants blackbody.146 set value 16738560
data modify storage terf:constants blackbody.147 set value 16738816
data modify storage terf:constants blackbody.148 set value 16738816
data modify storage terf:constants blackbody.149 set value 16739072
data modify storage terf:constants blackbody.150 set value 16739328
data modify storage terf:constants blackbody.151 set value 16739328
data modify storage terf:constants blackbody.152 set value 16739584
data modify storage terf:constants blackbody.153 set value 16739840
data modify storage terf:constants blackbody.154 set value 16739840
data modify storage terf:constants blackbody.155 set value 16740096
data modify storage terf:constants blackbody.156 set value 16740352
data modify storage terf:constants blackbody.157 set value 16740352
data modify storage terf:constants blackbody.158 set value 16740608
data modify storage terf:constants blackbody.159 set value 16740864
data modify storage terf:constants blackbody.160 set value 16740864
data modify storage terf:constants blackbody.161 set value 16741120
data modify storage terf:constants blackbody.162 set value 16741120
data modify storage terf:constants blackbody.163 set value 16741376
data modify storage terf:constants blackbody.164 set value 16741632
data modify storage terf:constants blackbody.165 set value 16741632
data modify storage terf:constants blackbody.166 set value 16741888
data modify storage terf:constants blackbody.167 set value 16741888
data modify storage terf:constants blackbody.168 set value 16742144
data modify storage terf:constants blackbody.169 set value 16742400
data modify storage terf:constants blackbody.170 set value 16742400
data modify storage terf:constants blackbody.171 set value 16742656
data modify storage terf:constants blackbody.172 set value 16742656
data modify storage terf:constants blackbody.173 set value 16742912
data modify storage terf:constants blackbody.174 set value 16743168
data modify storage terf:constants blackbody.175 set value 16743168
data modify storage terf:constants blackbody.176 set value 16743424
data modify storage terf:constants blackbody.177 set value 16743424
data modify storage terf:constants blackbody.178 set value 16743680
data modify storage terf:constants blackbody.179 set value 16743680
data modify storage terf:constants blackbody.180 set value 16743936
data modify storage terf:constants blackbody.181 set value 16743936
data modify storage terf:constants blackbody.182 set value 16744192
data modify storage terf:constants blackbody.183 set value 16744448
data modify storage terf:constants blackbody.184 set value 16744448
data modify storage terf:constants blackbody.185 set value 16744704
data modify storage terf:constants blackbody.186 set value 16744704
data modify storage terf:constants blackbody.187 set value 16744960
data modify storage terf:constants blackbody.188 set value 16744960
data modify storage terf:constants blackbody.189 set value 16745216
data modify storage terf:constants blackbody.190 set value 16745216
data modify storage terf:constants blackbody.191 set value 16745472
data modify storage terf:constants blackbody.192 set value 16745474
data modify storage terf:constants blackbody.193 set value 16745731
data modify storage terf:constants blackbody.194 set value 16745733
data modify storage terf:constants blackbody.195 set value 16745990
data modify storage terf:constants blackbody.196 set value 16745992
data modify storage terf:constants blackbody.197 set value 16746249
data modify storage terf:constants blackbody.198 set value 16746251
data modify storage terf:constants blackbody.199 set value 16746508
data modify storage terf:constants blackbody.200 set value 16746509
data modify storage terf:constants blackbody.201 set value 16746767
data modify storage terf:constants blackbody.202 set value 16746768
data modify storage terf:constants blackbody.203 set value 16747025
data modify storage terf:constants blackbody.204 set value 16747027
data modify storage terf:constants blackbody.205 set value 16747284
data modify storage terf:constants blackbody.206 set value 16747285
data modify storage terf:constants blackbody.207 set value 16747543
data modify storage terf:constants blackbody.208 set value 16747544
data modify storage terf:constants blackbody.209 set value 16747801
data modify storage terf:constants blackbody.210 set value 16747803
data modify storage terf:constants blackbody.211 set value 16748060
data modify storage terf:constants blackbody.212 set value 16748061
data modify storage terf:constants blackbody.213 set value 16748318
data modify storage terf:constants blackbody.214 set value 16748320
data modify storage terf:constants blackbody.215 set value 16748577
data modify storage terf:constants blackbody.216 set value 16748578
data modify storage terf:constants blackbody.217 set value 16748579
data modify storage terf:constants blackbody.218 set value 16748836
data modify storage terf:constants blackbody.219 set value 16748837
data modify storage terf:constants blackbody.220 set value 16749095
data modify storage terf:constants blackbody.221 set value 16749096
data modify storage terf:constants blackbody.222 set value 16749353
data modify storage terf:constants blackbody.223 set value 16749354
data modify storage terf:constants blackbody.224 set value 16749611
data modify storage terf:constants blackbody.225 set value 16749612
data modify storage terf:constants blackbody.226 set value 16749869
data modify storage terf:constants blackbody.227 set value 16749871
data modify storage terf:constants blackbody.228 set value 16749872
data modify storage terf:constants blackbody.229 set value 16750129
data modify storage terf:constants blackbody.230 set value 16750130
data modify storage terf:constants blackbody.231 set value 16750387
data modify storage terf:constants blackbody.232 set value 16750388
data modify storage terf:constants blackbody.233 set value 16750645
data modify storage terf:constants blackbody.234 set value 16750646
data modify storage terf:constants blackbody.235 set value 16750647
data modify storage terf:constants blackbody.236 set value 16750904
data modify storage terf:constants blackbody.237 set value 16750905
data modify storage terf:constants blackbody.238 set value 16751162
data modify storage terf:constants blackbody.239 set value 16751163
data modify storage terf:constants blackbody.240 set value 16751420
data modify storage terf:constants blackbody.241 set value 16751421
data modify storage terf:constants blackbody.242 set value 16751422
data modify storage terf:constants blackbody.243 set value 16751679
data modify storage terf:constants blackbody.244 set value 16751680
data modify storage terf:constants blackbody.245 set value 16751937
data modify storage terf:constants blackbody.246 set value 16751938
data modify storage terf:constants blackbody.247 set value 16751939
data modify storage terf:constants blackbody.248 set value 16752196
data modify storage terf:constants blackbody.249 set value 16752197
data modify storage terf:constants blackbody.250 set value 16752454
data modify storage terf:constants blackbody.251 set value 16752454
data modify storage terf:constants blackbody.252 set value 16752455
data modify storage terf:constants blackbody.253 set value 16752712
data modify storage terf:constants blackbody.254 set value 16752713
data modify storage terf:constants blackbody.255 set value 16752970
data modify storage terf:constants blackbody.256 set value 16752971
data modify storage terf:constants blackbody.257 set value 16752972
data modify storage terf:constants blackbody.258 set value 16753229
data modify storage terf:constants blackbody.259 set value 16753230
data modify storage terf:constants blackbody.260 set value 16753231
data modify storage terf:constants blackbody.261 set value 16753487
data modify storage terf:constants blackbody.262 set value 16753488
data modify storage terf:constants blackbody.263 set value 16753745
data modify storage terf:constants blackbody.264 set value 16753746
data modify storage terf:constants blackbody.265 set value 16753747
data modify storage terf:constants blackbody.266 set value 16754004
data modify storage terf:constants blackbody.267 set value 16754004
data modify storage terf:constants blackbody.268 set value 16754005
data modify storage terf:constants blackbody.269 set value 16754262
data modify storage terf:constants blackbody.270 set value 16754263
data modify storage terf:constants blackbody.271 set value 16754520
data modify storage terf:constants blackbody.272 set value 16754521
data modify storage terf:constants blackbody.273 set value 16754521
data modify storage terf:constants blackbody.274 set value 16754778
data modify storage terf:constants blackbody.275 set value 16754779
data modify storage terf:constants blackbody.276 set value 16754780
data modify storage terf:constants blackbody.277 set value 16755036
data modify storage terf:constants blackbody.278 set value 16755037
data modify storage terf:constants blackbody.279 set value 16755038
data modify storage terf:constants blackbody.280 set value 16755295
data modify storage terf:constants blackbody.281 set value 16755296
data modify storage terf:constants blackbody.282 set value 16755552
data modify storage terf:constants blackbody.283 set value 16755553
data modify storage terf:constants blackbody.284 set value 16755554
data modify storage terf:constants blackbody.285 set value 16755811
data modify storage terf:constants blackbody.286 set value 16755811
data modify storage terf:constants blackbody.287 set value 16755812
data modify storage terf:constants blackbody.288 set value 16756069
data modify storage terf:constants blackbody.289 set value 16756070
data modify storage terf:constants blackbody.290 set value 16756070
data modify storage terf:constants blackbody.291 set value 16756327
data modify storage terf:constants blackbody.292 set value 16756328
data modify storage terf:constants blackbody.293 set value 16756328
data modify storage terf:constants blackbody.294 set value 16756585
data modify storage terf:constants blackbody.295 set value 16756586
data modify storage terf:constants blackbody.296 set value 16756587
data modify storage terf:constants blackbody.297 set value 16756843
data modify storage terf:constants blackbody.298 set value 16756844
data modify storage terf:constants blackbody.299 set value 16756845
data modify storage terf:constants blackbody.300 set value 16757101
data modify storage terf:constants blackbody.301 set value 16757102
data modify storage terf:constants blackbody.302 set value 16757103
data modify storage terf:constants blackbody.303 set value 16757359
data modify storage terf:constants blackbody.304 set value 16757360
data modify storage terf:constants blackbody.305 set value 16757361
data modify storage terf:constants blackbody.306 set value 16757618
data modify storage terf:constants blackbody.307 set value 16757618
data modify storage terf:constants blackbody.308 set value 16757619
data modify storage terf:constants blackbody.309 set value 16757876
data modify storage terf:constants blackbody.310 set value 16757876
data modify storage terf:constants blackbody.311 set value 16757877
data modify storage terf:constants blackbody.312 set value 16758133
data modify storage terf:constants blackbody.313 set value 16758134
data modify storage terf:constants blackbody.314 set value 16758135
data modify storage terf:constants blackbody.315 set value 16758391
data modify storage terf:constants blackbody.316 set value 16758392
data modify storage terf:constants blackbody.317 set value 16758393
data modify storage terf:constants blackbody.318 set value 16758393
data modify storage terf:constants blackbody.319 set value 16758650
data modify storage terf:constants blackbody.320 set value 16758651
data modify storage terf:constants blackbody.321 set value 16758651
data modify storage terf:constants blackbody.322 set value 16758908
data modify storage terf:constants blackbody.323 set value 16758908
data modify storage terf:constants blackbody.324 set value 16758909
data modify storage terf:constants blackbody.325 set value 16759166
data modify storage terf:constants blackbody.326 set value 16759166
data modify storage terf:constants blackbody.327 set value 16759167
data modify storage terf:constants blackbody.328 set value 16759424
data modify storage terf:constants blackbody.329 set value 16759424
data modify storage terf:constants blackbody.330 set value 16759425
data modify storage terf:constants blackbody.331 set value 16759425
data modify storage terf:constants blackbody.332 set value 16759682
data modify storage terf:constants blackbody.333 set value 16759683
data modify storage terf:constants blackbody.334 set value 16759683
data modify storage terf:constants blackbody.335 set value 16759940
data modify storage terf:constants blackbody.336 set value 16759940
data modify storage terf:constants blackbody.337 set value 16759941
data modify storage terf:constants blackbody.338 set value 16760198
data modify storage terf:constants blackbody.339 set value 16760198
data modify storage terf:constants blackbody.340 set value 16760199
data modify storage terf:constants blackbody.341 set value 16760199
data modify storage terf:constants blackbody.342 set value 16760456
data modify storage terf:constants blackbody.343 set value 16760456
data modify storage terf:constants blackbody.344 set value 16760457
data modify storage terf:constants blackbody.345 set value 16760714
data modify storage terf:constants blackbody.346 set value 16760714
data modify storage terf:constants blackbody.347 set value 16760715
data modify storage terf:constants blackbody.348 set value 16760715
data modify storage terf:constants blackbody.349 set value 16760972
data modify storage terf:constants blackbody.350 set value 16760972
data modify storage terf:constants blackbody.351 set value 16760973
data modify storage terf:constants blackbody.352 set value 16761229
data modify storage terf:constants blackbody.353 set value 16761230
data modify storage terf:constants blackbody.354 set value 16761231
data modify storage terf:constants blackbody.355 set value 16761231
data modify storage terf:constants blackbody.356 set value 16761488
data modify storage terf:constants blackbody.357 set value 16761488
data modify storage terf:constants blackbody.358 set value 16761489
data modify storage terf:constants blackbody.359 set value 16761745
data modify storage terf:constants blackbody.360 set value 16761746
data modify storage terf:constants blackbody.361 set value 16761746
data modify storage terf:constants blackbody.362 set value 16761747
data modify storage terf:constants blackbody.363 set value 16762003
data modify storage terf:constants blackbody.364 set value 16762004
data modify storage terf:constants blackbody.365 set value 16762004
data modify storage terf:constants blackbody.366 set value 16762005
data modify storage terf:constants blackbody.367 set value 16762261
data modify storage terf:constants blackbody.368 set value 16762262
data modify storage terf:constants blackbody.369 set value 16762262
data modify storage terf:constants blackbody.370 set value 16762519
data modify storage terf:constants blackbody.371 set value 16762519
data modify storage terf:constants blackbody.372 set value 16762520
data modify storage terf:constants blackbody.373 set value 16762521
data modify storage terf:constants blackbody.374 set value 16762777
data modify storage terf:constants blackbody.375 set value 16762778
data modify storage terf:constants blackbody.376 set value 16762778
data modify storage terf:constants blackbody.377 set value 16762779
data modify storage terf:constants blackbody.378 set value 16763035
data modify storage terf:constants blackbody.379 set value 16763036
data modify storage terf:constants blackbody.380 set value 16763036
data modify storage terf:constants blackbody.381 set value 16763037
data modify storage terf:constants blackbody.382 set value 16763293
data modify storage terf:constants blackbody.383 set value 16763294
data modify storage terf:constants blackbody.384 set value 16763294
data modify storage terf:constants blackbody.385 set value 16763550
data modify storage terf:constants blackbody.386 set value 16763551
data modify storage terf:constants blackbody.387 set value 16763551
data modify storage terf:constants blackbody.388 set value 16763552
data modify storage terf:constants blackbody.389 set value 16763808
data modify storage terf:constants blackbody.390 set value 16763809
data modify storage terf:constants blackbody.391 set value 16763809
data modify storage terf:constants blackbody.392 set value 16763810
data modify storage terf:constants blackbody.393 set value 16764066
data modify storage terf:constants blackbody.394 set value 16764067
data modify storage terf:constants blackbody.395 set value 16764067
data modify storage terf:constants blackbody.396 set value 16764068
data modify storage terf:constants blackbody.397 set value 16764324
data modify storage terf:constants blackbody.398 set value 16764325
data modify storage terf:constants blackbody.399 set value 16764325
data modify storage terf:constants blackbody.400 set value 16764326
data modify storage terf:constants blackbody.401 set value 16764582
data modify storage terf:constants blackbody.402 set value 16764583
data modify storage terf:constants blackbody.403 set value 16764583
data modify storage terf:constants blackbody.404 set value 16764583
data modify storage terf:constants blackbody.405 set value 16764840
data modify storage terf:constants blackbody.406 set value 16764840
data modify storage terf:constants blackbody.407 set value 16764841
data modify storage terf:constants blackbody.408 set value 16764841
data modify storage terf:constants blackbody.409 set value 16765098
data modify storage terf:constants blackbody.410 set value 16765098
data modify storage terf:constants blackbody.411 set value 16765099
data modify storage terf:constants blackbody.412 set value 16765099
data modify storage terf:constants blackbody.413 set value 16765099
data modify storage terf:constants blackbody.414 set value 16765356
data modify storage terf:constants blackbody.415 set value 16765356
data modify storage terf:constants blackbody.416 set value 16765357
data modify storage terf:constants blackbody.417 set value 16765357
data modify storage terf:constants blackbody.418 set value 16765614
data modify storage terf:constants blackbody.419 set value 16765614
data modify storage terf:constants blackbody.420 set value 16765615
data modify storage terf:constants blackbody.421 set value 16765615
data modify storage terf:constants blackbody.422 set value 16765871
data modify storage terf:constants blackbody.423 set value 16765872
data modify storage terf:constants blackbody.424 set value 16765872
data modify storage terf:constants blackbody.425 set value 16765873
data modify storage terf:constants blackbody.426 set value 16766129
data modify storage terf:constants blackbody.427 set value 16766130
data modify storage terf:constants blackbody.428 set value 16766130
data modify storage terf:constants blackbody.429 set value 16766130
data modify storage terf:constants blackbody.430 set value 16766387
data modify storage terf:constants blackbody.431 set value 16766387
data modify storage terf:constants blackbody.432 set value 16766388
data modify storage terf:constants blackbody.433 set value 16766388
data modify storage terf:constants blackbody.434 set value 16766388
data modify storage terf:constants blackbody.435 set value 16766645
data modify storage terf:constants blackbody.436 set value 16766645
data modify storage terf:constants blackbody.437 set value 16766646
data modify storage terf:constants blackbody.438 set value 16766646
data modify storage terf:constants blackbody.439 set value 16766903
data modify storage terf:constants blackbody.440 set value 16766903
data modify storage terf:constants blackbody.441 set value 16766903
data modify storage terf:constants blackbody.442 set value 16766904
data modify storage terf:constants blackbody.443 set value 16766904
data modify storage terf:constants blackbody.444 set value 16767161
data modify storage terf:constants blackbody.445 set value 16767161
data modify storage terf:constants blackbody.446 set value 16767161
data modify storage terf:constants blackbody.447 set value 16767162
data modify storage terf:constants blackbody.448 set value 16767418
data modify storage terf:constants blackbody.449 set value 16767419
data modify storage terf:constants blackbody.450 set value 16767419
data modify storage terf:constants blackbody.451 set value 16767419
data modify storage terf:constants blackbody.452 set value 16767420
data modify storage terf:constants blackbody.453 set value 16767676
data modify storage terf:constants blackbody.454 set value 16767677
data modify storage terf:constants blackbody.455 set value 16767677
data modify storage terf:constants blackbody.456 set value 16767677
data modify storage terf:constants blackbody.457 set value 16767934
data modify storage terf:constants blackbody.458 set value 16767934
data modify storage terf:constants blackbody.459 set value 16767934
data modify storage terf:constants blackbody.460 set value 16767935
data modify storage terf:constants blackbody.461 set value 16767935
data modify storage terf:constants blackbody.462 set value 16768192
data modify storage terf:constants blackbody.463 set value 16768192
data modify storage terf:constants blackbody.464 set value 16768192
data modify storage terf:constants blackbody.465 set value 16768193
data modify storage terf:constants blackbody.466 set value 16768449
data modify storage terf:constants blackbody.467 set value 16768450
data modify storage terf:constants blackbody.468 set value 16768450
data modify storage terf:constants blackbody.469 set value 16768450
data modify storage terf:constants blackbody.470 set value 16768451
data modify storage terf:constants blackbody.471 set value 16768707
data modify storage terf:constants blackbody.472 set value 16768707
data modify storage terf:constants blackbody.473 set value 16768708
data modify storage terf:constants blackbody.474 set value 16768708
data modify storage terf:constants blackbody.475 set value 16768708
data modify storage terf:constants blackbody.476 set value 16768965
data modify storage terf:constants blackbody.477 set value 16768965
data modify storage terf:constants blackbody.478 set value 16768966
data modify storage terf:constants blackbody.479 set value 16768966
data modify storage terf:constants blackbody.480 set value 16768966
data modify storage terf:constants blackbody.481 set value 16769223
data modify storage terf:constants blackbody.482 set value 16769223
data modify storage terf:constants blackbody.483 set value 16769223
data modify storage terf:constants blackbody.484 set value 16769224
data modify storage terf:constants blackbody.485 set value 16769224
data modify storage terf:constants blackbody.486 set value 16769480
data modify storage terf:constants blackbody.487 set value 16769481
data modify storage terf:constants blackbody.488 set value 16769481
data modify storage terf:constants blackbody.489 set value 16769482
data modify storage terf:constants blackbody.490 set value 16769738
data modify storage terf:constants blackbody.491 set value 16769738
data modify storage terf:constants blackbody.492 set value 16769739
data modify storage terf:constants blackbody.493 set value 16769739
data modify storage terf:constants blackbody.494 set value 16769739
data modify storage terf:constants blackbody.495 set value 16769996
data modify storage terf:constants blackbody.496 set value 16769996
data modify storage terf:constants blackbody.497 set value 16769996
data modify storage terf:constants blackbody.498 set value 16769997
data modify storage terf:constants blackbody.499 set value 16769997
data modify storage terf:constants blackbody.500 set value 16770253
data modify storage terf:constants blackbody.501 set value 16770254
data modify storage terf:constants blackbody.502 set value 16770254
data modify storage terf:constants blackbody.503 set value 16770254
data modify storage terf:constants blackbody.504 set value 16770255
data modify storage terf:constants blackbody.505 set value 16770511
data modify storage terf:constants blackbody.506 set value 16770511
data modify storage terf:constants blackbody.507 set value 16770512
data modify storage terf:constants blackbody.508 set value 16770512
data modify storage terf:constants blackbody.509 set value 16770513
data modify storage terf:constants blackbody.510 set value 16770513
data modify storage terf:constants blackbody.511 set value 16770769
data modify storage terf:constants blackbody.512 set value 16770770
data modify storage terf:constants blackbody.513 set value 16770770
data modify storage terf:constants blackbody.514 set value 16770770
data modify storage terf:constants blackbody.515 set value 16770771
data modify storage terf:constants blackbody.516 set value 16771027
data modify storage terf:constants blackbody.517 set value 16771027
data modify storage terf:constants blackbody.518 set value 16771028
data modify storage terf:constants blackbody.519 set value 16771028
data modify storage terf:constants blackbody.520 set value 16771028
data modify storage terf:constants blackbody.521 set value 16771285
data modify storage terf:constants blackbody.522 set value 16771285
data modify storage terf:constants blackbody.523 set value 16771285
data modify storage terf:constants blackbody.524 set value 16771286
data modify storage terf:constants blackbody.525 set value 16771286
data modify storage terf:constants blackbody.526 set value 16771542
data modify storage terf:constants blackbody.527 set value 16771542
data modify storage terf:constants blackbody.528 set value 16771543
data modify storage terf:constants blackbody.529 set value 16771543
data modify storage terf:constants blackbody.530 set value 16771543
data modify storage terf:constants blackbody.531 set value 16771544
data modify storage terf:constants blackbody.532 set value 16771800
data modify storage terf:constants blackbody.533 set value 16771800
data modify storage terf:constants blackbody.534 set value 16771801
data modify storage terf:constants blackbody.535 set value 16771801
data modify storage terf:constants blackbody.536 set value 16771801
data modify storage terf:constants blackbody.537 set value 16772058
data modify storage terf:constants blackbody.538 set value 16772058
data modify storage terf:constants blackbody.539 set value 16772058
data modify storage terf:constants blackbody.540 set value 16772059
data modify storage terf:constants blackbody.541 set value 16772059
data modify storage terf:constants blackbody.542 set value 16772315
data modify storage terf:constants blackbody.543 set value 16772316
data modify storage terf:constants blackbody.544 set value 16772316
data modify storage terf:constants blackbody.545 set value 16772316
data modify storage terf:constants blackbody.546 set value 16772317
data modify storage terf:constants blackbody.547 set value 16772317
data modify storage terf:constants blackbody.548 set value 16772573
data modify storage terf:constants blackbody.549 set value 16772573
data modify storage terf:constants blackbody.550 set value 16772574
data modify storage terf:constants blackbody.551 set value 16772574
data modify storage terf:constants blackbody.552 set value 16772574
data modify storage terf:constants blackbody.553 set value 16772831
data modify storage terf:constants blackbody.554 set value 16772831
data modify storage terf:constants blackbody.555 set value 16772831
data modify storage terf:constants blackbody.556 set value 16772832
data modify storage terf:constants blackbody.557 set value 16772832
data modify storage terf:constants blackbody.558 set value 16772832
data modify storage terf:constants blackbody.559 set value 16773088
data modify storage terf:constants blackbody.560 set value 16773089
data modify storage terf:constants blackbody.561 set value 16773089
data modify storage terf:constants blackbody.562 set value 16773089
data modify storage terf:constants blackbody.563 set value 16773090
data modify storage terf:constants blackbody.564 set value 16773090
data modify storage terf:constants blackbody.565 set value 16773346
data modify storage terf:constants blackbody.566 set value 16773347
data modify storage terf:constants blackbody.567 set value 16773347
data modify storage terf:constants blackbody.568 set value 16773347
data modify storage terf:constants blackbody.569 set value 16773347
data modify storage terf:constants blackbody.570 set value 16773604
data modify storage terf:constants blackbody.571 set value 16773604
data modify storage terf:constants blackbody.572 set value 16773604
data modify storage terf:constants blackbody.573 set value 16773605
data modify storage terf:constants blackbody.574 set value 16773605
data modify storage terf:constants blackbody.575 set value 16773605
data modify storage terf:constants blackbody.576 set value 16773862
data modify storage terf:constants blackbody.577 set value 16773862
data modify storage terf:constants blackbody.578 set value 16773862
data modify storage terf:constants blackbody.579 set value 16773862
data modify storage terf:constants blackbody.580 set value 16773863
data modify storage terf:constants blackbody.581 set value 16773863
data modify storage terf:constants blackbody.582 set value 16774119
data modify storage terf:constants blackbody.583 set value 16774120
data modify storage terf:constants blackbody.584 set value 16774120
data modify storage terf:constants blackbody.585 set value 16774120
data modify storage terf:constants blackbody.586 set value 16774120
data modify storage terf:constants blackbody.587 set value 16774121
data modify storage terf:constants blackbody.588 set value 16774377
data modify storage terf:constants blackbody.589 set value 16774377
data modify storage terf:constants blackbody.590 set value 16774378
data modify storage terf:constants blackbody.591 set value 16774378
data modify storage terf:constants blackbody.592 set value 16774378
data modify storage terf:constants blackbody.593 set value 16774378
data modify storage terf:constants blackbody.594 set value 16774635
data modify storage terf:constants blackbody.595 set value 16774635
data modify storage terf:constants blackbody.596 set value 16774635
data modify storage terf:constants blackbody.597 set value 16774636
data modify storage terf:constants blackbody.598 set value 16774636
data modify storage terf:constants blackbody.599 set value 16774636
data modify storage terf:constants blackbody.600 set value 16774892
data modify storage terf:constants blackbody.601 set value 16774893
data modify storage terf:constants blackbody.602 set value 16774893
data modify storage terf:constants blackbody.603 set value 16774893
data modify storage terf:constants blackbody.604 set value 16774893
data modify storage terf:constants blackbody.605 set value 16774894
data modify storage terf:constants blackbody.606 set value 16775150
data modify storage terf:constants blackbody.607 set value 16775150
data modify storage terf:constants blackbody.608 set value 16775151
data modify storage terf:constants blackbody.609 set value 16775151
data modify storage terf:constants blackbody.610 set value 16775151
data modify storage terf:constants blackbody.611 set value 16775151
data modify storage terf:constants blackbody.612 set value 16775408
data modify storage terf:constants blackbody.613 set value 16775408
data modify storage terf:constants blackbody.614 set value 16775408
data modify storage terf:constants blackbody.615 set value 16775408
data modify storage terf:constants blackbody.616 set value 16775409
data modify storage terf:constants blackbody.617 set value 16775409
data modify storage terf:constants blackbody.618 set value 16775665
data modify storage terf:constants blackbody.619 set value 16775666
data modify storage terf:constants blackbody.620 set value 16775666
data modify storage terf:constants blackbody.621 set value 16775666
data modify storage terf:constants blackbody.622 set value 16775666
data modify storage terf:constants blackbody.623 set value 16775667
data modify storage terf:constants blackbody.624 set value 16775923
data modify storage terf:constants blackbody.625 set value 16775923
data modify storage terf:constants blackbody.626 set value 16775923
data modify storage terf:constants blackbody.627 set value 16775924
data modify storage terf:constants blackbody.628 set value 16775924
data modify storage terf:constants blackbody.629 set value 16775924
data modify storage terf:constants blackbody.630 set value 16776180
data modify storage terf:constants blackbody.631 set value 16776181
data modify storage terf:constants blackbody.632 set value 16776181
data modify storage terf:constants blackbody.633 set value 16776181
data modify storage terf:constants blackbody.634 set value 16776181
data modify storage terf:constants blackbody.635 set value 16776182
data modify storage terf:constants blackbody.636 set value 16776182
data modify storage terf:constants blackbody.637 set value 16776438
data modify storage terf:constants blackbody.638 set value 16776438
data modify storage terf:constants blackbody.639 set value 16776439
data modify storage terf:constants blackbody.640 set value 16776439
data modify storage terf:constants blackbody.641 set value 16776439
data modify storage terf:constants blackbody.642 set value 16776440
data modify storage terf:constants blackbody.643 set value 16776696
data modify storage terf:constants blackbody.644 set value 16776696
data modify storage terf:constants blackbody.645 set value 16776696
data modify storage terf:constants blackbody.646 set value 16776697
data modify storage terf:constants blackbody.647 set value 16776697
data modify storage terf:constants blackbody.648 set value 16776697
data modify storage terf:constants blackbody.649 set value 16776697
data modify storage terf:constants blackbody.650 set value 16776954
data modify storage terf:constants blackbody.651 set value 16776954
data modify storage terf:constants blackbody.652 set value 16776954
data modify storage terf:constants blackbody.653 set value 16776954
data modify storage terf:constants blackbody.654 set value 16776955
data modify storage terf:constants blackbody.655 set value 16776955
data modify storage terf:constants blackbody.656 set value 16777211
data modify storage terf:constants blackbody.657 set value 16777211
data modify storage terf:constants blackbody.658 set value 16777212
data modify storage terf:constants blackbody.659 set value 16777212
data modify storage terf:constants blackbody.660 set value 16777215
data modify storage terf:constants blackbody.661 set value 16776191
data modify storage terf:constants blackbody.662 set value 16776191
data modify storage terf:constants blackbody.663 set value 16775935
data modify storage terf:constants blackbody.664 set value 16775935
data modify storage terf:constants blackbody.665 set value 16775935
data modify storage terf:constants blackbody.666 set value 16775679
data modify storage terf:constants blackbody.667 set value 16775679
data modify storage terf:constants blackbody.668 set value 16775679
data modify storage terf:constants blackbody.669 set value 16710143
data modify storage terf:constants blackbody.670 set value 16709887
data modify storage terf:constants blackbody.671 set value 16644351
data modify storage terf:constants blackbody.672 set value 16644351
data modify storage terf:constants blackbody.673 set value 16578559
data modify storage terf:constants blackbody.674 set value 16578559
data modify storage terf:constants blackbody.675 set value 16578559
data modify storage terf:constants blackbody.676 set value 16513023
data modify storage terf:constants blackbody.677 set value 16512767
data modify storage terf:constants blackbody.678 set value 16447231
data modify storage terf:constants blackbody.679 set value 16447231
data modify storage terf:constants blackbody.680 set value 16381695
data modify storage terf:constants blackbody.681 set value 16381695
data modify storage terf:constants blackbody.682 set value 16381439
data modify storage terf:constants blackbody.683 set value 16315903
data modify storage terf:constants blackbody.684 set value 16315903
data modify storage terf:constants blackbody.685 set value 16250367
data modify storage terf:constants blackbody.686 set value 16250111
data modify storage terf:constants blackbody.687 set value 16250111
data modify storage terf:constants blackbody.688 set value 16184575
data modify storage terf:constants blackbody.689 set value 16184575
data modify storage terf:constants blackbody.690 set value 16184575
data modify storage terf:constants blackbody.691 set value 16118783
data modify storage terf:constants blackbody.692 set value 16118783
data modify storage terf:constants blackbody.693 set value 16053247
data modify storage terf:constants blackbody.694 set value 16053247
data modify storage terf:constants blackbody.695 set value 16053247
data modify storage terf:constants blackbody.696 set value 15987455
data modify storage terf:constants blackbody.697 set value 15987455
data modify storage terf:constants blackbody.698 set value 15987455
data modify storage terf:constants blackbody.699 set value 15921919
data modify storage terf:constants blackbody.700 set value 15921919
data modify storage terf:constants blackbody.701 set value 15921663
data modify storage terf:constants blackbody.702 set value 15856127
data modify storage terf:constants blackbody.703 set value 15856127
data modify storage terf:constants blackbody.704 set value 15856127
data modify storage terf:constants blackbody.705 set value 15856127
data modify storage terf:constants blackbody.706 set value 15790591
data modify storage terf:constants blackbody.707 set value 15790335
data modify storage terf:constants blackbody.708 set value 15790335
data modify storage terf:constants blackbody.709 set value 15724799
data modify storage terf:constants blackbody.710 set value 15724799
data modify storage terf:constants blackbody.711 set value 15724799
data modify storage terf:constants blackbody.712 set value 15659263
data modify storage terf:constants blackbody.713 set value 15659007
data modify storage terf:constants blackbody.714 set value 15659007
data modify storage terf:constants blackbody.715 set value 15659007
data modify storage terf:constants blackbody.716 set value 15593471
data modify storage terf:constants blackbody.717 set value 15593471
data modify storage terf:constants blackbody.718 set value 15593471
data modify storage terf:constants blackbody.719 set value 15593215
data modify storage terf:constants blackbody.720 set value 15527679
data modify storage terf:constants blackbody.721 set value 15527679
data modify storage terf:constants blackbody.722 set value 15527679
data modify storage terf:constants blackbody.723 set value 15527679
data modify storage terf:constants blackbody.724 set value 15462143
data modify storage terf:constants blackbody.725 set value 15462143
data modify storage terf:constants blackbody.726 set value 15461887
data modify storage terf:constants blackbody.727 set value 15461887
data modify storage terf:constants blackbody.728 set value 15396351
data modify storage terf:constants blackbody.729 set value 15396351
data modify storage terf:constants blackbody.730 set value 15396351
data modify storage terf:constants blackbody.731 set value 15396351
data modify storage terf:constants blackbody.732 set value 15330815
data modify storage terf:constants blackbody.733 set value 15330559
data modify storage terf:constants blackbody.734 set value 15330559
data modify storage terf:constants blackbody.735 set value 15330559
data modify storage terf:constants blackbody.736 set value 15265023
data modify storage terf:constants blackbody.737 set value 15265023
data modify storage terf:constants blackbody.738 set value 15265023
data modify storage terf:constants blackbody.739 set value 15265023
data modify storage terf:constants blackbody.740 set value 15199487
data modify storage terf:constants blackbody.741 set value 15199231
data modify storage terf:constants blackbody.742 set value 15199231
data modify storage terf:constants blackbody.743 set value 15199231
data modify storage terf:constants blackbody.744 set value 15199231
data modify storage terf:constants blackbody.745 set value 15133695
data modify storage terf:constants blackbody.746 set value 15133695
data modify storage terf:constants blackbody.747 set value 15133695
data modify storage terf:constants blackbody.748 set value 15133695
data modify storage terf:constants blackbody.749 set value 15133439
data modify storage terf:constants blackbody.750 set value 15067903
data modify storage terf:constants blackbody.751 set value 15067903
data modify storage terf:constants blackbody.752 set value 15067903
data modify storage terf:constants blackbody.753 set value 15067903
data modify storage terf:constants blackbody.754 set value 15067903
data modify storage terf:constants blackbody.755 set value 15002367
data modify storage terf:constants blackbody.756 set value 15002367
data modify storage terf:constants blackbody.757 set value 15002367
data modify storage terf:constants blackbody.758 set value 15002111
data modify storage terf:constants blackbody.759 set value 15002111
data modify storage terf:constants blackbody.760 set value 14936575
data modify storage terf:constants blackbody.761 set value 14936575
data modify storage terf:constants blackbody.762 set value 14936575
data modify storage terf:constants blackbody.763 set value 14936575
data modify storage terf:constants blackbody.764 set value 14936575
data modify storage terf:constants blackbody.765 set value 14871039
data modify storage terf:constants blackbody.766 set value 14871039
data modify storage terf:constants blackbody.767 set value 14870783
data modify storage terf:constants blackbody.768 set value 14870783
data modify storage terf:constants blackbody.769 set value 14870783
data modify storage terf:constants blackbody.770 set value 14870783
data modify storage terf:constants blackbody.771 set value 14805247
data modify storage terf:constants blackbody.772 set value 14805247
data modify storage terf:constants blackbody.773 set value 14805247
data modify storage terf:constants blackbody.774 set value 14805247
data modify storage terf:constants blackbody.775 set value 14805247
data modify storage terf:constants blackbody.776 set value 14805247
data modify storage terf:constants blackbody.777 set value 14739455
data modify storage terf:constants blackbody.778 set value 14739455
data modify storage terf:constants blackbody.779 set value 14739455
data modify storage terf:constants blackbody.780 set value 14739455
data modify storage terf:constants blackbody.781 set value 14739455
data modify storage terf:constants blackbody.782 set value 14739455
data modify storage terf:constants blackbody.783 set value 14673919
data modify storage terf:constants blackbody.784 set value 14673919
data modify storage terf:constants blackbody.785 set value 14673919
data modify storage terf:constants blackbody.786 set value 14673919
data modify storage terf:constants blackbody.787 set value 14673663
data modify storage terf:constants blackbody.788 set value 14673663
data modify storage terf:constants blackbody.789 set value 14608127
data modify storage terf:constants blackbody.790 set value 14608127
data modify storage terf:constants blackbody.791 set value 14608127
data modify storage terf:constants blackbody.792 set value 14608127
data modify storage terf:constants blackbody.793 set value 14608127
data modify storage terf:constants blackbody.794 set value 14608127
data modify storage terf:constants blackbody.795 set value 14542591
data modify storage terf:constants blackbody.796 set value 14542591
data modify storage terf:constants blackbody.797 set value 14542591
data modify storage terf:constants blackbody.798 set value 14542335
data modify storage terf:constants blackbody.799 set value 14542335
data modify storage terf:constants blackbody.800 set value 14542335
data modify storage terf:constants blackbody.801 set value 14542335
data modify storage terf:constants blackbody.802 set value 14476799
data modify storage terf:constants blackbody.803 set value 14476799
data modify storage terf:constants blackbody.804 set value 14476799
data modify storage terf:constants blackbody.805 set value 14476799
data modify storage terf:constants blackbody.806 set value 14476799
data modify storage terf:constants blackbody.807 set value 14476799
data modify storage terf:constants blackbody.808 set value 14476799
data modify storage terf:constants blackbody.809 set value 14411263
data modify storage terf:constants blackbody.810 set value 14411007
data modify storage terf:constants blackbody.811 set value 14411007
data modify storage terf:constants blackbody.812 set value 14411007
data modify storage terf:constants blackbody.813 set value 14411007
data modify storage terf:constants blackbody.814 set value 14411007
data modify storage terf:constants blackbody.815 set value 14411007
data modify storage terf:constants blackbody.816 set value 14345471
data modify storage terf:constants blackbody.817 set value 14345471
data modify storage terf:constants blackbody.818 set value 14345471
data modify storage terf:constants blackbody.819 set value 14345471
data modify storage terf:constants blackbody.820 set value 14345471
data modify storage terf:constants blackbody.821 set value 14345471
data modify storage terf:constants blackbody.822 set value 14345215
data modify storage terf:constants blackbody.823 set value 14345215
data modify storage terf:constants blackbody.824 set value 14279679
data modify storage terf:constants blackbody.825 set value 14279679
data modify storage terf:constants blackbody.826 set value 14279679
data modify storage terf:constants blackbody.827 set value 14279679
data modify storage terf:constants blackbody.828 set value 14279679
data modify storage terf:constants blackbody.829 set value 14279679
data modify storage terf:constants blackbody.830 set value 14279679
data modify storage terf:constants blackbody.831 set value 14279679
data modify storage terf:constants blackbody.832 set value 14214143
data modify storage terf:constants blackbody.833 set value 14214143
data modify storage terf:constants blackbody.834 set value 14214143
data modify storage terf:constants blackbody.835 set value 14214143
data modify storage terf:constants blackbody.836 set value 14213887
data modify storage terf:constants blackbody.837 set value 14213887
data modify storage terf:constants blackbody.838 set value 14213887
data modify storage terf:constants blackbody.839 set value 14213887
data modify storage terf:constants blackbody.840 set value 14148351
data modify storage terf:constants blackbody.841 set value 14148351
data modify storage terf:constants blackbody.842 set value 14148351
data modify storage terf:constants blackbody.843 set value 14148351
data modify storage terf:constants blackbody.844 set value 14148351
data modify storage terf:constants blackbody.845 set value 14148351
data modify storage terf:constants blackbody.846 set value 14148351
data modify storage terf:constants blackbody.847 set value 14148351
data modify storage terf:constants blackbody.848 set value 14082815
data modify storage terf:constants blackbody.849 set value 14082815
data modify storage terf:constants blackbody.850 set value 14082559
data modify storage terf:constants blackbody.851 set value 14082559
data modify storage terf:constants blackbody.852 set value 14082559
data modify storage terf:constants blackbody.853 set value 14082559
data modify storage terf:constants blackbody.854 set value 14082559
data modify storage terf:constants blackbody.855 set value 14082559
data modify storage terf:constants blackbody.856 set value 14082559
data modify storage terf:constants blackbody.857 set value 14017023
data modify storage terf:constants blackbody.858 set value 14017023
data modify storage terf:constants blackbody.859 set value 14017023
data modify storage terf:constants blackbody.860 set value 14017023
data modify storage terf:constants blackbody.861 set value 14017023
data modify storage terf:constants blackbody.862 set value 14017023
data modify storage terf:constants blackbody.863 set value 14017023
data modify storage terf:constants blackbody.864 set value 14017023
data modify storage terf:constants blackbody.865 set value 14016767
data modify storage terf:constants blackbody.866 set value 13951231
data modify storage terf:constants blackbody.867 set value 13951231
data modify storage terf:constants blackbody.868 set value 13951231
data modify storage terf:constants blackbody.869 set value 13951231
data modify storage terf:constants blackbody.870 set value 13951231
data modify storage terf:constants blackbody.871 set value 13951231
data modify storage terf:constants blackbody.872 set value 13951231
data modify storage terf:constants blackbody.873 set value 13951231
data modify storage terf:constants blackbody.874 set value 13951231
data modify storage terf:constants blackbody.875 set value 13951231
data modify storage terf:constants blackbody.876 set value 13885695
data modify storage terf:constants blackbody.877 set value 13885695
data modify storage terf:constants blackbody.878 set value 13885695
data modify storage terf:constants blackbody.879 set value 13885695
data modify storage terf:constants blackbody.880 set value 13885695
data modify storage terf:constants blackbody.881 set value 13885439
data modify storage terf:constants blackbody.882 set value 13885439
data modify storage terf:constants blackbody.883 set value 13885439
data modify storage terf:constants blackbody.884 set value 13885439
data modify storage terf:constants blackbody.885 set value 13885439
data modify storage terf:constants blackbody.886 set value 13819903
data modify storage terf:constants blackbody.887 set value 13819903
data modify storage terf:constants blackbody.888 set value 13819903
data modify storage terf:constants blackbody.889 set value 13819903
data modify storage terf:constants blackbody.890 set value 13819903
data modify storage terf:constants blackbody.891 set value 13819903
data modify storage terf:constants blackbody.892 set value 13819903
data modify storage terf:constants blackbody.893 set value 13819903
data modify storage terf:constants blackbody.894 set value 13819903
data modify storage terf:constants blackbody.895 set value 13819903
data modify storage terf:constants blackbody.896 set value 13754367
data modify storage terf:constants blackbody.897 set value 13754367
data modify storage terf:constants blackbody.898 set value 13754111
data modify storage terf:constants blackbody.899 set value 13754111
data modify storage terf:constants blackbody.900 set value 13754111
data modify storage terf:constants blackbody.901 set value 13754111
data modify storage terf:constants blackbody.902 set value 13754111
data modify storage terf:constants blackbody.903 set value 13754111
data modify storage terf:constants blackbody.904 set value 13754111
data modify storage terf:constants blackbody.905 set value 13754111
data modify storage terf:constants blackbody.906 set value 13754111
data modify storage terf:constants blackbody.907 set value 13688575
data modify storage terf:constants blackbody.908 set value 13688575
data modify storage terf:constants blackbody.909 set value 13688575
data modify storage terf:constants blackbody.910 set value 13688575
data modify storage terf:constants blackbody.911 set value 13688575
data modify storage terf:constants blackbody.912 set value 13688575
data modify storage terf:constants blackbody.913 set value 13688575
data modify storage terf:constants blackbody.914 set value 13688575
data modify storage terf:constants blackbody.915 set value 13688575
data modify storage terf:constants blackbody.916 set value 13688319
data modify storage terf:constants blackbody.917 set value 13688319
data modify storage terf:constants blackbody.918 set value 13622783
data modify storage terf:constants blackbody.919 set value 13622783
data modify storage terf:constants blackbody.920 set value 13622783
data modify storage terf:constants blackbody.921 set value 13622783
data modify storage terf:constants blackbody.922 set value 13622783
data modify storage terf:constants blackbody.923 set value 13622783
data modify storage terf:constants blackbody.924 set value 13622783
data modify storage terf:constants blackbody.925 set value 13622783
data modify storage terf:constants blackbody.926 set value 13622783
data modify storage terf:constants blackbody.927 set value 13622783
data modify storage terf:constants blackbody.928 set value 13622783
data modify storage terf:constants blackbody.929 set value 13622783
data modify storage terf:constants blackbody.930 set value 13557247
data modify storage terf:constants blackbody.931 set value 13557247
data modify storage terf:constants blackbody.932 set value 13557247
data modify storage terf:constants blackbody.933 set value 13557247
data modify storage terf:constants blackbody.934 set value 13557247
data modify storage terf:constants blackbody.935 set value 13557247
data modify storage terf:constants blackbody.936 set value 13556991
data modify storage terf:constants blackbody.937 set value 13556991
data modify storage terf:constants blackbody.938 set value 13556991
data modify storage terf:constants blackbody.939 set value 13556991
data modify storage terf:constants blackbody.940 set value 13556991
data modify storage terf:constants blackbody.941 set value 13556991
data modify storage terf:constants blackbody.942 set value 13491455
data modify storage terf:constants blackbody.943 set value 13491455
data modify storage terf:constants blackbody.944 set value 13491455
data modify storage terf:constants blackbody.945 set value 13491455
data modify storage terf:constants blackbody.946 set value 13491455
data modify storage terf:constants blackbody.947 set value 13491455
data modify storage terf:constants blackbody.948 set value 13491455
data modify storage terf:constants blackbody.949 set value 13491455
data modify storage terf:constants blackbody.950 set value 13491455
data modify storage terf:constants blackbody.951 set value 13491455
data modify storage terf:constants blackbody.952 set value 13491455
data modify storage terf:constants blackbody.953 set value 13491455
data modify storage terf:constants blackbody.954 set value 13491455
data modify storage terf:constants blackbody.955 set value 13425919
data modify storage terf:constants blackbody.956 set value 13425663
data modify storage terf:constants blackbody.957 set value 13425663
data modify storage terf:constants blackbody.958 set value 13425663
data modify storage terf:constants blackbody.959 set value 13425663
data modify storage terf:constants blackbody.960 set value 13425663
data modify storage terf:constants blackbody.961 set value 13425663
data modify storage terf:constants blackbody.962 set value 13425663
data modify storage terf:constants blackbody.963 set value 13425663
data modify storage terf:constants blackbody.964 set value 13425663
data modify storage terf:constants blackbody.965 set value 13425663
data modify storage terf:constants blackbody.966 set value 13425663
data modify storage terf:constants blackbody.967 set value 13425663
data modify storage terf:constants blackbody.968 set value 13360127
data modify storage terf:constants blackbody.969 set value 13360127
data modify storage terf:constants blackbody.970 set value 13360127
data modify storage terf:constants blackbody.971 set value 13360127
data modify storage terf:constants blackbody.972 set value 13360127
data modify storage terf:constants blackbody.973 set value 13360127
data modify storage terf:constants blackbody.974 set value 13360127
data modify storage terf:constants blackbody.975 set value 13360127
data modify storage terf:constants blackbody.976 set value 13360127
data modify storage terf:constants blackbody.977 set value 13360127
data modify storage terf:constants blackbody.978 set value 13360127
data modify storage terf:constants blackbody.979 set value 13359871
data modify storage terf:constants blackbody.980 set value 13359871
data modify storage terf:constants blackbody.981 set value 13359871
data modify storage terf:constants blackbody.982 set value 13294335
data modify storage terf:constants blackbody.983 set value 13294335
data modify storage terf:constants blackbody.984 set value 13294335
data modify storage terf:constants blackbody.985 set value 13294335
data modify storage terf:constants blackbody.986 set value 13294335
data modify storage terf:constants blackbody.987 set value 13294335
data modify storage terf:constants blackbody.988 set value 13294335
data modify storage terf:constants blackbody.989 set value 13294335
data modify storage terf:constants blackbody.990 set value 13294335
data modify storage terf:constants blackbody.991 set value 13294335
data modify storage terf:constants blackbody.992 set value 13294335
data modify storage terf:constants blackbody.993 set value 13294335
data modify storage terf:constants blackbody.994 set value 13294335
data modify storage terf:constants blackbody.995 set value 13294335
data modify storage terf:constants blackbody.996 set value 13228799
data modify storage terf:constants blackbody.997 set value 13228799
data modify storage terf:constants blackbody.998 set value 13228799
data modify storage terf:constants blackbody.999 set value 13228799
data modify storage terf:constants blackbody.1000 set value 13228799
data modify storage terf:constants blackbody.1001 set value 13228799
data modify storage terf:constants blackbody.1002 set value 13228543
data modify storage terf:constants blackbody.1003 set value 13228543
data modify storage terf:constants blackbody.1004 set value 13228543
data modify storage terf:constants blackbody.1005 set value 13228543
data modify storage terf:constants blackbody.1006 set value 13228543
data modify storage terf:constants blackbody.1007 set value 13228543
data modify storage terf:constants blackbody.1008 set value 13228543
data modify storage terf:constants blackbody.1009 set value 13228543
data modify storage terf:constants blackbody.1010 set value 13228543
data modify storage terf:constants blackbody.1011 set value 13163007
data modify storage terf:constants blackbody.1012 set value 13163007
data modify storage terf:constants blackbody.1013 set value 13163007
data modify storage terf:constants blackbody.1014 set value 13163007
data modify storage terf:constants blackbody.1015 set value 13163007
data modify storage terf:constants blackbody.1016 set value 13163007
data modify storage terf:constants blackbody.1017 set value 13163007
data modify storage terf:constants blackbody.1018 set value 13163007
data modify storage terf:constants blackbody.1019 set value 13163007
data modify storage terf:constants blackbody.1020 set value 13163007
data modify storage terf:constants blackbody.1021 set value 13163007
data modify storage terf:constants blackbody.1022 set value 13163007
data modify storage terf:constants blackbody.1023 set value 13163007
data modify storage terf:constants blackbody.1024 set value 13163007
data modify storage terf:constants blackbody.1025 set value 13163007
data modify storage terf:constants blackbody.1026 set value 13163007
data modify storage terf:constants blackbody.1027 set value 13097215
data modify storage terf:constants blackbody.1028 set value 13097215
data modify storage terf:constants blackbody.1029 set value 13097215
data modify storage terf:constants blackbody.1030 set value 13097215
data modify storage terf:constants blackbody.1031 set value 13097215
data modify storage terf:constants blackbody.1032 set value 13097215
data modify storage terf:constants blackbody.1033 set value 13097215
data modify storage terf:constants blackbody.1034 set value 13097215
data modify storage terf:constants blackbody.1035 set value 13097215
data modify storage terf:constants blackbody.1036 set value 13097215
data modify storage terf:constants blackbody.1037 set value 13097215
data modify storage terf:constants blackbody.1038 set value 13097215
data modify storage terf:constants blackbody.1039 set value 13097215
data modify storage terf:constants blackbody.1040 set value 13097215
data modify storage terf:constants blackbody.1041 set value 13097215
data modify storage terf:constants blackbody.1042 set value 13097215
data modify storage terf:constants blackbody.1043 set value 13031679
data modify storage terf:constants blackbody.1044 set value 13031679
data modify storage terf:constants blackbody.1045 set value 13031679
data modify storage terf:constants blackbody.1046 set value 13031679
data modify storage terf:constants blackbody.1047 set value 13031679
data modify storage terf:constants blackbody.1048 set value 13031679
data modify storage terf:constants blackbody.1049 set value 13031679
data modify storage terf:constants blackbody.1050 set value 13031679
data modify storage terf:constants blackbody.1051 set value 13031679
data modify storage terf:constants blackbody.1052 set value 13031679
data modify storage terf:constants blackbody.1053 set value 13031679
data modify storage terf:constants blackbody.1054 set value 13031423
data modify storage terf:constants blackbody.1055 set value 13031423
data modify storage terf:constants blackbody.1056 set value 13031423
data modify storage terf:constants blackbody.1057 set value 13031423
data modify storage terf:constants blackbody.1058 set value 13031423
data modify storage terf:constants blackbody.1059 set value 13031423
data modify storage terf:constants blackbody.1060 set value 12965887
data modify storage terf:constants blackbody.1061 set value 12965887
data modify storage terf:constants blackbody.1062 set value 12965887
data modify storage terf:constants blackbody.1063 set value 12965887
data modify storage terf:constants blackbody.1064 set value 12965887
data modify storage terf:constants blackbody.1065 set value 12965887
data modify storage terf:constants blackbody.1066 set value 12965887
data modify storage terf:constants blackbody.1067 set value 12965887
data modify storage terf:constants blackbody.1068 set value 12965887
data modify storage terf:constants blackbody.1069 set value 12965887
data modify storage terf:constants blackbody.1070 set value 12965887
data modify storage terf:constants blackbody.1071 set value 12965887
data modify storage terf:constants blackbody.1072 set value 12965887
data modify storage terf:constants blackbody.1073 set value 12965887
data modify storage terf:constants blackbody.1074 set value 12965887
data modify storage terf:constants blackbody.1075 set value 12965887
data modify storage terf:constants blackbody.1076 set value 12965887
data modify storage terf:constants blackbody.1077 set value 12965887
data modify storage terf:constants blackbody.1078 set value 12900351
data modify storage terf:constants blackbody.1079 set value 12900351
data modify storage terf:constants blackbody.1080 set value 12900351
data modify storage terf:constants blackbody.1081 set value 12900351
data modify storage terf:constants blackbody.1082 set value 12900351
data modify storage terf:constants blackbody.1083 set value 12900095
data modify storage terf:constants blackbody.1084 set value 12900095
data modify storage terf:constants blackbody.1085 set value 12900095
data modify storage terf:constants blackbody.1086 set value 12900095
data modify storage terf:constants blackbody.1087 set value 12900095
data modify storage terf:constants blackbody.1088 set value 12900095
data modify storage terf:constants blackbody.1089 set value 12900095
data modify storage terf:constants blackbody.1090 set value 12900095
data modify storage terf:constants blackbody.1091 set value 12900095
data modify storage terf:constants blackbody.1092 set value 12900095
data modify storage terf:constants blackbody.1093 set value 12900095
data modify storage terf:constants blackbody.1094 set value 12900095
data modify storage terf:constants blackbody.1095 set value 12900095
data modify storage terf:constants blackbody.1096 set value 12900095
data modify storage terf:constants blackbody.1097 set value 12834559
data modify storage terf:constants blackbody.1098 set value 12834559
data modify storage terf:constants blackbody.1099 set value 12834559
data modify storage terf:constants blackbody.1100 set value 12834559
data modify storage terf:constants blackbody.1101 set value 12834559
data modify storage terf:constants blackbody.1102 set value 12834559
data modify storage terf:constants blackbody.1103 set value 12834559
data modify storage terf:constants blackbody.1104 set value 12834559
data modify storage terf:constants blackbody.1105 set value 12834559
data modify storage terf:constants blackbody.1106 set value 12834559
data modify storage terf:constants blackbody.1107 set value 12834559
data modify storage terf:constants blackbody.1108 set value 12834559
data modify storage terf:constants blackbody.1109 set value 12834559
data modify storage terf:constants blackbody.1110 set value 12834559
data modify storage terf:constants blackbody.1111 set value 12834559
data modify storage terf:constants blackbody.1112 set value 12834559
data modify storage terf:constants blackbody.1113 set value 12834559
data modify storage terf:constants blackbody.1114 set value 12834303
data modify storage terf:constants blackbody.1115 set value 12834303
data modify storage terf:constants blackbody.1116 set value 12768767
data modify storage terf:constants blackbody.1117 set value 12768767
data modify storage terf:constants blackbody.1118 set value 12768767
data modify storage terf:constants blackbody.1119 set value 12768767
data modify storage terf:constants blackbody.1120 set value 12768767
data modify storage terf:constants blackbody.1121 set value 12768767
data modify storage terf:constants blackbody.1122 set value 12768767
data modify storage terf:constants blackbody.1123 set value 12768767
data modify storage terf:constants blackbody.1124 set value 12768767
data modify storage terf:constants blackbody.1125 set value 12768767
data modify storage terf:constants blackbody.1126 set value 12768767
data modify storage terf:constants blackbody.1127 set value 12768767
data modify storage terf:constants blackbody.1128 set value 12768767
data modify storage terf:constants blackbody.1129 set value 12768767
data modify storage terf:constants blackbody.1130 set value 12768767
data modify storage terf:constants blackbody.1131 set value 12768767
data modify storage terf:constants blackbody.1132 set value 12768767
data modify storage terf:constants blackbody.1133 set value 12768767
data modify storage terf:constants blackbody.1134 set value 12768767
data modify storage terf:constants blackbody.1135 set value 12768767
data modify storage terf:constants blackbody.1136 set value 12703231
data modify storage terf:constants blackbody.1137 set value 12703231
data modify storage terf:constants blackbody.1138 set value 12703231
data modify storage terf:constants blackbody.1139 set value 12703231
data modify storage terf:constants blackbody.1140 set value 12703231
data modify storage terf:constants blackbody.1141 set value 12703231
data modify storage terf:constants blackbody.1142 set value 12703231
data modify storage terf:constants blackbody.1143 set value 12703231
data modify storage terf:constants blackbody.1144 set value 12703231
data modify storage terf:constants blackbody.1145 set value 12703231
data modify storage terf:constants blackbody.1146 set value 12703231
data modify storage terf:constants blackbody.1147 set value 12702975
data modify storage terf:constants blackbody.1148 set value 12702975
data modify storage terf:constants blackbody.1149 set value 12702975
data modify storage terf:constants blackbody.1150 set value 12702975
data modify storage terf:constants blackbody.1151 set value 12702975
data modify storage terf:constants blackbody.1152 set value 12702975
data modify storage terf:constants blackbody.1153 set value 12702975
data modify storage terf:constants blackbody.1154 set value 12702975
data modify storage terf:constants blackbody.1155 set value 12702975
data modify storage terf:constants blackbody.1156 set value 12702975
data modify storage terf:constants blackbody.1157 set value 12702975
data modify storage terf:constants blackbody.1158 set value 12637439
data modify storage terf:constants blackbody.1159 set value 12637439
data modify storage terf:constants blackbody.1160 set value 12637439
data modify storage terf:constants blackbody.1161 set value 12637439
data modify storage terf:constants blackbody.1162 set value 12637439
data modify storage terf:constants blackbody.1163 set value 12637439
data modify storage terf:constants blackbody.1164 set value 12637439
data modify storage terf:constants blackbody.1165 set value 12637439
data modify storage terf:constants blackbody.1166 set value 12637439
data modify storage terf:constants blackbody.1167 set value 12637439
data modify storage terf:constants blackbody.1168 set value 12637439
data modify storage terf:constants blackbody.1169 set value 12637439
data modify storage terf:constants blackbody.1170 set value 12637439
data modify storage terf:constants blackbody.1171 set value 12637439
data modify storage terf:constants blackbody.1172 set value 12637439
data modify storage terf:constants blackbody.1173 set value 12637439
data modify storage terf:constants blackbody.1174 set value 12637439
data modify storage terf:constants blackbody.1175 set value 12637439
data modify storage terf:constants blackbody.1176 set value 12637439
data modify storage terf:constants blackbody.1177 set value 12637439
data modify storage terf:constants blackbody.1178 set value 12637439
data modify storage terf:constants blackbody.1179 set value 12637439
data modify storage terf:constants blackbody.1180 set value 12571903
data modify storage terf:constants blackbody.1181 set value 12571903
data modify storage terf:constants blackbody.1182 set value 12571647
data modify storage terf:constants blackbody.1183 set value 12571647
data modify storage terf:constants blackbody.1184 set value 12571647
data modify storage terf:constants blackbody.1185 set value 12571647
data modify storage terf:constants blackbody.1186 set value 12571647
data modify storage terf:constants blackbody.1187 set value 12571647
data modify storage terf:constants blackbody.1188 set value 12571647
data modify storage terf:constants blackbody.1189 set value 12571647
data modify storage terf:constants blackbody.1190 set value 12571647
data modify storage terf:constants blackbody.1191 set value 12571647
data modify storage terf:constants blackbody.1192 set value 12571647
data modify storage terf:constants blackbody.1193 set value 12571647
data modify storage terf:constants blackbody.1194 set value 12571647
data modify storage terf:constants blackbody.1195 set value 12571647
data modify storage terf:constants blackbody.1196 set value 12571647
data modify storage terf:constants blackbody.1197 set value 12571647
data modify storage terf:constants blackbody.1198 set value 12571647
data modify storage terf:constants blackbody.1199 set value 12571647
data modify storage terf:constants blackbody.1200 set value 12571647
data modify storage terf:constants blackbody.1201 set value 12571647
data modify storage terf:constants blackbody.1202 set value 12571647
data modify storage terf:constants blackbody.1203 set value 12506111
data modify storage terf:constants blackbody.1204 set value 12506111
data modify storage terf:constants blackbody.1205 set value 12506111
data modify storage terf:constants blackbody.1206 set value 12506111
data modify storage terf:constants blackbody.1207 set value 12506111
data modify storage terf:constants blackbody.1208 set value 12506111
data modify storage terf:constants blackbody.1209 set value 12506111
data modify storage terf:constants blackbody.1210 set value 12506111
data modify storage terf:constants blackbody.1211 set value 12506111
data modify storage terf:constants blackbody.1212 set value 12506111
data modify storage terf:constants blackbody.1213 set value 12506111
data modify storage terf:constants blackbody.1214 set value 12506111
data modify storage terf:constants blackbody.1215 set value 12506111
data modify storage terf:constants blackbody.1216 set value 12506111
data modify storage terf:constants blackbody.1217 set value 12506111
data modify storage terf:constants blackbody.1218 set value 12506111
data modify storage terf:constants blackbody.1219 set value 12505855
data modify storage terf:constants blackbody.1220 set value 12505855
data modify storage terf:constants blackbody.1221 set value 12505855
data modify storage terf:constants blackbody.1222 set value 12505855
data modify storage terf:constants blackbody.1223 set value 12505855
data modify storage terf:constants blackbody.1224 set value 12505855
data modify storage terf:constants blackbody.1225 set value 12505855
data modify storage terf:constants blackbody.1226 set value 12505855
data modify storage terf:constants blackbody.1227 set value 12440319
data modify storage terf:constants blackbody.1228 set value 12440319
data modify storage terf:constants blackbody.1229 set value 12440319
data modify storage terf:constants blackbody.1230 set value 12440319
data modify storage terf:constants blackbody.1231 set value 12440319
data modify storage terf:constants blackbody.1232 set value 12440319
data modify storage terf:constants blackbody.1233 set value 12440319
data modify storage terf:constants blackbody.1234 set value 12440319
data modify storage terf:constants blackbody.1235 set value 12440319
data modify storage terf:constants blackbody.1236 set value 12440319
data modify storage terf:constants blackbody.1237 set value 12440319
data modify storage terf:constants blackbody.1238 set value 12440319
data modify storage terf:constants blackbody.1239 set value 12440319
data modify storage terf:constants blackbody.1240 set value 12440319
data modify storage terf:constants blackbody.1241 set value 12440319
data modify storage terf:constants blackbody.1242 set value 12440319
data modify storage terf:constants blackbody.1243 set value 12440319
data modify storage terf:constants blackbody.1244 set value 12440319
data modify storage terf:constants blackbody.1245 set value 12440319
data modify storage terf:constants blackbody.1246 set value 12440319
data modify storage terf:constants blackbody.1247 set value 12440319
data modify storage terf:constants blackbody.1248 set value 12440319
data modify storage terf:constants blackbody.1249 set value 12440319
data modify storage terf:constants blackbody.1250 set value 12440319
data modify storage terf:constants blackbody.1251 set value 12440319
data modify storage terf:constants blackbody.1252 set value 12374783
data modify storage terf:constants blackbody.1253 set value 12374783
data modify storage terf:constants blackbody.1254 set value 12374783
data modify storage terf:constants blackbody.1255 set value 12374783
data modify storage terf:constants blackbody.1256 set value 12374783
data modify storage terf:constants blackbody.1257 set value 12374783
data modify storage terf:constants blackbody.1258 set value 12374783
data modify storage terf:constants blackbody.1259 set value 12374783
data modify storage terf:constants blackbody.1260 set value 12374527
data modify storage terf:constants blackbody.1261 set value 12374527
data modify storage terf:constants blackbody.1262 set value 12374527
data modify storage terf:constants blackbody.1263 set value 12374527
data modify storage terf:constants blackbody.1264 set value 12374527
data modify storage terf:constants blackbody.1265 set value 12374527
data modify storage terf:constants blackbody.1266 set value 12374527
data modify storage terf:constants blackbody.1267 set value 12374527
data modify storage terf:constants blackbody.1268 set value 12374527
data modify storage terf:constants blackbody.1269 set value 12374527
data modify storage terf:constants blackbody.1270 set value 12374527
data modify storage terf:constants blackbody.1271 set value 12374527
data modify storage terf:constants blackbody.1272 set value 12374527
data modify storage terf:constants blackbody.1273 set value 12374527
data modify storage terf:constants blackbody.1274 set value 12374527
data modify storage terf:constants blackbody.1275 set value 12374527
data modify storage terf:constants blackbody.1276 set value 12374527
data modify storage terf:constants blackbody.1277 set value 12374527
data modify storage terf:constants blackbody.1278 set value 12374527
data modify storage terf:constants blackbody.1279 set value 12308991
data modify storage terf:constants blackbody.1280 set value 12308991
data modify storage terf:constants blackbody.1281 set value 12308991
data modify storage terf:constants blackbody.1282 set value 12308991
data modify storage terf:constants blackbody.1283 set value 12308991
data modify storage terf:constants blackbody.1284 set value 12308991
data modify storage terf:constants blackbody.1285 set value 12308991
data modify storage terf:constants blackbody.1286 set value 12308991
data modify storage terf:constants blackbody.1287 set value 12308991
data modify storage terf:constants blackbody.1288 set value 12308991
data modify storage terf:constants blackbody.1289 set value 12308991
data modify storage terf:constants blackbody.1290 set value 12308991
data modify storage terf:constants blackbody.1291 set value 12308991
data modify storage terf:constants blackbody.1292 set value 12308991
data modify storage terf:constants blackbody.1293 set value 12308991
data modify storage terf:constants blackbody.1294 set value 12308991
data modify storage terf:constants blackbody.1295 set value 12308991
data modify storage terf:constants blackbody.1296 set value 12308991
data modify storage terf:constants blackbody.1297 set value 12308991
data modify storage terf:constants blackbody.1298 set value 12308991
data modify storage terf:constants blackbody.1299 set value 12308991
data modify storage terf:constants blackbody.1300 set value 12308991
data modify storage terf:constants blackbody.1301 set value 12308991
data modify storage terf:constants blackbody.1302 set value 12308991
data modify storage terf:constants blackbody.1303 set value 12308735
data modify storage terf:constants blackbody.1304 set value 12308735
data modify storage terf:constants blackbody.1305 set value 12308735
data modify storage terf:constants blackbody.1306 set value 12308735
data modify storage terf:constants blackbody.1307 set value 12243199
data modify storage terf:constants blackbody.1308 set value 12243199
data modify storage terf:constants blackbody.1309 set value 12243199
data modify storage terf:constants blackbody.1310 set value 12243199
data modify storage terf:constants blackbody.1311 set value 12243199
data modify storage terf:constants blackbody.1312 set value 12243199
data modify storage terf:constants blackbody.1313 set value 12243199
data modify storage terf:constants blackbody.1314 set value 12243199
data modify storage terf:constants blackbody.1315 set value 12243199
data modify storage terf:constants blackbody.1316 set value 12243199
data modify storage terf:constants blackbody.1317 set value 12243199
data modify storage terf:constants blackbody.1318 set value 12243199
data modify storage terf:constants blackbody.1319 set value 12243199
data modify storage terf:constants blackbody.1320 set value 12243199
data modify storage terf:constants blackbody.1321 set value 12243199
data modify storage terf:constants blackbody.1322 set value 12243199
data modify storage terf:constants blackbody.1323 set value 12243199
data modify storage terf:constants blackbody.1324 set value 12243199
data modify storage terf:constants blackbody.1325 set value 12243199
data modify storage terf:constants blackbody.1326 set value 12243199
data modify storage terf:constants blackbody.1327 set value 12243199
data modify storage terf:constants blackbody.1328 set value 12243199
data modify storage terf:constants blackbody.1329 set value 12243199
data modify storage terf:constants blackbody.1330 set value 12243199
data modify storage terf:constants blackbody.1331 set value 12243199
data modify storage terf:constants blackbody.1332 set value 12243199
data modify storage terf:constants blackbody.1333 set value 12243199
data modify storage terf:constants blackbody.1334 set value 12243199
data modify storage terf:constants blackbody.1335 set value 12243199
data modify storage terf:constants blackbody.1336 set value 12177663
data modify storage terf:constants blackbody.1337 set value 12177663
data modify storage terf:constants blackbody.1338 set value 12177663
data modify storage terf:constants blackbody.1339 set value 12177663
data modify storage terf:constants blackbody.1340 set value 12177663
data modify storage terf:constants blackbody.1341 set value 12177663
data modify storage terf:constants blackbody.1342 set value 12177663
data modify storage terf:constants blackbody.1343 set value 12177663
data modify storage terf:constants blackbody.1344 set value 12177663
data modify storage terf:constants blackbody.1345 set value 12177663
data modify storage terf:constants blackbody.1346 set value 12177663
data modify storage terf:constants blackbody.1347 set value 12177663
data modify storage terf:constants blackbody.1348 set value 12177663
data modify storage terf:constants blackbody.1349 set value 12177407
data modify storage terf:constants blackbody.1350 set value 12177407
data modify storage terf:constants blackbody.1351 set value 12177407
data modify storage terf:constants blackbody.1352 set value 12177407
data modify storage terf:constants blackbody.1353 set value 12177407
data modify storage terf:constants blackbody.1354 set value 12177407
data modify storage terf:constants blackbody.1355 set value 12177407
data modify storage terf:constants blackbody.1356 set value 12177407
data modify storage terf:constants blackbody.1357 set value 12177407
data modify storage terf:constants blackbody.1358 set value 12177407
data modify storage terf:constants blackbody.1359 set value 12177407
data modify storage terf:constants blackbody.1360 set value 12177407
data modify storage terf:constants blackbody.1361 set value 12177407
data modify storage terf:constants blackbody.1362 set value 12177407
data modify storage terf:constants blackbody.1363 set value 12177407
data modify storage terf:constants blackbody.1364 set value 12177407
data modify storage terf:constants blackbody.1365 set value 12177407
data modify storage terf:constants blackbody.1366 set value 12111871
data modify storage terf:constants blackbody.1367 set value 12111871
data modify storage terf:constants blackbody.1368 set value 12111871
data modify storage terf:constants blackbody.1369 set value 12111871
data modify storage terf:constants blackbody.1370 set value 12111871
data modify storage terf:constants blackbody.1371 set value 12111871
data modify storage terf:constants blackbody.1372 set value 12111871
data modify storage terf:constants blackbody.1373 set value 12111871
data modify storage terf:constants blackbody.1374 set value 12111871
data modify storage terf:constants blackbody.1375 set value 12111871
data modify storage terf:constants blackbody.1376 set value 12111871
data modify storage terf:constants blackbody.1377 set value 12111871
data modify storage terf:constants blackbody.1378 set value 12111871
data modify storage terf:constants blackbody.1379 set value 12111871
data modify storage terf:constants blackbody.1380 set value 12111871
data modify storage terf:constants blackbody.1381 set value 12111871
data modify storage terf:constants blackbody.1382 set value 12111871
data modify storage terf:constants blackbody.1383 set value 12111871
data modify storage terf:constants blackbody.1384 set value 12111871
data modify storage terf:constants blackbody.1385 set value 12111871
data modify storage terf:constants blackbody.1386 set value 12111871
data modify storage terf:constants blackbody.1387 set value 12111871
data modify storage terf:constants blackbody.1388 set value 12111871
data modify storage terf:constants blackbody.1389 set value 12111871
data modify storage terf:constants blackbody.1390 set value 12111871
data modify storage terf:constants blackbody.1391 set value 12111871
data modify storage terf:constants blackbody.1392 set value 12111871
data modify storage terf:constants blackbody.1393 set value 12111871
data modify storage terf:constants blackbody.1394 set value 12111871
data modify storage terf:constants blackbody.1395 set value 12111871
data modify storage terf:constants blackbody.1396 set value 12111871
data modify storage terf:constants blackbody.1397 set value 12111871
data modify storage terf:constants blackbody.1398 set value 12046079
data modify storage terf:constants blackbody.1399 set value 12046079
data modify storage terf:constants blackbody.1400 set value 12046079
data modify storage terf:constants blackbody.1401 set value 12046079
data modify storage terf:constants blackbody.1402 set value 12046079
data modify storage terf:constants blackbody.1403 set value 12046079
data modify storage terf:constants blackbody.1404 set value 12046079
data modify storage terf:constants blackbody.1405 set value 12046079
data modify storage terf:constants blackbody.1406 set value 12046079
data modify storage terf:constants blackbody.1407 set value 12046079
data modify storage terf:constants blackbody.1408 set value 12046079
data modify storage terf:constants blackbody.1409 set value 12046079
data modify storage terf:constants blackbody.1410 set value 12046079
data modify storage terf:constants blackbody.1411 set value 12046079
data modify storage terf:constants blackbody.1412 set value 12046079
data modify storage terf:constants blackbody.1413 set value 12046079
data modify storage terf:constants blackbody.1414 set value 12046079
data modify storage terf:constants blackbody.1415 set value 12046079
data modify storage terf:constants blackbody.1416 set value 12046079
data modify storage terf:constants blackbody.1417 set value 12046079
data modify storage terf:constants blackbody.1418 set value 12046079
data modify storage terf:constants blackbody.1419 set value 12046079
data modify storage terf:constants blackbody.1420 set value 12046079
data modify storage terf:constants blackbody.1421 set value 12046079
data modify storage terf:constants blackbody.1422 set value 12046079
data modify storage terf:constants blackbody.1423 set value 12046079
data modify storage terf:constants blackbody.1424 set value 12046079
data modify storage terf:constants blackbody.1425 set value 12046079
data modify storage terf:constants blackbody.1426 set value 12046079
data modify storage terf:constants blackbody.1427 set value 12046079
data modify storage terf:constants blackbody.1428 set value 12046079
data modify storage terf:constants blackbody.1429 set value 12046079
data modify storage terf:constants blackbody.1430 set value 12046079
data modify storage terf:constants blackbody.1431 set value 11980543
data modify storage terf:constants blackbody.1432 set value 11980543
data modify storage terf:constants blackbody.1433 set value 11980543
data modify storage terf:constants blackbody.1434 set value 11980543
data modify storage terf:constants blackbody.1435 set value 11980543
data modify storage terf:constants blackbody.1436 set value 11980543
data modify storage terf:constants blackbody.1437 set value 11980543
data modify storage terf:constants blackbody.1438 set value 11980543
data modify storage terf:constants blackbody.1439 set value 11980543
data modify storage terf:constants blackbody.1440 set value 11980543
data modify storage terf:constants blackbody.1441 set value 11980543
data modify storage terf:constants blackbody.1442 set value 11980543
data modify storage terf:constants blackbody.1443 set value 11980543
data modify storage terf:constants blackbody.1444 set value 11980543
data modify storage terf:constants blackbody.1445 set value 11980543
data modify storage terf:constants blackbody.1446 set value 11980543
data modify storage terf:constants blackbody.1447 set value 11980543
data modify storage terf:constants blackbody.1448 set value 11980543
data modify storage terf:constants blackbody.1449 set value 11980543
data modify storage terf:constants blackbody.1450 set value 11980543
data modify storage terf:constants blackbody.1451 set value 11980287
data modify storage terf:constants blackbody.1452 set value 11980287
data modify storage terf:constants blackbody.1453 set value 11980287
data modify storage terf:constants blackbody.1454 set value 11980287
data modify storage terf:constants blackbody.1455 set value 11980287
data modify storage terf:constants blackbody.1456 set value 11980287
data modify storage terf:constants blackbody.1457 set value 11980287
data modify storage terf:constants blackbody.1458 set value 11980287
data modify storage terf:constants blackbody.1459 set value 11980287
data modify storage terf:constants blackbody.1460 set value 11980287
data modify storage terf:constants blackbody.1461 set value 11980287
data modify storage terf:constants blackbody.1462 set value 11980287
data modify storage terf:constants blackbody.1463 set value 11980287
data modify storage terf:constants blackbody.1464 set value 11980287
data modify storage terf:constants blackbody.1465 set value 11980287
data modify storage terf:constants blackbody.1466 set value 11914751
data modify storage terf:constants blackbody.1467 set value 11914751
data modify storage terf:constants blackbody.1468 set value 11914751
data modify storage terf:constants blackbody.1469 set value 11914751
data modify storage terf:constants blackbody.1470 set value 11914751
data modify storage terf:constants blackbody.1471 set value 11914751
data modify storage terf:constants blackbody.1472 set value 11914751
data modify storage terf:constants blackbody.1473 set value 11914751
data modify storage terf:constants blackbody.1474 set value 11914751
data modify storage terf:constants blackbody.1475 set value 11914751
data modify storage terf:constants blackbody.1476 set value 11914751
data modify storage terf:constants blackbody.1477 set value 11914751
data modify storage terf:constants blackbody.1478 set value 11914751
data modify storage terf:constants blackbody.1479 set value 11914751
data modify storage terf:constants blackbody.1480 set value 11914751
data modify storage terf:constants blackbody.1481 set value 11914751
data modify storage terf:constants blackbody.1482 set value 11914751
data modify storage terf:constants blackbody.1483 set value 11914751
data modify storage terf:constants blackbody.1484 set value 11914751
data modify storage terf:constants blackbody.1485 set value 11914751
data modify storage terf:constants blackbody.1486 set value 11914751
data modify storage terf:constants blackbody.1487 set value 11914751
data modify storage terf:constants blackbody.1488 set value 11914751
data modify storage terf:constants blackbody.1489 set value 11914751
data modify storage terf:constants blackbody.1490 set value 11914751
data modify storage terf:constants blackbody.1491 set value 11914751
data modify storage terf:constants blackbody.1492 set value 11914751
data modify storage terf:constants blackbody.1493 set value 11914751
data modify storage terf:constants blackbody.1494 set value 11914751
data modify storage terf:constants blackbody.1495 set value 11914751
data modify storage terf:constants blackbody.1496 set value 11914751
data modify storage terf:constants blackbody.1497 set value 11914751
data modify storage terf:constants blackbody.1498 set value 11914751
data modify storage terf:constants blackbody.1499 set value 11914751
data modify storage terf:constants blackbody.1500 set value 11914751
data modify storage terf:constants blackbody.1501 set value 11914751
data modify storage terf:constants blackbody.1502 set value 11849215
data modify storage terf:constants blackbody.1503 set value 11849215
data modify storage terf:constants blackbody.1504 set value 11849215
data modify storage terf:constants blackbody.1505 set value 11849215
data modify storage terf:constants blackbody.1506 set value 11849215
data modify storage terf:constants blackbody.1507 set value 11848959
data modify storage terf:constants blackbody.1508 set value 11848959
data modify storage terf:constants blackbody.1509 set value 11848959
data modify storage terf:constants blackbody.1510 set value 11848959
data modify storage terf:constants blackbody.1511 set value 11848959
data modify storage terf:constants blackbody.1512 set value 11848959
data modify storage terf:constants blackbody.1513 set value 11848959
data modify storage terf:constants blackbody.1514 set value 11848959
data modify storage terf:constants blackbody.1515 set value 11848959
data modify storage terf:constants blackbody.1516 set value 11848959
data modify storage terf:constants blackbody.1517 set value 11848959
data modify storage terf:constants blackbody.1518 set value 11848959
data modify storage terf:constants blackbody.1519 set value 11848959
data modify storage terf:constants blackbody.1520 set value 11848959
data modify storage terf:constants blackbody.1521 set value 11848959
data modify storage terf:constants blackbody.1522 set value 11848959
data modify storage terf:constants blackbody.1523 set value 11848959
data modify storage terf:constants blackbody.1524 set value 11848959
data modify storage terf:constants blackbody.1525 set value 11848959
data modify storage terf:constants blackbody.1526 set value 11848959
data modify storage terf:constants blackbody.1527 set value 11848959
data modify storage terf:constants blackbody.1528 set value 11848959
data modify storage terf:constants blackbody.1529 set value 11848959
data modify storage terf:constants blackbody.1530 set value 11848959
data modify storage terf:constants blackbody.1531 set value 11848959
data modify storage terf:constants blackbody.1532 set value 11848959
data modify storage terf:constants blackbody.1533 set value 11848959
data modify storage terf:constants blackbody.1534 set value 11848959
data modify storage terf:constants blackbody.1535 set value 11848959
data modify storage terf:constants blackbody.1536 set value 11848959
data modify storage terf:constants blackbody.1537 set value 11848959
data modify storage terf:constants blackbody.1538 set value 11848959
data modify storage terf:constants blackbody.1539 set value 11848959
data modify storage terf:constants blackbody.1540 set value 11848959
data modify storage terf:constants blackbody.1541 set value 11783423
data modify storage terf:constants blackbody.1542 set value 11783423
data modify storage terf:constants blackbody.1543 set value 11783423
data modify storage terf:constants blackbody.1544 set value 11783423
data modify storage terf:constants blackbody.1545 set value 11783423
data modify storage terf:constants blackbody.1546 set value 11783423
data modify storage terf:constants blackbody.1547 set value 11783423
data modify storage terf:constants blackbody.1548 set value 11783423
data modify storage terf:constants blackbody.1549 set value 11783423
data modify storage terf:constants blackbody.1550 set value 11783423
data modify storage terf:constants blackbody.1551 set value 11783423
data modify storage terf:constants blackbody.1552 set value 11783423
data modify storage terf:constants blackbody.1553 set value 11783423
data modify storage terf:constants blackbody.1554 set value 11783423
data modify storage terf:constants blackbody.1555 set value 11783423
data modify storage terf:constants blackbody.1556 set value 11783423
data modify storage terf:constants blackbody.1557 set value 11783423
data modify storage terf:constants blackbody.1558 set value 11783423
data modify storage terf:constants blackbody.1559 set value 11783423
data modify storage terf:constants blackbody.1560 set value 11783423
data modify storage terf:constants blackbody.1561 set value 11783423
data modify storage terf:constants blackbody.1562 set value 11783423
data modify storage terf:constants blackbody.1563 set value 11783423
data modify storage terf:constants blackbody.1564 set value 11783423
data modify storage terf:constants blackbody.1565 set value 11783423
data modify storage terf:constants blackbody.1566 set value 11783423
data modify storage terf:constants blackbody.1567 set value 11783423
data modify storage terf:constants blackbody.1568 set value 11783167
data modify storage terf:constants blackbody.1569 set value 11783167
data modify storage terf:constants blackbody.1570 set value 11783167
data modify storage terf:constants blackbody.1571 set value 11783167
data modify storage terf:constants blackbody.1572 set value 11783167
data modify storage terf:constants blackbody.1573 set value 11783167
data modify storage terf:constants blackbody.1574 set value 11783167
data modify storage terf:constants blackbody.1575 set value 11783167
data modify storage terf:constants blackbody.1576 set value 11783167
data modify storage terf:constants blackbody.1577 set value 11783167
data modify storage terf:constants blackbody.1578 set value 11783167
data modify storage terf:constants blackbody.1579 set value 11783167
data modify storage terf:constants blackbody.1580 set value 11783167
data modify storage terf:constants blackbody.1581 set value 11717631
data modify storage terf:constants blackbody.1582 set value 11717631
data modify storage terf:constants blackbody.1583 set value 11717631
data modify storage terf:constants blackbody.1584 set value 11717631
data modify storage terf:constants blackbody.1585 set value 11717631
data modify storage terf:constants blackbody.1586 set value 11717631
data modify storage terf:constants blackbody.1587 set value 11717631
data modify storage terf:constants blackbody.1588 set value 11717631
data modify storage terf:constants blackbody.1589 set value 11717631
data modify storage terf:constants blackbody.1590 set value 11717631
data modify storage terf:constants blackbody.1591 set value 11717631
data modify storage terf:constants blackbody.1592 set value 11717631
data modify storage terf:constants blackbody.1593 set value 11717631
data modify storage terf:constants blackbody.1594 set value 11717631
data modify storage terf:constants blackbody.1595 set value 11717631
data modify storage terf:constants blackbody.1596 set value 11717631
data modify storage terf:constants blackbody.1597 set value 11717631
data modify storage terf:constants blackbody.1598 set value 11717631
data modify storage terf:constants blackbody.1599 set value 11717631
data modify storage terf:constants blackbody.1600 set value 11717631
data modify storage terf:constants blackbody.1601 set value 11717631
data modify storage terf:constants blackbody.1602 set value 11717631
data modify storage terf:constants blackbody.1603 set value 11717631
data modify storage terf:constants blackbody.1604 set value 11717631
data modify storage terf:constants blackbody.1605 set value 11717631
data modify storage terf:constants blackbody.1606 set value 11717631
data modify storage terf:constants blackbody.1607 set value 11717631
data modify storage terf:constants blackbody.1608 set value 11717631
data modify storage terf:constants blackbody.1609 set value 11717631
data modify storage terf:constants blackbody.1610 set value 11717631
data modify storage terf:constants blackbody.1611 set value 11717631
data modify storage terf:constants blackbody.1612 set value 11717631
data modify storage terf:constants blackbody.1613 set value 11717631
data modify storage terf:constants blackbody.1614 set value 11717631
data modify storage terf:constants blackbody.1615 set value 11717631
data modify storage terf:constants blackbody.1616 set value 11717631
data modify storage terf:constants blackbody.1617 set value 11717631
data modify storage terf:constants blackbody.1618 set value 11717631
data modify storage terf:constants blackbody.1619 set value 11717631
data modify storage terf:constants blackbody.1620 set value 11717631
data modify storage terf:constants blackbody.1621 set value 11717631
data modify storage terf:constants blackbody.1622 set value 11717631
data modify storage terf:constants blackbody.1623 set value 11652095
data modify storage terf:constants blackbody.1624 set value 11652095
data modify storage terf:constants blackbody.1625 set value 11652095
data modify storage terf:constants blackbody.1626 set value 11652095
data modify storage terf:constants blackbody.1627 set value 11652095
data modify storage terf:constants blackbody.1628 set value 11652095
data modify storage terf:constants blackbody.1629 set value 11652095
data modify storage terf:constants blackbody.1630 set value 11652095
data modify storage terf:constants blackbody.1631 set value 11652095
data modify storage terf:constants blackbody.1632 set value 11652095
data modify storage terf:constants blackbody.1633 set value 11651839
data modify storage terf:constants blackbody.1634 set value 11651839
data modify storage terf:constants blackbody.1635 set value 11651839
data modify storage terf:constants blackbody.1636 set value 11651839
data modify storage terf:constants blackbody.1637 set value 11651839
data modify storage terf:constants blackbody.1638 set value 11651839
data modify storage terf:constants blackbody.1639 set value 11651839
data modify storage terf:constants blackbody.1640 set value 11651839
data modify storage terf:constants blackbody.1641 set value 11651839
data modify storage terf:constants blackbody.1642 set value 11651839
data modify storage terf:constants blackbody.1643 set value 11651839
data modify storage terf:constants blackbody.1644 set value 11651839
data modify storage terf:constants blackbody.1645 set value 11651839
data modify storage terf:constants blackbody.1646 set value 11651839
data modify storage terf:constants blackbody.1647 set value 11651839
data modify storage terf:constants blackbody.1648 set value 11651839
data modify storage terf:constants blackbody.1649 set value 11651839
data modify storage terf:constants blackbody.1650 set value 11651839
data modify storage terf:constants blackbody.1651 set value 11651839
data modify storage terf:constants blackbody.1652 set value 11651839
data modify storage terf:constants blackbody.1653 set value 11651839
data modify storage terf:constants blackbody.1654 set value 11651839
data modify storage terf:constants blackbody.1655 set value 11651839
data modify storage terf:constants blackbody.1656 set value 11651839
data modify storage terf:constants blackbody.1657 set value 11651839
data modify storage terf:constants blackbody.1658 set value 11651839
data modify storage terf:constants blackbody.1659 set value 11651839
data modify storage terf:constants blackbody.1660 set value 11651839
data modify storage terf:constants blackbody.1661 set value 11651839
data modify storage terf:constants blackbody.1662 set value 11651839
data modify storage terf:constants blackbody.1663 set value 11651839
data modify storage terf:constants blackbody.1664 set value 11651839
data modify storage terf:constants blackbody.1665 set value 11651839
data modify storage terf:constants blackbody.1666 set value 11651839
data modify storage terf:constants blackbody.1667 set value 11586303
data modify storage terf:constants blackbody.1668 set value 11586303
data modify storage terf:constants blackbody.1669 set value 11586303
data modify storage terf:constants blackbody.1670 set value 11586303
data modify storage terf:constants blackbody.1671 set value 11586303
data modify storage terf:constants blackbody.1672 set value 11586303
data modify storage terf:constants blackbody.1673 set value 11586303
data modify storage terf:constants blackbody.1674 set value 11586303
data modify storage terf:constants blackbody.1675 set value 11586303
data modify storage terf:constants blackbody.1676 set value 11586303
data modify storage terf:constants blackbody.1677 set value 11586303
data modify storage terf:constants blackbody.1678 set value 11586303
data modify storage terf:constants blackbody.1679 set value 11586303
data modify storage terf:constants blackbody.1680 set value 11586303
data modify storage terf:constants blackbody.1681 set value 11586303
data modify storage terf:constants blackbody.1682 set value 11586303
data modify storage terf:constants blackbody.1683 set value 11586303
data modify storage terf:constants blackbody.1684 set value 11586303
data modify storage terf:constants blackbody.1685 set value 11586303
data modify storage terf:constants blackbody.1686 set value 11586303
data modify storage terf:constants blackbody.1687 set value 11586303
data modify storage terf:constants blackbody.1688 set value 11586303
data modify storage terf:constants blackbody.1689 set value 11586303
data modify storage terf:constants blackbody.1690 set value 11586303
data modify storage terf:constants blackbody.1691 set value 11586303
data modify storage terf:constants blackbody.1692 set value 11586303
data modify storage terf:constants blackbody.1693 set value 11586303
data modify storage terf:constants blackbody.1694 set value 11586303
data modify storage terf:constants blackbody.1695 set value 11586303
data modify storage terf:constants blackbody.1696 set value 11586303
data modify storage terf:constants blackbody.1697 set value 11586303
data modify storage terf:constants blackbody.1698 set value 11586303
data modify storage terf:constants blackbody.1699 set value 11586303
data modify storage terf:constants blackbody.1700 set value 11586303
data modify storage terf:constants blackbody.1701 set value 11586303
data modify storage terf:constants blackbody.1702 set value 11586303
data modify storage terf:constants blackbody.1703 set value 11586047
data modify storage terf:constants blackbody.1704 set value 11586047
data modify storage terf:constants blackbody.1705 set value 11586047
data modify storage terf:constants blackbody.1706 set value 11586047
data modify storage terf:constants blackbody.1707 set value 11586047
data modify storage terf:constants blackbody.1708 set value 11586047
data modify storage terf:constants blackbody.1709 set value 11586047
data modify storage terf:constants blackbody.1710 set value 11586047
data modify storage terf:constants blackbody.1711 set value 11586047
data modify storage terf:constants blackbody.1712 set value 11586047
data modify storage terf:constants blackbody.1713 set value 11586047
data modify storage terf:constants blackbody.1714 set value 11520511
data modify storage terf:constants blackbody.1715 set value 11520511
data modify storage terf:constants blackbody.1716 set value 11520511
data modify storage terf:constants blackbody.1717 set value 11520511
data modify storage terf:constants blackbody.1718 set value 11520511
data modify storage terf:constants blackbody.1719 set value 11520511
data modify storage terf:constants blackbody.1720 set value 11520511
data modify storage terf:constants blackbody.1721 set value 11520511
data modify storage terf:constants blackbody.1722 set value 11520511
data modify storage terf:constants blackbody.1723 set value 11520511
data modify storage terf:constants blackbody.1724 set value 11520511
data modify storage terf:constants blackbody.1725 set value 11520511
data modify storage terf:constants blackbody.1726 set value 11520511
data modify storage terf:constants blackbody.1727 set value 11520511
data modify storage terf:constants blackbody.1728 set value 11520511
data modify storage terf:constants blackbody.1729 set value 11520511
data modify storage terf:constants blackbody.1730 set value 11520511
data modify storage terf:constants blackbody.1731 set value 11520511
data modify storage terf:constants blackbody.1732 set value 11520511
data modify storage terf:constants blackbody.1733 set value 11520511
data modify storage terf:constants blackbody.1734 set value 11520511
data modify storage terf:constants blackbody.1735 set value 11520511
data modify storage terf:constants blackbody.1736 set value 11520511
data modify storage terf:constants blackbody.1737 set value 11520511
data modify storage terf:constants blackbody.1738 set value 11520511
data modify storage terf:constants blackbody.1739 set value 11520511
data modify storage terf:constants blackbody.1740 set value 11520511
data modify storage terf:constants blackbody.1741 set value 11520511
data modify storage terf:constants blackbody.1742 set value 11520511
data modify storage terf:constants blackbody.1743 set value 11520511
data modify storage terf:constants blackbody.1744 set value 11520511
data modify storage terf:constants blackbody.1745 set value 11520511
data modify storage terf:constants blackbody.1746 set value 11520511
data modify storage terf:constants blackbody.1747 set value 11520511
data modify storage terf:constants blackbody.1748 set value 11520511
data modify storage terf:constants blackbody.1749 set value 11520511
data modify storage terf:constants blackbody.1750 set value 11520511
data modify storage terf:constants blackbody.1751 set value 11520511
data modify storage terf:constants blackbody.1752 set value 11520511
data modify storage terf:constants blackbody.1753 set value 11520511
data modify storage terf:constants blackbody.1754 set value 11520511
data modify storage terf:constants blackbody.1755 set value 11520511
data modify storage terf:constants blackbody.1756 set value 11520511
data modify storage terf:constants blackbody.1757 set value 11520511
data modify storage terf:constants blackbody.1758 set value 11520511
data modify storage terf:constants blackbody.1759 set value 11520511
data modify storage terf:constants blackbody.1760 set value 11520511
data modify storage terf:constants blackbody.1761 set value 11520511
data modify storage terf:constants blackbody.1762 set value 11454975
data modify storage terf:constants blackbody.1763 set value 11454975
data modify storage terf:constants blackbody.1764 set value 11454975
data modify storage terf:constants blackbody.1765 set value 11454975
data modify storage terf:constants blackbody.1766 set value 11454975
data modify storage terf:constants blackbody.1767 set value 11454975
data modify storage terf:constants blackbody.1768 set value 11454975
data modify storage terf:constants blackbody.1769 set value 11454975
data modify storage terf:constants blackbody.1770 set value 11454975
data modify storage terf:constants blackbody.1771 set value 11454975
data modify storage terf:constants blackbody.1772 set value 11454975
data modify storage terf:constants blackbody.1773 set value 11454975
data modify storage terf:constants blackbody.1774 set value 11454975
data modify storage terf:constants blackbody.1775 set value 11454975
data modify storage terf:constants blackbody.1776 set value 11454975
data modify storage terf:constants blackbody.1777 set value 11454975
data modify storage terf:constants blackbody.1778 set value 11454719
data modify storage terf:constants blackbody.1779 set value 11454719
data modify storage terf:constants blackbody.1780 set value 11454719
data modify storage terf:constants blackbody.1781 set value 11454719
data modify storage terf:constants blackbody.1782 set value 11454719
data modify storage terf:constants blackbody.1783 set value 11454719
data modify storage terf:constants blackbody.1784 set value 11454719
data modify storage terf:constants blackbody.1785 set value 11454719
data modify storage terf:constants blackbody.1786 set value 11454719
data modify storage terf:constants blackbody.1787 set value 11454719
data modify storage terf:constants blackbody.1788 set value 11454719
data modify storage terf:constants blackbody.1789 set value 11454719
data modify storage terf:constants blackbody.1790 set value 11454719
data modify storage terf:constants blackbody.1791 set value 11454719
data modify storage terf:constants blackbody.1792 set value 11454719
data modify storage terf:constants blackbody.1793 set value 11454719
data modify storage terf:constants blackbody.1794 set value 11454719
data modify storage terf:constants blackbody.1795 set value 11454719
data modify storage terf:constants blackbody.1796 set value 11454719
data modify storage terf:constants blackbody.1797 set value 11454719
data modify storage terf:constants blackbody.1798 set value 11454719
data modify storage terf:constants blackbody.1799 set value 11454719
data modify storage terf:constants blackbody.1800 set value 11454719
data modify storage terf:constants blackbody.1801 set value 11454719
data modify storage terf:constants blackbody.1802 set value 11454719
data modify storage terf:constants blackbody.1803 set value 11454719
data modify storage terf:constants blackbody.1804 set value 11454719
data modify storage terf:constants blackbody.1805 set value 11454719
data modify storage terf:constants blackbody.1806 set value 11454719
data modify storage terf:constants blackbody.1807 set value 11454719
data modify storage terf:constants blackbody.1808 set value 11454719
data modify storage terf:constants blackbody.1809 set value 11454719
data modify storage terf:constants blackbody.1810 set value 11454719
data modify storage terf:constants blackbody.1811 set value 11454719
data modify storage terf:constants blackbody.1812 set value 11454719
data modify storage terf:constants blackbody.1813 set value 11389183
data modify storage terf:constants blackbody.1814 set value 11389183
data modify storage terf:constants blackbody.1815 set value 11389183
data modify storage terf:constants blackbody.1816 set value 11389183
data modify storage terf:constants blackbody.1817 set value 11389183
data modify storage terf:constants blackbody.1818 set value 11389183
data modify storage terf:constants blackbody.1819 set value 11389183
data modify storage terf:constants blackbody.1820 set value 11389183
data modify storage terf:constants blackbody.1821 set value 11389183
data modify storage terf:constants blackbody.1822 set value 11389183
data modify storage terf:constants blackbody.1823 set value 11389183
data modify storage terf:constants blackbody.1824 set value 11389183
data modify storage terf:constants blackbody.1825 set value 11389183
data modify storage terf:constants blackbody.1826 set value 11389183
data modify storage terf:constants blackbody.1827 set value 11389183
data modify storage terf:constants blackbody.1828 set value 11389183
data modify storage terf:constants blackbody.1829 set value 11389183
data modify storage terf:constants blackbody.1830 set value 11389183
data modify storage terf:constants blackbody.1831 set value 11389183
data modify storage terf:constants blackbody.1832 set value 11389183
data modify storage terf:constants blackbody.1833 set value 11389183
data modify storage terf:constants blackbody.1834 set value 11389183
data modify storage terf:constants blackbody.1835 set value 11389183
data modify storage terf:constants blackbody.1836 set value 11389183
data modify storage terf:constants blackbody.1837 set value 11389183
data modify storage terf:constants blackbody.1838 set value 11389183
data modify storage terf:constants blackbody.1839 set value 11389183
data modify storage terf:constants blackbody.1840 set value 11389183
data modify storage terf:constants blackbody.1841 set value 11389183
data modify storage terf:constants blackbody.1842 set value 11389183
data modify storage terf:constants blackbody.1843 set value 11389183
data modify storage terf:constants blackbody.1844 set value 11389183
data modify storage terf:constants blackbody.1845 set value 11389183
data modify storage terf:constants blackbody.1846 set value 11389183
data modify storage terf:constants blackbody.1847 set value 11389183
data modify storage terf:constants blackbody.1848 set value 11389183
data modify storage terf:constants blackbody.1849 set value 11389183
data modify storage terf:constants blackbody.1850 set value 11389183
data modify storage terf:constants blackbody.1851 set value 11389183
data modify storage terf:constants blackbody.1852 set value 11389183
data modify storage terf:constants blackbody.1853 set value 11389183
data modify storage terf:constants blackbody.1854 set value 11389183
data modify storage terf:constants blackbody.1855 set value 11389183
data modify storage terf:constants blackbody.1856 set value 11389183
data modify storage terf:constants blackbody.1857 set value 11389183
data modify storage terf:constants blackbody.1858 set value 11388927
data modify storage terf:constants blackbody.1859 set value 11388927
data modify storage terf:constants blackbody.1860 set value 11388927
data modify storage terf:constants blackbody.1861 set value 11388927
data modify storage terf:constants blackbody.1862 set value 11388927
data modify storage terf:constants blackbody.1863 set value 11388927
data modify storage terf:constants blackbody.1864 set value 11388927
data modify storage terf:constants blackbody.1865 set value 11388927
data modify storage terf:constants blackbody.1866 set value 11388927
data modify storage terf:constants blackbody.1867 set value 11323391
data modify storage terf:constants blackbody.1868 set value 11323391
data modify storage terf:constants blackbody.1869 set value 11323391
data modify storage terf:constants blackbody.1870 set value 11323391
data modify storage terf:constants blackbody.1871 set value 11323391
data modify storage terf:constants blackbody.1872 set value 11323391
data modify storage terf:constants blackbody.1873 set value 11323391
data modify storage terf:constants blackbody.1874 set value 11323391
data modify storage terf:constants blackbody.1875 set value 11323391
data modify storage terf:constants blackbody.1876 set value 11323391
data modify storage terf:constants blackbody.1877 set value 11323391
data modify storage terf:constants blackbody.1878 set value 11323391
data modify storage terf:constants blackbody.1879 set value 11323391
data modify storage terf:constants blackbody.1880 set value 11323391
data modify storage terf:constants blackbody.1881 set value 11323391
data modify storage terf:constants blackbody.1882 set value 11323391
data modify storage terf:constants blackbody.1883 set value 11323391
data modify storage terf:constants blackbody.1884 set value 11323391
data modify storage terf:constants blackbody.1885 set value 11323391
data modify storage terf:constants blackbody.1886 set value 11323391
data modify storage terf:constants blackbody.1887 set value 11323391
data modify storage terf:constants blackbody.1888 set value 11323391
data modify storage terf:constants blackbody.1889 set value 11323391
data modify storage terf:constants blackbody.1890 set value 11323391
data modify storage terf:constants blackbody.1891 set value 11323391
data modify storage terf:constants blackbody.1892 set value 11323391
data modify storage terf:constants blackbody.1893 set value 11323391
data modify storage terf:constants blackbody.1894 set value 11323391
data modify storage terf:constants blackbody.1895 set value 11323391
data modify storage terf:constants blackbody.1896 set value 11323391
data modify storage terf:constants blackbody.1897 set value 11323391
data modify storage terf:constants blackbody.1898 set value 11323391
data modify storage terf:constants blackbody.1899 set value 11323391
data modify storage terf:constants blackbody.1900 set value 11323391
data modify storage terf:constants blackbody.1901 set value 11323391
data modify storage terf:constants blackbody.1902 set value 11323391
data modify storage terf:constants blackbody.1903 set value 11323391
data modify storage terf:constants blackbody.1904 set value 11323391
data modify storage terf:constants blackbody.1905 set value 11323391
data modify storage terf:constants blackbody.1906 set value 11323391
data modify storage terf:constants blackbody.1907 set value 11323391
data modify storage terf:constants blackbody.1908 set value 11323391
data modify storage terf:constants blackbody.1909 set value 11323391
data modify storage terf:constants blackbody.1910 set value 11323391
data modify storage terf:constants blackbody.1911 set value 11323391
data modify storage terf:constants blackbody.1912 set value 11323391
data modify storage terf:constants blackbody.1913 set value 11323391
data modify storage terf:constants blackbody.1914 set value 11323391
data modify storage terf:constants blackbody.1915 set value 11323391
data modify storage terf:constants blackbody.1916 set value 11323391
data modify storage terf:constants blackbody.1917 set value 11323391
data modify storage terf:constants blackbody.1918 set value 11323391
data modify storage terf:constants blackbody.1919 set value 11323391
data modify storage terf:constants blackbody.1920 set value 11323391
data modify storage terf:constants blackbody.1921 set value 11323391
data modify storage terf:constants blackbody.1922 set value 11323391
data modify storage terf:constants blackbody.1923 set value 11257855
data modify storage terf:constants blackbody.1924 set value 11257855
data modify storage terf:constants blackbody.1925 set value 11257855
data modify storage terf:constants blackbody.1926 set value 11257855
data modify storage terf:constants blackbody.1927 set value 11257855
data modify storage terf:constants blackbody.1928 set value 11257855
data modify storage terf:constants blackbody.1929 set value 11257855
data modify storage terf:constants blackbody.1930 set value 11257855
data modify storage terf:constants blackbody.1931 set value 11257855
data modify storage terf:constants blackbody.1932 set value 11257855
data modify storage terf:constants blackbody.1933 set value 11257855
data modify storage terf:constants blackbody.1934 set value 11257855
data modify storage terf:constants blackbody.1935 set value 11257855
data modify storage terf:constants blackbody.1936 set value 11257855
data modify storage terf:constants blackbody.1937 set value 11257855
data modify storage terf:constants blackbody.1938 set value 11257855
data modify storage terf:constants blackbody.1939 set value 11257855
data modify storage terf:constants blackbody.1940 set value 11257855
data modify storage terf:constants blackbody.1941 set value 11257855
data modify storage terf:constants blackbody.1942 set value 11257855
data modify storage terf:constants blackbody.1943 set value 11257855
data modify storage terf:constants blackbody.1944 set value 11257599
data modify storage terf:constants blackbody.1945 set value 11257599
data modify storage terf:constants blackbody.1946 set value 11257599
data modify storage terf:constants blackbody.1947 set value 11257599
data modify storage terf:constants blackbody.1948 set value 11257599
data modify storage terf:constants blackbody.1949 set value 11257599
data modify storage terf:constants blackbody.1950 set value 11257599
data modify storage terf:constants blackbody.1951 set value 11257599
data modify storage terf:constants blackbody.1952 set value 11257599
data modify storage terf:constants blackbody.1953 set value 11257599
data modify storage terf:constants blackbody.1954 set value 11257599
data modify storage terf:constants blackbody.1955 set value 11257599
data modify storage terf:constants blackbody.1956 set value 11257599
data modify storage terf:constants blackbody.1957 set value 11257599
data modify storage terf:constants blackbody.1958 set value 11257599
data modify storage terf:constants blackbody.1959 set value 11257599
data modify storage terf:constants blackbody.1960 set value 11257599
data modify storage terf:constants blackbody.1961 set value 11257599
data modify storage terf:constants blackbody.1962 set value 11257599
data modify storage terf:constants blackbody.1963 set value 11257599
data modify storage terf:constants blackbody.1964 set value 11257599
data modify storage terf:constants blackbody.1965 set value 11257599
data modify storage terf:constants blackbody.1966 set value 11257599
data modify storage terf:constants blackbody.1967 set value 11257599
data modify storage terf:constants blackbody.1968 set value 11257599
data modify storage terf:constants blackbody.1969 set value 11257599
data modify storage terf:constants blackbody.1970 set value 11257599
data modify storage terf:constants blackbody.1971 set value 11257599
data modify storage terf:constants blackbody.1972 set value 11257599
data modify storage terf:constants blackbody.1973 set value 11257599
data modify storage terf:constants blackbody.1974 set value 11257599
data modify storage terf:constants blackbody.1975 set value 11257599
data modify storage terf:constants blackbody.1976 set value 11257599
data modify storage terf:constants blackbody.1977 set value 11257599
data modify storage terf:constants blackbody.1978 set value 11257599
data modify storage terf:constants blackbody.1979 set value 11257599
data modify storage terf:constants blackbody.1980 set value 11257599
data modify storage terf:constants blackbody.1981 set value 11257599
data modify storage terf:constants blackbody.1982 set value 11192063

data modify storage terf:constants blackbody_hex.0 set value "#000000"
data modify storage terf:constants blackbody_hex.1 set value "#000000"
data modify storage terf:constants blackbody_hex.2 set value "#000000"
data modify storage terf:constants blackbody_hex.3 set value "#000000"
data modify storage terf:constants blackbody_hex.4 set value "#000000"
data modify storage terf:constants blackbody_hex.5 set value "#000000"
data modify storage terf:constants blackbody_hex.6 set value "#000000"
data modify storage terf:constants blackbody_hex.7 set value "#000000"
data modify storage terf:constants blackbody_hex.8 set value "#000000"
data modify storage terf:constants blackbody_hex.9 set value "#000000"
data modify storage terf:constants blackbody_hex.10 set value "#000000"
data modify storage terf:constants blackbody_hex.11 set value "#000000"
data modify storage terf:constants blackbody_hex.12 set value "#080000"
data modify storage terf:constants blackbody_hex.13 set value "#100000"
data modify storage terf:constants blackbody_hex.14 set value "#180000"
data modify storage terf:constants blackbody_hex.15 set value "#200000"
data modify storage terf:constants blackbody_hex.16 set value "#280000"
data modify storage terf:constants blackbody_hex.17 set value "#300000"
data modify storage terf:constants blackbody_hex.18 set value "#380000"
data modify storage terf:constants blackbody_hex.19 set value "#400000"
data modify storage terf:constants blackbody_hex.20 set value "#480000"
data modify storage terf:constants blackbody_hex.31 set value "#500000"
data modify storage terf:constants blackbody_hex.32 set value "#580000"
data modify storage terf:constants blackbody_hex.33 set value "#600000"
data modify storage terf:constants blackbody_hex.34 set value "#680000"
data modify storage terf:constants blackbody_hex.35 set value "#700000"
data modify storage terf:constants blackbody_hex.36 set value "#780000"
data modify storage terf:constants blackbody_hex.37 set value "#800000"
data modify storage terf:constants blackbody_hex.38 set value "#880000"
data modify storage terf:constants blackbody_hex.39 set value "#900000"
data modify storage terf:constants blackbody_hex.40 set value "#980000"
data modify storage terf:constants blackbody_hex.41 set value "#A00000"
data modify storage terf:constants blackbody_hex.42 set value "#A80000"
data modify storage terf:constants blackbody_hex.43 set value "#B00000"
data modify storage terf:constants blackbody_hex.44 set value "#B80000"
data modify storage terf:constants blackbody_hex.45 set value "#C00000"
data modify storage terf:constants blackbody_hex.46 set value "#C80000"
data modify storage terf:constants blackbody_hex.47 set value "#D00000"
data modify storage terf:constants blackbody_hex.48 set value "#D80000"
data modify storage terf:constants blackbody_hex.49 set value "#E00000"
data modify storage terf:constants blackbody_hex.50 set value "#E80000"
data modify storage terf:constants blackbody_hex.51 set value "#FF0000"
data modify storage terf:constants blackbody_hex.52 set value "#FF0200"
data modify storage terf:constants blackbody_hex.53 set value "#FF0400"
data modify storage terf:constants blackbody_hex.54 set value "#FF0600"
data modify storage terf:constants blackbody_hex.55 set value "#FF0800"
data modify storage terf:constants blackbody_hex.56 set value "#FF0A00"
data modify storage terf:constants blackbody_hex.57 set value "#FF0C00"
data modify storage terf:constants blackbody_hex.58 set value "#FF0D00"
data modify storage terf:constants blackbody_hex.59 set value "#FF0F00"
data modify storage terf:constants blackbody_hex.60 set value "#FF1100"
data modify storage terf:constants blackbody_hex.61 set value "#FF1200"
data modify storage terf:constants blackbody_hex.62 set value "#FF1400"
data modify storage terf:constants blackbody_hex.63 set value "#FF1500"
data modify storage terf:constants blackbody_hex.64 set value "#FF1700"
data modify storage terf:constants blackbody_hex.65 set value "#FF1900"
data modify storage terf:constants blackbody_hex.66 set value "#FF1A00"
data modify storage terf:constants blackbody_hex.67 set value "#FF1C00"
data modify storage terf:constants blackbody_hex.68 set value "#FF1D00"
data modify storage terf:constants blackbody_hex.69 set value "#FF1F00"
data modify storage terf:constants blackbody_hex.70 set value "#FF2000"
data modify storage terf:constants blackbody_hex.71 set value "#FF2100"
data modify storage terf:constants blackbody_hex.72 set value "#FF2300"
data modify storage terf:constants blackbody_hex.73 set value "#FF2400"
data modify storage terf:constants blackbody_hex.74 set value "#FF2500"
data modify storage terf:constants blackbody_hex.75 set value "#FF2700"
data modify storage terf:constants blackbody_hex.76 set value "#FF2800"
data modify storage terf:constants blackbody_hex.77 set value "#FF2900"
data modify storage terf:constants blackbody_hex.78 set value "#FF2B00"
data modify storage terf:constants blackbody_hex.79 set value "#FF2C00"
data modify storage terf:constants blackbody_hex.80 set value "#FF2D00"
data modify storage terf:constants blackbody_hex.81 set value "#FF2E00"
data modify storage terf:constants blackbody_hex.82 set value "#FF3000"
data modify storage terf:constants blackbody_hex.83 set value "#FF3100"
data modify storage terf:constants blackbody_hex.84 set value "#FF3200"
data modify storage terf:constants blackbody_hex.85 set value "#FF3300"
data modify storage terf:constants blackbody_hex.86 set value "#FF3400"
data modify storage terf:constants blackbody_hex.87 set value "#FF3600"
data modify storage terf:constants blackbody_hex.88 set value "#FF3700"
data modify storage terf:constants blackbody_hex.89 set value "#FF3800"
data modify storage terf:constants blackbody_hex.90 set value "#FF3900"
data modify storage terf:constants blackbody_hex.91 set value "#FF3A00"
data modify storage terf:constants blackbody_hex.92 set value "#FF3B00"
data modify storage terf:constants blackbody_hex.93 set value "#FF3C00"
data modify storage terf:constants blackbody_hex.94 set value "#FF3D00"
data modify storage terf:constants blackbody_hex.95 set value "#FF3E00"
data modify storage terf:constants blackbody_hex.96 set value "#FF3F00"
data modify storage terf:constants blackbody_hex.97 set value "#FF4000"
data modify storage terf:constants blackbody_hex.98 set value "#FF4100"
data modify storage terf:constants blackbody_hex.99 set value "#FF4200"
data modify storage terf:constants blackbody_hex.100 set value "#FF4300"
data modify storage terf:constants blackbody_hex.101 set value "#FF4400"
data modify storage terf:constants blackbody_hex.102 set value "#FF4500"
data modify storage terf:constants blackbody_hex.103 set value "#FF4600"
data modify storage terf:constants blackbody_hex.104 set value "#FF4700"
data modify storage terf:constants blackbody_hex.105 set value "#FF4800"
data modify storage terf:constants blackbody_hex.106 set value "#FF4900"
data modify storage terf:constants blackbody_hex.107 set value "#FF4A00"
data modify storage terf:constants blackbody_hex.108 set value "#FF4B00"
data modify storage terf:constants blackbody_hex.109 set value "#FF4C00"
data modify storage terf:constants blackbody_hex.110 set value "#FF4D00"
data modify storage terf:constants blackbody_hex.111 set value "#FF4E00"
data modify storage terf:constants blackbody_hex.112 set value "#FF4F00"
data modify storage terf:constants blackbody_hex.113 set value "#FF5000"
data modify storage terf:constants blackbody_hex.114 set value "#FF5000"
data modify storage terf:constants blackbody_hex.115 set value "#FF5100"
data modify storage terf:constants blackbody_hex.116 set value "#FF5200"
data modify storage terf:constants blackbody_hex.117 set value "#FF5300"
data modify storage terf:constants blackbody_hex.118 set value "#FF5400"
data modify storage terf:constants blackbody_hex.119 set value "#FF5500"
data modify storage terf:constants blackbody_hex.120 set value "#FF5600"
data modify storage terf:constants blackbody_hex.121 set value "#FF5600"
data modify storage terf:constants blackbody_hex.122 set value "#FF5700"
data modify storage terf:constants blackbody_hex.123 set value "#FF5800"
data modify storage terf:constants blackbody_hex.124 set value "#FF5900"
data modify storage terf:constants blackbody_hex.125 set value "#FF5A00"
data modify storage terf:constants blackbody_hex.126 set value "#FF5A00"
data modify storage terf:constants blackbody_hex.127 set value "#FF5B00"
data modify storage terf:constants blackbody_hex.128 set value "#FF5C00"
data modify storage terf:constants blackbody_hex.129 set value "#FF5D00"
data modify storage terf:constants blackbody_hex.130 set value "#FF5E00"
data modify storage terf:constants blackbody_hex.131 set value "#FF5E00"
data modify storage terf:constants blackbody_hex.132 set value "#FF5F00"
data modify storage terf:constants blackbody_hex.133 set value "#FF6000"
data modify storage terf:constants blackbody_hex.134 set value "#FF6100"
data modify storage terf:constants blackbody_hex.135 set value "#FF6100"
data modify storage terf:constants blackbody_hex.136 set value "#FF6200"
data modify storage terf:constants blackbody_hex.137 set value "#FF6300"
data modify storage terf:constants blackbody_hex.138 set value "#FF6300"
data modify storage terf:constants blackbody_hex.139 set value "#FF6400"
data modify storage terf:constants blackbody_hex.140 set value "#FF6500"
data modify storage terf:constants blackbody_hex.141 set value "#FF6600"
data modify storage terf:constants blackbody_hex.142 set value "#FF6600"
data modify storage terf:constants blackbody_hex.143 set value "#FF6700"
data modify storage terf:constants blackbody_hex.144 set value "#FF6800"
data modify storage terf:constants blackbody_hex.145 set value "#FF6800"
data modify storage terf:constants blackbody_hex.146 set value "#FF6900"
data modify storage terf:constants blackbody_hex.147 set value "#FF6A00"
data modify storage terf:constants blackbody_hex.148 set value "#FF6A00"
data modify storage terf:constants blackbody_hex.149 set value "#FF6B00"
data modify storage terf:constants blackbody_hex.150 set value "#FF6C00"
data modify storage terf:constants blackbody_hex.151 set value "#FF6C00"
data modify storage terf:constants blackbody_hex.152 set value "#FF6D00"
data modify storage terf:constants blackbody_hex.153 set value "#FF6E00"
data modify storage terf:constants blackbody_hex.154 set value "#FF6E00"
data modify storage terf:constants blackbody_hex.155 set value "#FF6F00"
data modify storage terf:constants blackbody_hex.156 set value "#FF7000"
data modify storage terf:constants blackbody_hex.157 set value "#FF7000"
data modify storage terf:constants blackbody_hex.158 set value "#FF7100"
data modify storage terf:constants blackbody_hex.159 set value "#FF7200"
data modify storage terf:constants blackbody_hex.160 set value "#FF7200"
data modify storage terf:constants blackbody_hex.161 set value "#FF7300"
data modify storage terf:constants blackbody_hex.162 set value "#FF7300"
data modify storage terf:constants blackbody_hex.163 set value "#FF7400"
data modify storage terf:constants blackbody_hex.164 set value "#FF7500"
data modify storage terf:constants blackbody_hex.165 set value "#FF7500"
data modify storage terf:constants blackbody_hex.166 set value "#FF7600"
data modify storage terf:constants blackbody_hex.167 set value "#FF7600"
data modify storage terf:constants blackbody_hex.168 set value "#FF7700"
data modify storage terf:constants blackbody_hex.169 set value "#FF7800"
data modify storage terf:constants blackbody_hex.170 set value "#FF7800"
data modify storage terf:constants blackbody_hex.171 set value "#FF7900"
data modify storage terf:constants blackbody_hex.172 set value "#FF7900"
data modify storage terf:constants blackbody_hex.173 set value "#FF7A00"
data modify storage terf:constants blackbody_hex.174 set value "#FF7B00"
data modify storage terf:constants blackbody_hex.175 set value "#FF7B00"
data modify storage terf:constants blackbody_hex.176 set value "#FF7C00"
data modify storage terf:constants blackbody_hex.177 set value "#FF7C00"
data modify storage terf:constants blackbody_hex.178 set value "#FF7D00"
data modify storage terf:constants blackbody_hex.179 set value "#FF7D00"
data modify storage terf:constants blackbody_hex.180 set value "#FF7E00"
data modify storage terf:constants blackbody_hex.181 set value "#FF7E00"
data modify storage terf:constants blackbody_hex.182 set value "#FF7F00"
data modify storage terf:constants blackbody_hex.183 set value "#FF8000"
data modify storage terf:constants blackbody_hex.184 set value "#FF8000"
data modify storage terf:constants blackbody_hex.185 set value "#FF8100"
data modify storage terf:constants blackbody_hex.186 set value "#FF8100"
data modify storage terf:constants blackbody_hex.187 set value "#FF8200"
data modify storage terf:constants blackbody_hex.188 set value "#FF8200"
data modify storage terf:constants blackbody_hex.189 set value "#FF8300"
data modify storage terf:constants blackbody_hex.190 set value "#FF8300"
data modify storage terf:constants blackbody_hex.191 set value "#FF8400"
data modify storage terf:constants blackbody_hex.192 set value "#FF8402"
data modify storage terf:constants blackbody_hex.193 set value "#FF8503"
data modify storage terf:constants blackbody_hex.194 set value "#FF8505"
data modify storage terf:constants blackbody_hex.195 set value "#FF8606"
data modify storage terf:constants blackbody_hex.196 set value "#FF8608"
data modify storage terf:constants blackbody_hex.197 set value "#FF8709"
data modify storage terf:constants blackbody_hex.198 set value "#FF870B"
data modify storage terf:constants blackbody_hex.199 set value "#FF880C"
data modify storage terf:constants blackbody_hex.200 set value "#FF880D"
data modify storage terf:constants blackbody_hex.201 set value "#FF890F"
data modify storage terf:constants blackbody_hex.202 set value "#FF8910"
data modify storage terf:constants blackbody_hex.203 set value "#FF8A11"
data modify storage terf:constants blackbody_hex.204 set value "#FF8A13"
data modify storage terf:constants blackbody_hex.205 set value "#FF8B14"
data modify storage terf:constants blackbody_hex.206 set value "#FF8B15"
data modify storage terf:constants blackbody_hex.207 set value "#FF8C17"
data modify storage terf:constants blackbody_hex.208 set value "#FF8C18"
data modify storage terf:constants blackbody_hex.209 set value "#FF8D19"
data modify storage terf:constants blackbody_hex.210 set value "#FF8D1B"
data modify storage terf:constants blackbody_hex.211 set value "#FF8E1C"
data modify storage terf:constants blackbody_hex.212 set value "#FF8E1D"
data modify storage terf:constants blackbody_hex.213 set value "#FF8F1E"
data modify storage terf:constants blackbody_hex.214 set value "#FF8F20"
data modify storage terf:constants blackbody_hex.215 set value "#FF9021"
data modify storage terf:constants blackbody_hex.216 set value "#FF9022"
data modify storage terf:constants blackbody_hex.217 set value "#FF9023"
data modify storage terf:constants blackbody_hex.218 set value "#FF9124"
data modify storage terf:constants blackbody_hex.219 set value "#FF9125"
data modify storage terf:constants blackbody_hex.220 set value "#FF9227"
data modify storage terf:constants blackbody_hex.221 set value "#FF9228"
data modify storage terf:constants blackbody_hex.222 set value "#FF9329"
data modify storage terf:constants blackbody_hex.223 set value "#FF932A"
data modify storage terf:constants blackbody_hex.224 set value "#FF942B"
data modify storage terf:constants blackbody_hex.225 set value "#FF942C"
data modify storage terf:constants blackbody_hex.226 set value "#FF952D"
data modify storage terf:constants blackbody_hex.227 set value "#FF952F"
data modify storage terf:constants blackbody_hex.228 set value "#FF9530"
data modify storage terf:constants blackbody_hex.229 set value "#FF9631"
data modify storage terf:constants blackbody_hex.230 set value "#FF9632"
data modify storage terf:constants blackbody_hex.231 set value "#FF9733"
data modify storage terf:constants blackbody_hex.232 set value "#FF9734"
data modify storage terf:constants blackbody_hex.233 set value "#FF9835"
data modify storage terf:constants blackbody_hex.234 set value "#FF9836"
data modify storage terf:constants blackbody_hex.235 set value "#FF9837"
data modify storage terf:constants blackbody_hex.236 set value "#FF9938"
data modify storage terf:constants blackbody_hex.237 set value "#FF9939"
data modify storage terf:constants blackbody_hex.238 set value "#FF9A3A"
data modify storage terf:constants blackbody_hex.239 set value "#FF9A3B"
data modify storage terf:constants blackbody_hex.240 set value "#FF9B3C"
data modify storage terf:constants blackbody_hex.241 set value "#FF9B3D"
data modify storage terf:constants blackbody_hex.242 set value "#FF9B3E"
data modify storage terf:constants blackbody_hex.243 set value "#FF9C3F"
data modify storage terf:constants blackbody_hex.244 set value "#FF9C40"
data modify storage terf:constants blackbody_hex.245 set value "#FF9D41"
data modify storage terf:constants blackbody_hex.246 set value "#FF9D42"
data modify storage terf:constants blackbody_hex.247 set value "#FF9D43"
data modify storage terf:constants blackbody_hex.248 set value "#FF9E44"
data modify storage terf:constants blackbody_hex.249 set value "#FF9E45"
data modify storage terf:constants blackbody_hex.250 set value "#FF9F46"
data modify storage terf:constants blackbody_hex.251 set value "#FF9F46"
data modify storage terf:constants blackbody_hex.252 set value "#FF9F47"
data modify storage terf:constants blackbody_hex.253 set value "#FFA048"
data modify storage terf:constants blackbody_hex.254 set value "#FFA049"
data modify storage terf:constants blackbody_hex.255 set value "#FFA14A"
data modify storage terf:constants blackbody_hex.256 set value "#FFA14B"
data modify storage terf:constants blackbody_hex.257 set value "#FFA14C"
data modify storage terf:constants blackbody_hex.258 set value "#FFA24D"
data modify storage terf:constants blackbody_hex.259 set value "#FFA24E"
data modify storage terf:constants blackbody_hex.260 set value "#FFA24F"
data modify storage terf:constants blackbody_hex.261 set value "#FFA34F"
data modify storage terf:constants blackbody_hex.262 set value "#FFA350"
data modify storage terf:constants blackbody_hex.263 set value "#FFA451"
data modify storage terf:constants blackbody_hex.264 set value "#FFA452"
data modify storage terf:constants blackbody_hex.265 set value "#FFA453"
data modify storage terf:constants blackbody_hex.266 set value "#FFA554"
data modify storage terf:constants blackbody_hex.267 set value "#FFA554"
data modify storage terf:constants blackbody_hex.268 set value "#FFA555"
data modify storage terf:constants blackbody_hex.269 set value "#FFA656"
data modify storage terf:constants blackbody_hex.270 set value "#FFA657"
data modify storage terf:constants blackbody_hex.271 set value "#FFA758"
data modify storage terf:constants blackbody_hex.272 set value "#FFA759"
data modify storage terf:constants blackbody_hex.273 set value "#FFA759"
data modify storage terf:constants blackbody_hex.274 set value "#FFA85A"
data modify storage terf:constants blackbody_hex.275 set value "#FFA85B"
data modify storage terf:constants blackbody_hex.276 set value "#FFA85C"
data modify storage terf:constants blackbody_hex.277 set value "#FFA95C"
data modify storage terf:constants blackbody_hex.278 set value "#FFA95D"
data modify storage terf:constants blackbody_hex.279 set value "#FFA95E"
data modify storage terf:constants blackbody_hex.280 set value "#FFAA5F"
data modify storage terf:constants blackbody_hex.281 set value "#FFAA60"
data modify storage terf:constants blackbody_hex.282 set value "#FFAB60"
data modify storage terf:constants blackbody_hex.283 set value "#FFAB61"
data modify storage terf:constants blackbody_hex.284 set value "#FFAB62"
data modify storage terf:constants blackbody_hex.285 set value "#FFAC63"
data modify storage terf:constants blackbody_hex.286 set value "#FFAC63"
data modify storage terf:constants blackbody_hex.287 set value "#FFAC64"
data modify storage terf:constants blackbody_hex.288 set value "#FFAD65"
data modify storage terf:constants blackbody_hex.289 set value "#FFAD66"
data modify storage terf:constants blackbody_hex.290 set value "#FFAD66"
data modify storage terf:constants blackbody_hex.291 set value "#FFAE67"
data modify storage terf:constants blackbody_hex.292 set value "#FFAE68"
data modify storage terf:constants blackbody_hex.293 set value "#FFAE68"
data modify storage terf:constants blackbody_hex.294 set value "#FFAF69"
data modify storage terf:constants blackbody_hex.295 set value "#FFAF6A"
data modify storage terf:constants blackbody_hex.296 set value "#FFAF6B"
data modify storage terf:constants blackbody_hex.297 set value "#FFB06B"
data modify storage terf:constants blackbody_hex.298 set value "#FFB06C"
data modify storage terf:constants blackbody_hex.299 set value "#FFB06D"
data modify storage terf:constants blackbody_hex.300 set value "#FFB16D"
data modify storage terf:constants blackbody_hex.301 set value "#FFB16E"
data modify storage terf:constants blackbody_hex.302 set value "#FFB16F"
data modify storage terf:constants blackbody_hex.303 set value "#FFB26F"
data modify storage terf:constants blackbody_hex.304 set value "#FFB270"
data modify storage terf:constants blackbody_hex.305 set value "#FFB271"
data modify storage terf:constants blackbody_hex.306 set value "#FFB372"
data modify storage terf:constants blackbody_hex.307 set value "#FFB372"
data modify storage terf:constants blackbody_hex.308 set value "#FFB373"
data modify storage terf:constants blackbody_hex.309 set value "#FFB474"
data modify storage terf:constants blackbody_hex.310 set value "#FFB474"
data modify storage terf:constants blackbody_hex.311 set value "#FFB475"
data modify storage terf:constants blackbody_hex.312 set value "#FFB575"
data modify storage terf:constants blackbody_hex.313 set value "#FFB576"
data modify storage terf:constants blackbody_hex.314 set value "#FFB577"
data modify storage terf:constants blackbody_hex.315 set value "#FFB677"
data modify storage terf:constants blackbody_hex.316 set value "#FFB678"
data modify storage terf:constants blackbody_hex.317 set value "#FFB679"
data modify storage terf:constants blackbody_hex.318 set value "#FFB679"
data modify storage terf:constants blackbody_hex.319 set value "#FFB77A"
data modify storage terf:constants blackbody_hex.320 set value "#FFB77B"
data modify storage terf:constants blackbody_hex.321 set value "#FFB77B"
data modify storage terf:constants blackbody_hex.322 set value "#FFB87C"
data modify storage terf:constants blackbody_hex.323 set value "#FFB87C"
data modify storage terf:constants blackbody_hex.324 set value "#FFB87D"
data modify storage terf:constants blackbody_hex.325 set value "#FFB97E"
data modify storage terf:constants blackbody_hex.326 set value "#FFB97E"
data modify storage terf:constants blackbody_hex.327 set value "#FFB97F"
data modify storage terf:constants blackbody_hex.328 set value "#FFBA80"
data modify storage terf:constants blackbody_hex.329 set value "#FFBA80"
data modify storage terf:constants blackbody_hex.330 set value "#FFBA81"
data modify storage terf:constants blackbody_hex.331 set value "#FFBA81"
data modify storage terf:constants blackbody_hex.332 set value "#FFBB82"
data modify storage terf:constants blackbody_hex.333 set value "#FFBB83"
data modify storage terf:constants blackbody_hex.334 set value "#FFBB83"
data modify storage terf:constants blackbody_hex.335 set value "#FFBC84"
data modify storage terf:constants blackbody_hex.336 set value "#FFBC84"
data modify storage terf:constants blackbody_hex.337 set value "#FFBC85"
data modify storage terf:constants blackbody_hex.338 set value "#FFBD86"
data modify storage terf:constants blackbody_hex.339 set value "#FFBD86"
data modify storage terf:constants blackbody_hex.340 set value "#FFBD87"
data modify storage terf:constants blackbody_hex.341 set value "#FFBD87"
data modify storage terf:constants blackbody_hex.342 set value "#FFBE88"
data modify storage terf:constants blackbody_hex.343 set value "#FFBE88"
data modify storage terf:constants blackbody_hex.344 set value "#FFBE89"
data modify storage terf:constants blackbody_hex.345 set value "#FFBF8A"
data modify storage terf:constants blackbody_hex.346 set value "#FFBF8A"
data modify storage terf:constants blackbody_hex.347 set value "#FFBF8B"
data modify storage terf:constants blackbody_hex.348 set value "#FFBF8B"
data modify storage terf:constants blackbody_hex.349 set value "#FFC08C"
data modify storage terf:constants blackbody_hex.350 set value "#FFC08C"
data modify storage terf:constants blackbody_hex.351 set value "#FFC08D"
data modify storage terf:constants blackbody_hex.352 set value "#FFC18D"
data modify storage terf:constants blackbody_hex.353 set value "#FFC18E"
data modify storage terf:constants blackbody_hex.354 set value "#FFC18F"
data modify storage terf:constants blackbody_hex.355 set value "#FFC18F"
data modify storage terf:constants blackbody_hex.356 set value "#FFC290"
data modify storage terf:constants blackbody_hex.357 set value "#FFC290"
data modify storage terf:constants blackbody_hex.358 set value "#FFC291"
data modify storage terf:constants blackbody_hex.359 set value "#FFC391"
data modify storage terf:constants blackbody_hex.360 set value "#FFC392"
data modify storage terf:constants blackbody_hex.361 set value "#FFC392"
data modify storage terf:constants blackbody_hex.362 set value "#FFC393"
data modify storage terf:constants blackbody_hex.363 set value "#FFC493"
data modify storage terf:constants blackbody_hex.364 set value "#FFC494"
data modify storage terf:constants blackbody_hex.365 set value "#FFC494"
data modify storage terf:constants blackbody_hex.366 set value "#FFC495"
data modify storage terf:constants blackbody_hex.367 set value "#FFC595"
data modify storage terf:constants blackbody_hex.368 set value "#FFC596"
data modify storage terf:constants blackbody_hex.369 set value "#FFC596"
data modify storage terf:constants blackbody_hex.370 set value "#FFC697"
data modify storage terf:constants blackbody_hex.371 set value "#FFC697"
data modify storage terf:constants blackbody_hex.372 set value "#FFC698"
data modify storage terf:constants blackbody_hex.373 set value "#FFC699"
data modify storage terf:constants blackbody_hex.374 set value "#FFC799"
data modify storage terf:constants blackbody_hex.375 set value "#FFC79A"
data modify storage terf:constants blackbody_hex.376 set value "#FFC79A"
data modify storage terf:constants blackbody_hex.377 set value "#FFC79B"
data modify storage terf:constants blackbody_hex.378 set value "#FFC89B"
data modify storage terf:constants blackbody_hex.379 set value "#FFC89C"
data modify storage terf:constants blackbody_hex.380 set value "#FFC89C"
data modify storage terf:constants blackbody_hex.381 set value "#FFC89D"
data modify storage terf:constants blackbody_hex.382 set value "#FFC99D"
data modify storage terf:constants blackbody_hex.383 set value "#FFC99E"
data modify storage terf:constants blackbody_hex.384 set value "#FFC99E"
data modify storage terf:constants blackbody_hex.385 set value "#FFCA9E"
data modify storage terf:constants blackbody_hex.386 set value "#FFCA9F"
data modify storage terf:constants blackbody_hex.387 set value "#FFCA9F"
data modify storage terf:constants blackbody_hex.388 set value "#FFCAA0"
data modify storage terf:constants blackbody_hex.389 set value "#FFCBA0"
data modify storage terf:constants blackbody_hex.390 set value "#FFCBA1"
data modify storage terf:constants blackbody_hex.391 set value "#FFCBA1"
data modify storage terf:constants blackbody_hex.392 set value "#FFCBA2"
data modify storage terf:constants blackbody_hex.393 set value "#FFCCA2"
data modify storage terf:constants blackbody_hex.394 set value "#FFCCA3"
data modify storage terf:constants blackbody_hex.395 set value "#FFCCA3"
data modify storage terf:constants blackbody_hex.396 set value "#FFCCA4"
data modify storage terf:constants blackbody_hex.397 set value "#FFCDA4"
data modify storage terf:constants blackbody_hex.398 set value "#FFCDA5"
data modify storage terf:constants blackbody_hex.399 set value "#FFCDA5"
data modify storage terf:constants blackbody_hex.400 set value "#FFCDA6"
data modify storage terf:constants blackbody_hex.401 set value "#FFCEA6"
data modify storage terf:constants blackbody_hex.402 set value "#FFCEA7"
data modify storage terf:constants blackbody_hex.403 set value "#FFCEA7"
data modify storage terf:constants blackbody_hex.404 set value "#FFCEA7"
data modify storage terf:constants blackbody_hex.405 set value "#FFCFA8"
data modify storage terf:constants blackbody_hex.406 set value "#FFCFA8"
data modify storage terf:constants blackbody_hex.407 set value "#FFCFA9"
data modify storage terf:constants blackbody_hex.408 set value "#FFCFA9"
data modify storage terf:constants blackbody_hex.409 set value "#FFD0AA"
data modify storage terf:constants blackbody_hex.410 set value "#FFD0AA"
data modify storage terf:constants blackbody_hex.411 set value "#FFD0AB"
data modify storage terf:constants blackbody_hex.412 set value "#FFD0AB"
data modify storage terf:constants blackbody_hex.413 set value "#FFD0AB"
data modify storage terf:constants blackbody_hex.414 set value "#FFD1AC"
data modify storage terf:constants blackbody_hex.415 set value "#FFD1AC"
data modify storage terf:constants blackbody_hex.416 set value "#FFD1AD"
data modify storage terf:constants blackbody_hex.417 set value "#FFD1AD"
data modify storage terf:constants blackbody_hex.418 set value "#FFD2AE"
data modify storage terf:constants blackbody_hex.419 set value "#FFD2AE"
data modify storage terf:constants blackbody_hex.420 set value "#FFD2AF"
data modify storage terf:constants blackbody_hex.421 set value "#FFD2AF"
data modify storage terf:constants blackbody_hex.422 set value "#FFD3AF"
data modify storage terf:constants blackbody_hex.423 set value "#FFD3B0"
data modify storage terf:constants blackbody_hex.424 set value "#FFD3B0"
data modify storage terf:constants blackbody_hex.425 set value "#FFD3B1"
data modify storage terf:constants blackbody_hex.426 set value "#FFD4B1"
data modify storage terf:constants blackbody_hex.427 set value "#FFD4B2"
data modify storage terf:constants blackbody_hex.428 set value "#FFD4B2"
data modify storage terf:constants blackbody_hex.429 set value "#FFD4B2"
data modify storage terf:constants blackbody_hex.430 set value "#FFD5B3"
data modify storage terf:constants blackbody_hex.431 set value "#FFD5B3"
data modify storage terf:constants blackbody_hex.432 set value "#FFD5B4"
data modify storage terf:constants blackbody_hex.433 set value "#FFD5B4"
data modify storage terf:constants blackbody_hex.434 set value "#FFD5B4"
data modify storage terf:constants blackbody_hex.435 set value "#FFD6B5"
data modify storage terf:constants blackbody_hex.436 set value "#FFD6B5"
data modify storage terf:constants blackbody_hex.437 set value "#FFD6B6"
data modify storage terf:constants blackbody_hex.438 set value "#FFD6B6"
data modify storage terf:constants blackbody_hex.439 set value "#FFD7B7"
data modify storage terf:constants blackbody_hex.440 set value "#FFD7B7"
data modify storage terf:constants blackbody_hex.441 set value "#FFD7B7"
data modify storage terf:constants blackbody_hex.442 set value "#FFD7B8"
data modify storage terf:constants blackbody_hex.443 set value "#FFD7B8"
data modify storage terf:constants blackbody_hex.444 set value "#FFD8B9"
data modify storage terf:constants blackbody_hex.445 set value "#FFD8B9"
data modify storage terf:constants blackbody_hex.446 set value "#FFD8B9"
data modify storage terf:constants blackbody_hex.447 set value "#FFD8BA"
data modify storage terf:constants blackbody_hex.448 set value "#FFD9BA"
data modify storage terf:constants blackbody_hex.449 set value "#FFD9BB"
data modify storage terf:constants blackbody_hex.450 set value "#FFD9BB"
data modify storage terf:constants blackbody_hex.451 set value "#FFD9BB"
data modify storage terf:constants blackbody_hex.452 set value "#FFD9BC"
data modify storage terf:constants blackbody_hex.453 set value "#FFDABC"
data modify storage terf:constants blackbody_hex.454 set value "#FFDABD"
data modify storage terf:constants blackbody_hex.455 set value "#FFDABD"
data modify storage terf:constants blackbody_hex.456 set value "#FFDABD"
data modify storage terf:constants blackbody_hex.457 set value "#FFDBBE"
data modify storage terf:constants blackbody_hex.458 set value "#FFDBBE"
data modify storage terf:constants blackbody_hex.459 set value "#FFDBBE"
data modify storage terf:constants blackbody_hex.460 set value "#FFDBBF"
data modify storage terf:constants blackbody_hex.461 set value "#FFDBBF"
data modify storage terf:constants blackbody_hex.462 set value "#FFDCC0"
data modify storage terf:constants blackbody_hex.463 set value "#FFDCC0"
data modify storage terf:constants blackbody_hex.464 set value "#FFDCC0"
data modify storage terf:constants blackbody_hex.465 set value "#FFDCC1"
data modify storage terf:constants blackbody_hex.466 set value "#FFDDC1"
data modify storage terf:constants blackbody_hex.467 set value "#FFDDC2"
data modify storage terf:constants blackbody_hex.468 set value "#FFDDC2"
data modify storage terf:constants blackbody_hex.469 set value "#FFDDC2"
data modify storage terf:constants blackbody_hex.470 set value "#FFDDC3"
data modify storage terf:constants blackbody_hex.471 set value "#FFDEC3"
data modify storage terf:constants blackbody_hex.472 set value "#FFDEC3"
data modify storage terf:constants blackbody_hex.473 set value "#FFDEC4"
data modify storage terf:constants blackbody_hex.474 set value "#FFDEC4"
data modify storage terf:constants blackbody_hex.475 set value "#FFDEC4"
data modify storage terf:constants blackbody_hex.476 set value "#FFDFC5"
data modify storage terf:constants blackbody_hex.477 set value "#FFDFC5"
data modify storage terf:constants blackbody_hex.478 set value "#FFDFC6"
data modify storage terf:constants blackbody_hex.479 set value "#FFDFC6"
data modify storage terf:constants blackbody_hex.480 set value "#FFDFC6"
data modify storage terf:constants blackbody_hex.481 set value "#FFE0C7"
data modify storage terf:constants blackbody_hex.482 set value "#FFE0C7"
data modify storage terf:constants blackbody_hex.483 set value "#FFE0C7"
data modify storage terf:constants blackbody_hex.484 set value "#FFE0C8"
data modify storage terf:constants blackbody_hex.485 set value "#FFE0C8"
data modify storage terf:constants blackbody_hex.486 set value "#FFE1C8"
data modify storage terf:constants blackbody_hex.487 set value "#FFE1C9"
data modify storage terf:constants blackbody_hex.488 set value "#FFE1C9"
data modify storage terf:constants blackbody_hex.489 set value "#FFE1CA"
data modify storage terf:constants blackbody_hex.490 set value "#FFE2CA"
data modify storage terf:constants blackbody_hex.491 set value "#FFE2CA"
data modify storage terf:constants blackbody_hex.492 set value "#FFE2CB"
data modify storage terf:constants blackbody_hex.493 set value "#FFE2CB"
data modify storage terf:constants blackbody_hex.494 set value "#FFE2CB"
data modify storage terf:constants blackbody_hex.495 set value "#FFE3CC"
data modify storage terf:constants blackbody_hex.496 set value "#FFE3CC"
data modify storage terf:constants blackbody_hex.497 set value "#FFE3CC"
data modify storage terf:constants blackbody_hex.498 set value "#FFE3CD"
data modify storage terf:constants blackbody_hex.499 set value "#FFE3CD"
data modify storage terf:constants blackbody_hex.500 set value "#FFE4CD"
data modify storage terf:constants blackbody_hex.501 set value "#FFE4CE"
data modify storage terf:constants blackbody_hex.502 set value "#FFE4CE"
data modify storage terf:constants blackbody_hex.503 set value "#FFE4CE"
data modify storage terf:constants blackbody_hex.504 set value "#FFE4CF"
data modify storage terf:constants blackbody_hex.505 set value "#FFE5CF"
data modify storage terf:constants blackbody_hex.506 set value "#FFE5CF"
data modify storage terf:constants blackbody_hex.507 set value "#FFE5D0"
data modify storage terf:constants blackbody_hex.508 set value "#FFE5D0"
data modify storage terf:constants blackbody_hex.509 set value "#FFE5D1"
data modify storage terf:constants blackbody_hex.510 set value "#FFE5D1"
data modify storage terf:constants blackbody_hex.511 set value "#FFE6D1"
data modify storage terf:constants blackbody_hex.512 set value "#FFE6D2"
data modify storage terf:constants blackbody_hex.513 set value "#FFE6D2"
data modify storage terf:constants blackbody_hex.514 set value "#FFE6D2"
data modify storage terf:constants blackbody_hex.515 set value "#FFE6D3"
data modify storage terf:constants blackbody_hex.516 set value "#FFE7D3"
data modify storage terf:constants blackbody_hex.517 set value "#FFE7D3"
data modify storage terf:constants blackbody_hex.518 set value "#FFE7D4"
data modify storage terf:constants blackbody_hex.519 set value "#FFE7D4"
data modify storage terf:constants blackbody_hex.520 set value "#FFE7D4"
data modify storage terf:constants blackbody_hex.521 set value "#FFE8D5"
data modify storage terf:constants blackbody_hex.522 set value "#FFE8D5"
data modify storage terf:constants blackbody_hex.523 set value "#FFE8D5"
data modify storage terf:constants blackbody_hex.524 set value "#FFE8D6"
data modify storage terf:constants blackbody_hex.525 set value "#FFE8D6"
data modify storage terf:constants blackbody_hex.526 set value "#FFE9D6"
data modify storage terf:constants blackbody_hex.527 set value "#FFE9D6"
data modify storage terf:constants blackbody_hex.528 set value "#FFE9D7"
data modify storage terf:constants blackbody_hex.529 set value "#FFE9D7"
data modify storage terf:constants blackbody_hex.530 set value "#FFE9D7"
data modify storage terf:constants blackbody_hex.531 set value "#FFE9D8"
data modify storage terf:constants blackbody_hex.532 set value "#FFEAD8"
data modify storage terf:constants blackbody_hex.533 set value "#FFEAD8"
data modify storage terf:constants blackbody_hex.534 set value "#FFEAD9"
data modify storage terf:constants blackbody_hex.535 set value "#FFEAD9"
data modify storage terf:constants blackbody_hex.536 set value "#FFEAD9"
data modify storage terf:constants blackbody_hex.537 set value "#FFEBDA"
data modify storage terf:constants blackbody_hex.538 set value "#FFEBDA"
data modify storage terf:constants blackbody_hex.539 set value "#FFEBDA"
data modify storage terf:constants blackbody_hex.540 set value "#FFEBDB"
data modify storage terf:constants blackbody_hex.541 set value "#FFEBDB"
data modify storage terf:constants blackbody_hex.542 set value "#FFECDB"
data modify storage terf:constants blackbody_hex.543 set value "#FFECDC"
data modify storage terf:constants blackbody_hex.544 set value "#FFECDC"
data modify storage terf:constants blackbody_hex.545 set value "#FFECDC"
data modify storage terf:constants blackbody_hex.546 set value "#FFECDD"
data modify storage terf:constants blackbody_hex.547 set value "#FFECDD"
data modify storage terf:constants blackbody_hex.548 set value "#FFEDDD"
data modify storage terf:constants blackbody_hex.549 set value "#FFEDDD"
data modify storage terf:constants blackbody_hex.550 set value "#FFEDDE"
data modify storage terf:constants blackbody_hex.551 set value "#FFEDDE"
data modify storage terf:constants blackbody_hex.552 set value "#FFEDDE"
data modify storage terf:constants blackbody_hex.553 set value "#FFEEDF"
data modify storage terf:constants blackbody_hex.554 set value "#FFEEDF"
data modify storage terf:constants blackbody_hex.555 set value "#FFEEDF"
data modify storage terf:constants blackbody_hex.556 set value "#FFEEE0"
data modify storage terf:constants blackbody_hex.557 set value "#FFEEE0"
data modify storage terf:constants blackbody_hex.558 set value "#FFEEE0"
data modify storage terf:constants blackbody_hex.559 set value "#FFEFE0"
data modify storage terf:constants blackbody_hex.560 set value "#FFEFE1"
data modify storage terf:constants blackbody_hex.561 set value "#FFEFE1"
data modify storage terf:constants blackbody_hex.562 set value "#FFEFE1"
data modify storage terf:constants blackbody_hex.563 set value "#FFEFE2"
data modify storage terf:constants blackbody_hex.564 set value "#FFEFE2"
data modify storage terf:constants blackbody_hex.565 set value "#FFF0E2"
data modify storage terf:constants blackbody_hex.566 set value "#FFF0E3"
data modify storage terf:constants blackbody_hex.567 set value "#FFF0E3"
data modify storage terf:constants blackbody_hex.568 set value "#FFF0E3"
data modify storage terf:constants blackbody_hex.569 set value "#FFF0E3"
data modify storage terf:constants blackbody_hex.570 set value "#FFF1E4"
data modify storage terf:constants blackbody_hex.571 set value "#FFF1E4"
data modify storage terf:constants blackbody_hex.572 set value "#FFF1E4"
data modify storage terf:constants blackbody_hex.573 set value "#FFF1E5"
data modify storage terf:constants blackbody_hex.574 set value "#FFF1E5"
data modify storage terf:constants blackbody_hex.575 set value "#FFF1E5"
data modify storage terf:constants blackbody_hex.576 set value "#FFF2E6"
data modify storage terf:constants blackbody_hex.577 set value "#FFF2E6"
data modify storage terf:constants blackbody_hex.578 set value "#FFF2E6"
data modify storage terf:constants blackbody_hex.579 set value "#FFF2E6"
data modify storage terf:constants blackbody_hex.580 set value "#FFF2E7"
data modify storage terf:constants blackbody_hex.581 set value "#FFF2E7"
data modify storage terf:constants blackbody_hex.582 set value "#FFF3E7"
data modify storage terf:constants blackbody_hex.583 set value "#FFF3E8"
data modify storage terf:constants blackbody_hex.584 set value "#FFF3E8"
data modify storage terf:constants blackbody_hex.585 set value "#FFF3E8"
data modify storage terf:constants blackbody_hex.586 set value "#FFF3E8"
data modify storage terf:constants blackbody_hex.587 set value "#FFF3E9"
data modify storage terf:constants blackbody_hex.588 set value "#FFF4E9"
data modify storage terf:constants blackbody_hex.589 set value "#FFF4E9"
data modify storage terf:constants blackbody_hex.590 set value "#FFF4EA"
data modify storage terf:constants blackbody_hex.591 set value "#FFF4EA"
data modify storage terf:constants blackbody_hex.592 set value "#FFF4EA"
data modify storage terf:constants blackbody_hex.593 set value "#FFF4EA"
data modify storage terf:constants blackbody_hex.594 set value "#FFF5EB"
data modify storage terf:constants blackbody_hex.595 set value "#FFF5EB"
data modify storage terf:constants blackbody_hex.596 set value "#FFF5EB"
data modify storage terf:constants blackbody_hex.597 set value "#FFF5EC"
data modify storage terf:constants blackbody_hex.598 set value "#FFF5EC"
data modify storage terf:constants blackbody_hex.599 set value "#FFF5EC"
data modify storage terf:constants blackbody_hex.600 set value "#FFF6EC"
data modify storage terf:constants blackbody_hex.601 set value "#FFF6ED"
data modify storage terf:constants blackbody_hex.602 set value "#FFF6ED"
data modify storage terf:constants blackbody_hex.603 set value "#FFF6ED"
data modify storage terf:constants blackbody_hex.604 set value "#FFF6ED"
data modify storage terf:constants blackbody_hex.605 set value "#FFF6EE"
data modify storage terf:constants blackbody_hex.606 set value "#FFF7EE"
data modify storage terf:constants blackbody_hex.607 set value "#FFF7EE"
data modify storage terf:constants blackbody_hex.608 set value "#FFF7EF"
data modify storage terf:constants blackbody_hex.609 set value "#FFF7EF"
data modify storage terf:constants blackbody_hex.610 set value "#FFF7EF"
data modify storage terf:constants blackbody_hex.611 set value "#FFF7EF"
data modify storage terf:constants blackbody_hex.612 set value "#FFF8F0"
data modify storage terf:constants blackbody_hex.613 set value "#FFF8F0"
data modify storage terf:constants blackbody_hex.614 set value "#FFF8F0"
data modify storage terf:constants blackbody_hex.615 set value "#FFF8F0"
data modify storage terf:constants blackbody_hex.616 set value "#FFF8F1"
data modify storage terf:constants blackbody_hex.617 set value "#FFF8F1"
data modify storage terf:constants blackbody_hex.618 set value "#FFF9F1"
data modify storage terf:constants blackbody_hex.619 set value "#FFF9F2"
data modify storage terf:constants blackbody_hex.620 set value "#FFF9F2"
data modify storage terf:constants blackbody_hex.621 set value "#FFF9F2"
data modify storage terf:constants blackbody_hex.622 set value "#FFF9F2"
data modify storage terf:constants blackbody_hex.623 set value "#FFF9F3"
data modify storage terf:constants blackbody_hex.624 set value "#FFFAF3"
data modify storage terf:constants blackbody_hex.625 set value "#FFFAF3"
data modify storage terf:constants blackbody_hex.626 set value "#FFFAF3"
data modify storage terf:constants blackbody_hex.627 set value "#FFFAF4"
data modify storage terf:constants blackbody_hex.628 set value "#FFFAF4"
data modify storage terf:constants blackbody_hex.629 set value "#FFFAF4"
data modify storage terf:constants blackbody_hex.630 set value "#FFFBF4"
data modify storage terf:constants blackbody_hex.631 set value "#FFFBF5"
data modify storage terf:constants blackbody_hex.632 set value "#FFFBF5"
data modify storage terf:constants blackbody_hex.633 set value "#FFFBF5"
data modify storage terf:constants blackbody_hex.634 set value "#FFFBF5"
data modify storage terf:constants blackbody_hex.635 set value "#FFFBF6"
data modify storage terf:constants blackbody_hex.636 set value "#FFFBF6"
data modify storage terf:constants blackbody_hex.637 set value "#FFFCF6"
data modify storage terf:constants blackbody_hex.638 set value "#FFFCF6"
data modify storage terf:constants blackbody_hex.639 set value "#FFFCF7"
data modify storage terf:constants blackbody_hex.640 set value "#FFFCF7"
data modify storage terf:constants blackbody_hex.641 set value "#FFFCF7"
data modify storage terf:constants blackbody_hex.642 set value "#FFFCF8"
data modify storage terf:constants blackbody_hex.643 set value "#FFFDF8"
data modify storage terf:constants blackbody_hex.644 set value "#FFFDF8"
data modify storage terf:constants blackbody_hex.645 set value "#FFFDF8"
data modify storage terf:constants blackbody_hex.646 set value "#FFFDF9"
data modify storage terf:constants blackbody_hex.647 set value "#FFFDF9"
data modify storage terf:constants blackbody_hex.648 set value "#FFFDF9"
data modify storage terf:constants blackbody_hex.649 set value "#FFFDF9"
data modify storage terf:constants blackbody_hex.650 set value "#FFFEFA"
data modify storage terf:constants blackbody_hex.651 set value "#FFFEFA"
data modify storage terf:constants blackbody_hex.652 set value "#FFFEFA"
data modify storage terf:constants blackbody_hex.653 set value "#FFFEFA"
data modify storage terf:constants blackbody_hex.654 set value "#FFFEFB"
data modify storage terf:constants blackbody_hex.655 set value "#FFFEFB"
data modify storage terf:constants blackbody_hex.656 set value "#FFFFFB"
data modify storage terf:constants blackbody_hex.657 set value "#FFFFFB"
data modify storage terf:constants blackbody_hex.658 set value "#FFFFFC"
data modify storage terf:constants blackbody_hex.659 set value "#FFFFFC"
data modify storage terf:constants blackbody_hex.660 set value "#FFFFFF"
data modify storage terf:constants blackbody_hex.661 set value "#FFFBFF"
data modify storage terf:constants blackbody_hex.662 set value "#FFFBFF"
data modify storage terf:constants blackbody_hex.663 set value "#FFFAFF"
data modify storage terf:constants blackbody_hex.664 set value "#FFFAFF"
data modify storage terf:constants blackbody_hex.665 set value "#FFFAFF"
data modify storage terf:constants blackbody_hex.666 set value "#FFF9FF"
data modify storage terf:constants blackbody_hex.667 set value "#FFF9FF"
data modify storage terf:constants blackbody_hex.668 set value "#FFF9FF"
data modify storage terf:constants blackbody_hex.669 set value "#FEF9FF"
data modify storage terf:constants blackbody_hex.670 set value "#FEF8FF"
data modify storage terf:constants blackbody_hex.671 set value "#FDF8FF"
data modify storage terf:constants blackbody_hex.672 set value "#FDF8FF"
data modify storage terf:constants blackbody_hex.673 set value "#FCF7FF"
data modify storage terf:constants blackbody_hex.674 set value "#FCF7FF"
data modify storage terf:constants blackbody_hex.675 set value "#FCF7FF"
data modify storage terf:constants blackbody_hex.676 set value "#FBF7FF"
data modify storage terf:constants blackbody_hex.677 set value "#FBF6FF"
data modify storage terf:constants blackbody_hex.678 set value "#FAF6FF"
data modify storage terf:constants blackbody_hex.679 set value "#FAF6FF"
data modify storage terf:constants blackbody_hex.680 set value "#F9F6FF"
data modify storage terf:constants blackbody_hex.681 set value "#F9F6FF"
data modify storage terf:constants blackbody_hex.682 set value "#F9F5FF"
data modify storage terf:constants blackbody_hex.683 set value "#F8F5FF"
data modify storage terf:constants blackbody_hex.684 set value "#F8F5FF"
data modify storage terf:constants blackbody_hex.685 set value "#F7F5FF"
data modify storage terf:constants blackbody_hex.686 set value "#F7F4FF"
data modify storage terf:constants blackbody_hex.687 set value "#F7F4FF"
data modify storage terf:constants blackbody_hex.688 set value "#F6F4FF"
data modify storage terf:constants blackbody_hex.689 set value "#F6F4FF"
data modify storage terf:constants blackbody_hex.690 set value "#F6F4FF"
data modify storage terf:constants blackbody_hex.691 set value "#F5F3FF"
data modify storage terf:constants blackbody_hex.692 set value "#F5F3FF"
data modify storage terf:constants blackbody_hex.693 set value "#F4F3FF"
data modify storage terf:constants blackbody_hex.694 set value "#F4F3FF"
data modify storage terf:constants blackbody_hex.695 set value "#F4F3FF"
data modify storage terf:constants blackbody_hex.696 set value "#F3F2FF"
data modify storage terf:constants blackbody_hex.697 set value "#F3F2FF"
data modify storage terf:constants blackbody_hex.698 set value "#F3F2FF"
data modify storage terf:constants blackbody_hex.699 set value "#F2F2FF"
data modify storage terf:constants blackbody_hex.700 set value "#F2F2FF"
data modify storage terf:constants blackbody_hex.701 set value "#F2F1FF"
data modify storage terf:constants blackbody_hex.702 set value "#F1F1FF"
data modify storage terf:constants blackbody_hex.703 set value "#F1F1FF"
data modify storage terf:constants blackbody_hex.704 set value "#F1F1FF"
data modify storage terf:constants blackbody_hex.705 set value "#F1F1FF"
data modify storage terf:constants blackbody_hex.706 set value "#F0F1FF"
data modify storage terf:constants blackbody_hex.707 set value "#F0F0FF"
data modify storage terf:constants blackbody_hex.708 set value "#F0F0FF"
data modify storage terf:constants blackbody_hex.709 set value "#EFF0FF"
data modify storage terf:constants blackbody_hex.710 set value "#EFF0FF"
data modify storage terf:constants blackbody_hex.711 set value "#EFF0FF"
data modify storage terf:constants blackbody_hex.712 set value "#EEF0FF"
data modify storage terf:constants blackbody_hex.713 set value "#EEEFFF"
data modify storage terf:constants blackbody_hex.714 set value "#EEEFFF"
data modify storage terf:constants blackbody_hex.715 set value "#EEEFFF"
data modify storage terf:constants blackbody_hex.716 set value "#EDEFFF"
data modify storage terf:constants blackbody_hex.717 set value "#EDEFFF"
data modify storage terf:constants blackbody_hex.718 set value "#EDEFFF"
data modify storage terf:constants blackbody_hex.719 set value "#EDEEFF"
data modify storage terf:constants blackbody_hex.720 set value "#ECEEFF"
data modify storage terf:constants blackbody_hex.721 set value "#ECEEFF"
data modify storage terf:constants blackbody_hex.722 set value "#ECEEFF"
data modify storage terf:constants blackbody_hex.723 set value "#ECEEFF"
data modify storage terf:constants blackbody_hex.724 set value "#EBEEFF"
data modify storage terf:constants blackbody_hex.725 set value "#EBEEFF"
data modify storage terf:constants blackbody_hex.726 set value "#EBEDFF"
data modify storage terf:constants blackbody_hex.727 set value "#EBEDFF"
data modify storage terf:constants blackbody_hex.728 set value "#EAEDFF"
data modify storage terf:constants blackbody_hex.729 set value "#EAEDFF"
data modify storage terf:constants blackbody_hex.730 set value "#EAEDFF"
data modify storage terf:constants blackbody_hex.731 set value "#EAEDFF"
data modify storage terf:constants blackbody_hex.732 set value "#E9EDFF"
data modify storage terf:constants blackbody_hex.733 set value "#E9ECFF"
data modify storage terf:constants blackbody_hex.734 set value "#E9ECFF"
data modify storage terf:constants blackbody_hex.735 set value "#E9ECFF"
data modify storage terf:constants blackbody_hex.736 set value "#E8ECFF"
data modify storage terf:constants blackbody_hex.737 set value "#E8ECFF"
data modify storage terf:constants blackbody_hex.738 set value "#E8ECFF"
data modify storage terf:constants blackbody_hex.739 set value "#E8ECFF"
data modify storage terf:constants blackbody_hex.740 set value "#E7ECFF"
data modify storage terf:constants blackbody_hex.741 set value "#E7EBFF"
data modify storage terf:constants blackbody_hex.742 set value "#E7EBFF"
data modify storage terf:constants blackbody_hex.743 set value "#E7EBFF"
data modify storage terf:constants blackbody_hex.744 set value "#E7EBFF"
data modify storage terf:constants blackbody_hex.745 set value "#E6EBFF"
data modify storage terf:constants blackbody_hex.746 set value "#E6EBFF"
data modify storage terf:constants blackbody_hex.747 set value "#E6EBFF"
data modify storage terf:constants blackbody_hex.748 set value "#E6EBFF"
data modify storage terf:constants blackbody_hex.749 set value "#E6EAFF"
data modify storage terf:constants blackbody_hex.750 set value "#E5EAFF"
data modify storage terf:constants blackbody_hex.751 set value "#E5EAFF"
data modify storage terf:constants blackbody_hex.752 set value "#E5EAFF"
data modify storage terf:constants blackbody_hex.753 set value "#E5EAFF"
data modify storage terf:constants blackbody_hex.754 set value "#E5EAFF"
data modify storage terf:constants blackbody_hex.755 set value "#E4EAFF"
data modify storage terf:constants blackbody_hex.756 set value "#E4EAFF"
data modify storage terf:constants blackbody_hex.757 set value "#E4EAFF"
data modify storage terf:constants blackbody_hex.758 set value "#E4E9FF"
data modify storage terf:constants blackbody_hex.759 set value "#E4E9FF"
data modify storage terf:constants blackbody_hex.760 set value "#E3E9FF"
data modify storage terf:constants blackbody_hex.761 set value "#E3E9FF"
data modify storage terf:constants blackbody_hex.762 set value "#E3E9FF"
data modify storage terf:constants blackbody_hex.763 set value "#E3E9FF"
data modify storage terf:constants blackbody_hex.764 set value "#E3E9FF"
data modify storage terf:constants blackbody_hex.765 set value "#E2E9FF"
data modify storage terf:constants blackbody_hex.766 set value "#E2E9FF"
data modify storage terf:constants blackbody_hex.767 set value "#E2E8FF"
data modify storage terf:constants blackbody_hex.768 set value "#E2E8FF"
data modify storage terf:constants blackbody_hex.769 set value "#E2E8FF"
data modify storage terf:constants blackbody_hex.770 set value "#E2E8FF"
data modify storage terf:constants blackbody_hex.771 set value "#E1E8FF"
data modify storage terf:constants blackbody_hex.772 set value "#E1E8FF"
data modify storage terf:constants blackbody_hex.773 set value "#E1E8FF"
data modify storage terf:constants blackbody_hex.774 set value "#E1E8FF"
data modify storage terf:constants blackbody_hex.775 set value "#E1E8FF"
data modify storage terf:constants blackbody_hex.776 set value "#E1E8FF"
data modify storage terf:constants blackbody_hex.777 set value "#E0E7FF"
data modify storage terf:constants blackbody_hex.778 set value "#E0E7FF"
data modify storage terf:constants blackbody_hex.779 set value "#E0E7FF"
data modify storage terf:constants blackbody_hex.780 set value "#E0E7FF"
data modify storage terf:constants blackbody_hex.781 set value "#E0E7FF"
data modify storage terf:constants blackbody_hex.782 set value "#E0E7FF"
data modify storage terf:constants blackbody_hex.783 set value "#DFE7FF"
data modify storage terf:constants blackbody_hex.784 set value "#DFE7FF"
data modify storage terf:constants blackbody_hex.785 set value "#DFE7FF"
data modify storage terf:constants blackbody_hex.786 set value "#DFE7FF"
data modify storage terf:constants blackbody_hex.787 set value "#DFE6FF"
data modify storage terf:constants blackbody_hex.788 set value "#DFE6FF"
data modify storage terf:constants blackbody_hex.789 set value "#DEE6FF"
data modify storage terf:constants blackbody_hex.790 set value "#DEE6FF"
data modify storage terf:constants blackbody_hex.791 set value "#DEE6FF"
data modify storage terf:constants blackbody_hex.792 set value "#DEE6FF"
data modify storage terf:constants blackbody_hex.793 set value "#DEE6FF"
data modify storage terf:constants blackbody_hex.794 set value "#DEE6FF"
data modify storage terf:constants blackbody_hex.795 set value "#DDE6FF"
data modify storage terf:constants blackbody_hex.796 set value "#DDE6FF"
data modify storage terf:constants blackbody_hex.797 set value "#DDE6FF"
data modify storage terf:constants blackbody_hex.798 set value "#DDE5FF"
data modify storage terf:constants blackbody_hex.799 set value "#DDE5FF"
data modify storage terf:constants blackbody_hex.800 set value "#DDE5FF"
data modify storage terf:constants blackbody_hex.801 set value "#DDE5FF"
data modify storage terf:constants blackbody_hex.802 set value "#DCE5FF"
data modify storage terf:constants blackbody_hex.803 set value "#DCE5FF"
data modify storage terf:constants blackbody_hex.804 set value "#DCE5FF"
data modify storage terf:constants blackbody_hex.805 set value "#DCE5FF"
data modify storage terf:constants blackbody_hex.806 set value "#DCE5FF"
data modify storage terf:constants blackbody_hex.807 set value "#DCE5FF"
data modify storage terf:constants blackbody_hex.808 set value "#DCE5FF"
data modify storage terf:constants blackbody_hex.809 set value "#DBE5FF"
data modify storage terf:constants blackbody_hex.810 set value "#DBE4FF"
data modify storage terf:constants blackbody_hex.811 set value "#DBE4FF"
data modify storage terf:constants blackbody_hex.812 set value "#DBE4FF"
data modify storage terf:constants blackbody_hex.813 set value "#DBE4FF"
data modify storage terf:constants blackbody_hex.814 set value "#DBE4FF"
data modify storage terf:constants blackbody_hex.815 set value "#DBE4FF"
data modify storage terf:constants blackbody_hex.816 set value "#DAE4FF"
data modify storage terf:constants blackbody_hex.817 set value "#DAE4FF"
data modify storage terf:constants blackbody_hex.818 set value "#DAE4FF"
data modify storage terf:constants blackbody_hex.819 set value "#DAE4FF"
data modify storage terf:constants blackbody_hex.820 set value "#DAE4FF"
data modify storage terf:constants blackbody_hex.821 set value "#DAE4FF"
data modify storage terf:constants blackbody_hex.822 set value "#DAE3FF"
data modify storage terf:constants blackbody_hex.823 set value "#DAE3FF"
data modify storage terf:constants blackbody_hex.824 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.825 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.826 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.827 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.828 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.829 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.830 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.831 set value "#D9E3FF"
data modify storage terf:constants blackbody_hex.832 set value "#D8E3FF"
data modify storage terf:constants blackbody_hex.833 set value "#D8E3FF"
data modify storage terf:constants blackbody_hex.834 set value "#D8E3FF"
data modify storage terf:constants blackbody_hex.835 set value "#D8E3FF"
data modify storage terf:constants blackbody_hex.836 set value "#D8E2FF"
data modify storage terf:constants blackbody_hex.837 set value "#D8E2FF"
data modify storage terf:constants blackbody_hex.838 set value "#D8E2FF"
data modify storage terf:constants blackbody_hex.839 set value "#D8E2FF"
data modify storage terf:constants blackbody_hex.840 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.841 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.842 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.843 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.844 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.845 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.846 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.847 set value "#D7E2FF"
data modify storage terf:constants blackbody_hex.848 set value "#D6E2FF"
data modify storage terf:constants blackbody_hex.849 set value "#D6E2FF"
data modify storage terf:constants blackbody_hex.850 set value "#D6E1FF"
data modify storage terf:constants blackbody_hex.851 set value "#D6E1FF"
data modify storage terf:constants blackbody_hex.852 set value "#D6E1FF"
data modify storage terf:constants blackbody_hex.853 set value "#D6E1FF"
data modify storage terf:constants blackbody_hex.854 set value "#D6E1FF"
data modify storage terf:constants blackbody_hex.855 set value "#D6E1FF"
data modify storage terf:constants blackbody_hex.856 set value "#D6E1FF"
data modify storage terf:constants blackbody_hex.857 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.858 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.859 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.860 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.861 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.862 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.863 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.864 set value "#D5E1FF"
data modify storage terf:constants blackbody_hex.865 set value "#D5E0FF"
data modify storage terf:constants blackbody_hex.866 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.867 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.868 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.869 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.870 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.871 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.872 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.873 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.874 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.875 set value "#D4E0FF"
data modify storage terf:constants blackbody_hex.876 set value "#D3E0FF"
data modify storage terf:constants blackbody_hex.877 set value "#D3E0FF"
data modify storage terf:constants blackbody_hex.878 set value "#D3E0FF"
data modify storage terf:constants blackbody_hex.879 set value "#D3E0FF"
data modify storage terf:constants blackbody_hex.880 set value "#D3E0FF"
data modify storage terf:constants blackbody_hex.881 set value "#D3DFFF"
data modify storage terf:constants blackbody_hex.882 set value "#D3DFFF"
data modify storage terf:constants blackbody_hex.883 set value "#D3DFFF"
data modify storage terf:constants blackbody_hex.884 set value "#D3DFFF"
data modify storage terf:constants blackbody_hex.885 set value "#D3DFFF"
data modify storage terf:constants blackbody_hex.886 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.887 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.888 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.889 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.890 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.891 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.892 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.893 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.894 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.895 set value "#D2DFFF"
data modify storage terf:constants blackbody_hex.896 set value "#D1DFFF"
data modify storage terf:constants blackbody_hex.897 set value "#D1DFFF"
data modify storage terf:constants blackbody_hex.898 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.899 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.900 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.901 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.902 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.903 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.904 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.905 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.906 set value "#D1DEFF"
data modify storage terf:constants blackbody_hex.907 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.908 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.909 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.910 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.911 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.912 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.913 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.914 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.915 set value "#D0DEFF"
data modify storage terf:constants blackbody_hex.916 set value "#D0DDFF"
data modify storage terf:constants blackbody_hex.917 set value "#D0DDFF"
data modify storage terf:constants blackbody_hex.918 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.919 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.920 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.921 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.922 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.923 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.924 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.925 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.926 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.927 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.928 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.929 set value "#CFDDFF"
data modify storage terf:constants blackbody_hex.930 set value "#CEDDFF"
data modify storage terf:constants blackbody_hex.931 set value "#CEDDFF"
data modify storage terf:constants blackbody_hex.932 set value "#CEDDFF"
data modify storage terf:constants blackbody_hex.933 set value "#CEDDFF"
data modify storage terf:constants blackbody_hex.934 set value "#CEDDFF"
data modify storage terf:constants blackbody_hex.935 set value "#CEDDFF"
data modify storage terf:constants blackbody_hex.936 set value "#CEDCFF"
data modify storage terf:constants blackbody_hex.937 set value "#CEDCFF"
data modify storage terf:constants blackbody_hex.938 set value "#CEDCFF"
data modify storage terf:constants blackbody_hex.939 set value "#CEDCFF"
data modify storage terf:constants blackbody_hex.940 set value "#CEDCFF"
data modify storage terf:constants blackbody_hex.941 set value "#CEDCFF"
data modify storage terf:constants blackbody_hex.942 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.943 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.944 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.945 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.946 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.947 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.948 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.949 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.950 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.951 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.952 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.953 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.954 set value "#CDDCFF"
data modify storage terf:constants blackbody_hex.955 set value "#CCDCFF"
data modify storage terf:constants blackbody_hex.956 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.957 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.958 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.959 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.960 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.961 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.962 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.963 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.964 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.965 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.966 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.967 set value "#CCDBFF"
data modify storage terf:constants blackbody_hex.968 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.969 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.970 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.971 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.972 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.973 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.974 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.975 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.976 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.977 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.978 set value "#CBDBFF"
data modify storage terf:constants blackbody_hex.979 set value "#CBDAFF"
data modify storage terf:constants blackbody_hex.980 set value "#CBDAFF"
data modify storage terf:constants blackbody_hex.981 set value "#CBDAFF"
data modify storage terf:constants blackbody_hex.982 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.983 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.984 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.985 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.986 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.987 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.988 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.989 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.990 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.991 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.992 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.993 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.994 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.995 set value "#CADAFF"
data modify storage terf:constants blackbody_hex.996 set value "#C9DAFF"
data modify storage terf:constants blackbody_hex.997 set value "#C9DAFF"
data modify storage terf:constants blackbody_hex.998 set value "#C9DAFF"
data modify storage terf:constants blackbody_hex.999 set value "#C9DAFF"
data modify storage terf:constants blackbody_hex.1000 set value "#C9DAFF"
data modify storage terf:constants blackbody_hex.1001 set value "#C9DAFF"
data modify storage terf:constants blackbody_hex.1002 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1003 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1004 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1005 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1006 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1007 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1008 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1009 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1010 set value "#C9D9FF"
data modify storage terf:constants blackbody_hex.1011 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1012 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1013 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1014 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1015 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1016 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1017 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1018 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1019 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1020 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1021 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1022 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1023 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1024 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1025 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1026 set value "#C8D9FF"
data modify storage terf:constants blackbody_hex.1027 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1028 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1029 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1030 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1031 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1032 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1033 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1034 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1035 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1036 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1037 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1038 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1039 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1040 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1041 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1042 set value "#C7D8FF"
data modify storage terf:constants blackbody_hex.1043 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1044 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1045 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1046 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1047 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1048 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1049 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1050 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1051 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1052 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1053 set value "#C6D8FF"
data modify storage terf:constants blackbody_hex.1054 set value "#C6D7FF"
data modify storage terf:constants blackbody_hex.1055 set value "#C6D7FF"
data modify storage terf:constants blackbody_hex.1056 set value "#C6D7FF"
data modify storage terf:constants blackbody_hex.1057 set value "#C6D7FF"
data modify storage terf:constants blackbody_hex.1058 set value "#C6D7FF"
data modify storage terf:constants blackbody_hex.1059 set value "#C6D7FF"
data modify storage terf:constants blackbody_hex.1060 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1061 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1062 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1063 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1064 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1065 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1066 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1067 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1068 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1069 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1070 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1071 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1072 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1073 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1074 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1075 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1076 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1077 set value "#C5D7FF"
data modify storage terf:constants blackbody_hex.1078 set value "#C4D7FF"
data modify storage terf:constants blackbody_hex.1079 set value "#C4D7FF"
data modify storage terf:constants blackbody_hex.1080 set value "#C4D7FF"
data modify storage terf:constants blackbody_hex.1081 set value "#C4D7FF"
data modify storage terf:constants blackbody_hex.1082 set value "#C4D7FF"
data modify storage terf:constants blackbody_hex.1083 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1084 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1085 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1086 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1087 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1088 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1089 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1090 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1091 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1092 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1093 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1094 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1095 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1096 set value "#C4D6FF"
data modify storage terf:constants blackbody_hex.1097 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1098 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1099 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1100 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1101 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1102 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1103 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1104 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1105 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1106 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1107 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1108 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1109 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1110 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1111 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1112 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1113 set value "#C3D6FF"
data modify storage terf:constants blackbody_hex.1114 set value "#C3D5FF"
data modify storage terf:constants blackbody_hex.1115 set value "#C3D5FF"
data modify storage terf:constants blackbody_hex.1116 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1117 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1118 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1119 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1120 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1121 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1122 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1123 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1124 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1125 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1126 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1127 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1128 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1129 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1130 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1131 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1132 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1133 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1134 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1135 set value "#C2D5FF"
data modify storage terf:constants blackbody_hex.1136 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1137 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1138 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1139 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1140 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1141 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1142 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1143 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1144 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1145 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1146 set value "#C1D5FF"
data modify storage terf:constants blackbody_hex.1147 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1148 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1149 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1150 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1151 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1152 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1153 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1154 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1155 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1156 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1157 set value "#C1D4FF"
data modify storage terf:constants blackbody_hex.1158 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1159 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1160 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1161 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1162 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1163 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1164 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1165 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1166 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1167 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1168 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1169 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1170 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1171 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1172 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1173 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1174 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1175 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1176 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1177 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1178 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1179 set value "#C0D4FF"
data modify storage terf:constants blackbody_hex.1180 set value "#BFD4FF"
data modify storage terf:constants blackbody_hex.1181 set value "#BFD4FF"
data modify storage terf:constants blackbody_hex.1182 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1183 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1184 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1185 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1186 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1187 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1188 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1189 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1190 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1191 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1192 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1193 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1194 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1195 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1196 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1197 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1198 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1199 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1200 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1201 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1202 set value "#BFD3FF"
data modify storage terf:constants blackbody_hex.1203 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1204 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1205 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1206 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1207 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1208 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1209 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1210 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1211 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1212 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1213 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1214 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1215 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1216 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1217 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1218 set value "#BED3FF"
data modify storage terf:constants blackbody_hex.1219 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1220 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1221 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1222 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1223 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1224 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1225 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1226 set value "#BED2FF"
data modify storage terf:constants blackbody_hex.1227 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1228 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1229 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1230 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1231 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1232 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1233 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1234 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1235 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1236 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1237 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1238 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1239 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1240 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1241 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1242 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1243 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1244 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1245 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1246 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1247 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1248 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1249 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1250 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1251 set value "#BDD2FF"
data modify storage terf:constants blackbody_hex.1252 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1253 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1254 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1255 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1256 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1257 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1258 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1259 set value "#BCD2FF"
data modify storage terf:constants blackbody_hex.1260 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1261 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1262 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1263 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1264 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1265 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1266 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1267 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1268 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1269 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1270 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1271 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1272 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1273 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1274 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1275 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1276 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1277 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1278 set value "#BCD1FF"
data modify storage terf:constants blackbody_hex.1279 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1280 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1281 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1282 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1283 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1284 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1285 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1286 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1287 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1288 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1289 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1290 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1291 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1292 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1293 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1294 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1295 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1296 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1297 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1298 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1299 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1300 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1301 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1302 set value "#BBD1FF"
data modify storage terf:constants blackbody_hex.1303 set value "#BBD0FF"
data modify storage terf:constants blackbody_hex.1304 set value "#BBD0FF"
data modify storage terf:constants blackbody_hex.1305 set value "#BBD0FF"
data modify storage terf:constants blackbody_hex.1306 set value "#BBD0FF"
data modify storage terf:constants blackbody_hex.1307 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1308 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1309 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1310 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1311 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1312 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1313 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1314 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1315 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1316 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1317 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1318 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1319 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1320 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1321 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1322 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1323 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1324 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1325 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1326 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1327 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1328 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1329 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1330 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1331 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1332 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1333 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1334 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1335 set value "#BAD0FF"
data modify storage terf:constants blackbody_hex.1336 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1337 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1338 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1339 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1340 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1341 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1342 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1343 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1344 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1345 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1346 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1347 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1348 set value "#B9D0FF"
data modify storage terf:constants blackbody_hex.1349 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1350 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1351 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1352 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1353 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1354 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1355 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1356 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1357 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1358 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1359 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1360 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1361 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1362 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1363 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1364 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1365 set value "#B9CFFF"
data modify storage terf:constants blackbody_hex.1366 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1367 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1368 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1369 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1370 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1371 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1372 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1373 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1374 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1375 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1376 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1377 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1378 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1379 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1380 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1381 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1382 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1383 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1384 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1385 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1386 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1387 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1388 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1389 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1390 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1391 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1392 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1393 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1394 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1395 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1396 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1397 set value "#B8CFFF"
data modify storage terf:constants blackbody_hex.1398 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1399 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1400 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1401 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1402 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1403 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1404 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1405 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1406 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1407 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1408 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1409 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1410 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1411 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1412 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1413 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1414 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1415 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1416 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1417 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1418 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1419 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1420 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1421 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1422 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1423 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1424 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1425 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1426 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1427 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1428 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1429 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1430 set value "#B7CEFF"
data modify storage terf:constants blackbody_hex.1431 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1432 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1433 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1434 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1435 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1436 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1437 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1438 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1439 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1440 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1441 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1442 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1443 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1444 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1445 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1446 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1447 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1448 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1449 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1450 set value "#B6CEFF"
data modify storage terf:constants blackbody_hex.1451 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1452 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1453 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1454 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1455 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1456 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1457 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1458 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1459 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1460 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1461 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1462 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1463 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1464 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1465 set value "#B6CDFF"
data modify storage terf:constants blackbody_hex.1466 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1467 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1468 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1469 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1470 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1471 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1472 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1473 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1474 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1475 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1476 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1477 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1478 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1479 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1480 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1481 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1482 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1483 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1484 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1485 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1486 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1487 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1488 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1489 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1490 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1491 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1492 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1493 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1494 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1495 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1496 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1497 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1498 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1499 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1500 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1501 set value "#B5CDFF"
data modify storage terf:constants blackbody_hex.1502 set value "#B4CDFF"
data modify storage terf:constants blackbody_hex.1503 set value "#B4CDFF"
data modify storage terf:constants blackbody_hex.1504 set value "#B4CDFF"
data modify storage terf:constants blackbody_hex.1505 set value "#B4CDFF"
data modify storage terf:constants blackbody_hex.1506 set value "#B4CDFF"
data modify storage terf:constants blackbody_hex.1507 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1508 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1509 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1510 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1511 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1512 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1513 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1514 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1515 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1516 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1517 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1518 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1519 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1520 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1521 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1522 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1523 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1524 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1525 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1526 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1527 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1528 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1529 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1530 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1531 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1532 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1533 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1534 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1535 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1536 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1537 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1538 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1539 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1540 set value "#B4CCFF"
data modify storage terf:constants blackbody_hex.1541 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1542 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1543 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1544 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1545 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1546 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1547 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1548 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1549 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1550 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1551 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1552 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1553 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1554 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1555 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1556 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1557 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1558 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1559 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1560 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1561 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1562 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1563 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1564 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1565 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1566 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1567 set value "#B3CCFF"
data modify storage terf:constants blackbody_hex.1568 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1569 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1570 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1571 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1572 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1573 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1574 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1575 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1576 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1577 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1578 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1579 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1580 set value "#B3CBFF"
data modify storage terf:constants blackbody_hex.1581 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1582 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1583 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1584 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1585 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1586 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1587 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1588 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1589 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1590 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1591 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1592 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1593 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1594 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1595 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1596 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1597 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1598 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1599 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1600 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1601 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1602 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1603 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1604 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1605 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1606 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1607 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1608 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1609 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1610 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1611 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1612 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1613 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1614 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1615 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1616 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1617 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1618 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1619 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1620 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1621 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1622 set value "#B2CBFF"
data modify storage terf:constants blackbody_hex.1623 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1624 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1625 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1626 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1627 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1628 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1629 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1630 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1631 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1632 set value "#B1CBFF"
data modify storage terf:constants blackbody_hex.1633 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1634 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1635 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1636 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1637 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1638 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1639 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1640 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1641 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1642 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1643 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1644 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1645 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1646 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1647 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1648 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1649 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1650 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1651 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1652 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1653 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1654 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1655 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1656 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1657 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1658 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1659 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1660 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1661 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1662 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1663 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1664 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1665 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1666 set value "#B1CAFF"
data modify storage terf:constants blackbody_hex.1667 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1668 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1669 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1670 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1671 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1672 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1673 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1674 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1675 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1676 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1677 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1678 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1679 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1680 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1681 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1682 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1683 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1684 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1685 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1686 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1687 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1688 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1689 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1690 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1691 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1692 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1693 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1694 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1695 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1696 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1697 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1698 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1699 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1700 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1701 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1702 set value "#B0CAFF"
data modify storage terf:constants blackbody_hex.1703 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1704 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1705 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1706 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1707 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1708 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1709 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1710 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1711 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1712 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1713 set value "#B0C9FF"
data modify storage terf:constants blackbody_hex.1714 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1715 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1716 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1717 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1718 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1719 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1720 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1721 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1722 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1723 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1724 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1725 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1726 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1727 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1728 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1729 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1730 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1731 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1732 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1733 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1734 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1735 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1736 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1737 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1738 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1739 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1740 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1741 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1742 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1743 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1744 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1745 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1746 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1747 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1748 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1749 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1750 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1751 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1752 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1753 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1754 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1755 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1756 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1757 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1758 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1759 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1760 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1761 set value "#AFC9FF"
data modify storage terf:constants blackbody_hex.1762 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1763 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1764 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1765 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1766 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1767 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1768 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1769 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1770 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1771 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1772 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1773 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1774 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1775 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1776 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1777 set value "#AEC9FF"
data modify storage terf:constants blackbody_hex.1778 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1779 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1780 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1781 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1782 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1783 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1784 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1785 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1786 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1787 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1788 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1789 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1790 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1791 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1792 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1793 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1794 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1795 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1796 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1797 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1798 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1799 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1800 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1801 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1802 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1803 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1804 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1805 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1806 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1807 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1808 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1809 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1810 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1811 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1812 set value "#AEC8FF"
data modify storage terf:constants blackbody_hex.1813 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1814 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1815 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1816 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1817 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1818 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1819 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1820 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1821 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1822 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1823 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1824 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1825 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1826 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1827 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1828 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1829 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1830 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1831 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1832 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1833 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1834 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1835 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1836 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1837 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1838 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1839 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1840 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1841 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1842 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1843 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1844 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1845 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1846 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1847 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1848 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1849 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1850 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1851 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1852 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1853 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1854 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1855 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1856 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1857 set value "#ADC8FF"
data modify storage terf:constants blackbody_hex.1858 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1859 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1860 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1861 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1862 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1863 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1864 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1865 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1866 set value "#ADC7FF"
data modify storage terf:constants blackbody_hex.1867 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1868 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1869 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1870 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1871 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1872 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1873 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1874 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1875 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1876 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1877 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1878 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1879 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1880 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1881 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1882 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1883 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1884 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1885 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1886 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1887 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1888 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1889 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1890 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1891 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1892 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1893 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1894 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1895 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1896 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1897 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1898 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1899 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1900 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1901 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1902 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1903 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1904 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1905 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1906 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1907 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1908 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1909 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1910 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1911 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1912 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1913 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1914 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1915 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1916 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1917 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1918 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1919 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1920 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1921 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1922 set value "#ACC7FF"
data modify storage terf:constants blackbody_hex.1923 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1924 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1925 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1926 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1927 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1928 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1929 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1930 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1931 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1932 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1933 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1934 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1935 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1936 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1937 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1938 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1939 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1940 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1941 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1942 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1943 set value "#ABC7FF"
data modify storage terf:constants blackbody_hex.1944 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1945 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1946 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1947 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1948 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1949 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1950 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1951 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1952 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1953 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1954 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1955 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1956 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1957 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1958 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1959 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1960 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1961 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1962 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1963 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1964 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1965 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1966 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1967 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1968 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1969 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1970 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1971 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1972 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1973 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1974 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1975 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1976 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1977 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1978 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1979 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1980 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1981 set value "#ABC6FF"
data modify storage terf:constants blackbody_hex.1982 set value "#AAC6FF"

#true dye colors
data modify storage terf:constants dye_colors.minecraft:white_dye set value {true:{rgb:[255,255,255],hex:"#FFFFFF"},vivid:{rgb:[255,255,255],hex:"#FFFFFF"}}
data modify storage terf:constants dye_colors.minecraft:light_gray_dye set value {true:{rgb:[211,211,211],hex:"#D3D3D3"},vivid:{rgb:[170,170,170],hex:"#AAAAAA"}}
data modify storage terf:constants dye_colors.minecraft:gray_dye set value {true:{rgb:[128,128,128],hex:"#808080"},vivid:{rgb:[85,85,85],hex:"#555555"}}
data modify storage terf:constants dye_colors.minecraft:black_dye set value {true:{rgb:[0,0,0],hex:"#000000"},vivid:{rgb:[0,0,0],hex:"#000000"}}
data modify storage terf:constants dye_colors.minecraft:brown_dye set value {true:{rgb:[139,69,19],hex:"#8B4513"},vivid:{rgb:[128,64,0],hex:"#804000"}}
data modify storage terf:constants dye_colors.minecraft:red_dye set value {true:{rgb:[255,85,85],hex:"#FF5555"},vivid:{rgb:[255,0,0],hex:"#FF0000"}}
data modify storage terf:constants dye_colors.minecraft:orange_dye set value {true:{rgb:[255,170,0],hex:"#FFAA00"},vivid:{rgb:[255,128,0],hex:"#FF8800"}}
data modify storage terf:constants dye_colors.minecraft:yellow_dye set value {true:{rgb:[255,255,85],hex:"#FFFF55"},vivid:{rgb:[255,255,0],hex:"#FFFF00"}}
data modify storage terf:constants dye_colors.minecraft:lime_dye set value {true:{rgb:[85,255,85],hex:"#55FF55"},vivid:{rgb:[0,255,0],hex:"#00FF00"}}
data modify storage terf:constants dye_colors.minecraft:green_dye set value {true:{rgb:[0,170,0],hex:"#00AA00"},vivid:{rgb:[0,128,0],hex:"#008800"}}
data modify storage terf:constants dye_colors.minecraft:cyan_dye set value {true:{rgb:[85,255,255],hex:"#55FFFF"},vivid:{rgb:[0,255,190],hex:"#00FFBE"}}
data modify storage terf:constants dye_colors.minecraft:light_blue_dye set value {true:{rgb:[58,179,218],hex:"#3AB3DA"},vivid:{rgb:[0,255,255],hex:"#00FFFF"}}
data modify storage terf:constants dye_colors.minecraft:blue_dye set value {true:{rgb:[60,68,170],hex:"#3C44AA"},vivid:{rgb:[0,0,255],hex:"#0000FF"}}
data modify storage terf:constants dye_colors.minecraft:purple_dye set value {true:{rgb:[137,50,184],hex:"#8932B8"},vivid:{rgb:[128,0,255],hex:"#8800FF"}}
data modify storage terf:constants dye_colors.minecraft:magenta_dye set value {true:{rgb:[199,78,189],hex:"#C74EBD"},vivid:{rgb:[255,0,255],hex:"#FF00FF"}}
data modify storage terf:constants dye_colors.minecraft:pink_dye set value {true:{rgb:[243,139,170],hex:"#F38BAA"},vivid:{rgb:[255,128,255],hex:"#FF88FF"}}

#broadcast loaded message
execute unless score no_load_message terf_states matches 1 run tellraw @a [{"text":"["},{"text":"S","color":"red"},{"text":"Y","color":"gold"},{"text":"S","color":"yellow"},{"text":"T","color":"green"},{"text":"E","color":"aqua"},{"text":"M","color":"green"},{"text":"] TERF Datapack Loaded!"}]
