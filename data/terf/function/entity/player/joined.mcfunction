scoreboard players set @s terf_leftgame 0
scoreboard players add @s terf_data_L 0
scoreboard players add @s terf_data_O 0
scoreboard players add @s terf_data_J 0
scoreboard players enable @s terf_trigger
execute as @s[gamemode=!spectator,gamemode=!creative] run scoreboard players set @s terf_data_C 0
execute if score playamongusjoinsound terf_states matches 1 if score @s terf_data_C matches 0 run playsound terf:alarms.amogusjoin player @a[distance=0..] 0 0 0 999999 1
tag @s remove terf_nuke_hit
recipe give @s terf:copper_coil_stairs
recipe give @s terf:copper_coil
recipe give @s terf:hanging_screen
recipe give @s terf:high_voltage_wire
recipe give @s terf:high_voltage_conductor_slab
recipe give @s terf:high_voltage_conductor_stairs
recipe give @s terf:high_voltage_conductor_wall
recipe give @s terf:screen
recipe give @s terf:metal_plating
recipe give @s terf:asphalt
recipe give @s terf:caution_block
recipe give @s terf:entity_conveyor
recipe give @s terf:hex_plate
recipe give @s terf:vent_block
recipe give @s terf:loom_mainframe_server
recipe give @s terf:quartz
recipe give @s terf:sponge
recipe give @s terf:charcoal_from_smelting_melon
recipe give @s terf:black_dye
recipe give @s terf:ink_sac
recipe give @s terf:glow_ink_sac
recipe give @s terf:crying_obsidian
recipe give @s terf:red_sand
recipe give @s terf:waxed_oxidized_cut_copper_stairs
recipe give @s terf:waxed_oxidized_cut_copper_vertical_stairs
recipe give @s terf:control_rod_assembly
recipe give @s terf:multiblock_core
recipe give @s terf:data_cable

recipe give @s terf:blasting/exposed_copper_from_blasting
recipe give @s terf:blasting/weathered_copper_from_blasting
recipe give @s terf:blasting/oxidized_copper_from_blasting

recipe give @s terf:blasting/exposed_cut_copper_from_blasting
recipe give @s terf:blasting/weathered_cut_copper_from_blasting
recipe give @s terf:blasting/oxidized_cut_copper_from_blasting

recipe give @s terf:blasting/exposed_chiseled_copper_from_blasting
recipe give @s terf:blasting/weathered_chiseled_copper_from_blasting
recipe give @s terf:blasting/oxidized_chiseled_copper_from_blasting

recipe give @s terf:blasting/exposed_copper_grate_from_blasting
recipe give @s terf:blasting/weathered_copper_grate_from_blasting
recipe give @s terf:blasting/oxidized_copper_grate_from_blasting

recipe give @s terf:blasting/exposed_copper_bulb_from_blasting
recipe give @s terf:blasting/weathered_copper_bulb_from_blasting
recipe give @s terf:blasting/oxidized_copper_bulb_from_blasting

recipe give @s terf:blasting/exposed_copper_door_from_blasting
recipe give @s terf:blasting/weathered_copper_door_from_blasting
recipe give @s terf:blasting/oxidized_copper_door_from_blasting

recipe give @s terf:blasting/exposed_copper_trapdoor_from_blasting
recipe give @s terf:blasting/weathered_copper_trapdoor_from_blasting
recipe give @s terf:blasting/oxidized_copper_trapdoor_from_blasting

recipe give @s terf:mullermilch
recipe give @s terf:melon_slice_from_melon
recipe give @s terf:dark_prismarine_bit

advancement revoke @s only terf:internal/open_ender_chest
advancement revoke @s only terf:internal/cd_recovery_compass
advancement revoke @s only terf:internal/consume_mullermilch
advancement revoke @s only terf:internal/interact_with_villager
advancement revoke @s only terf:internal/scrape
advancement revoke @s only terf:internal/solar_panel_place_trigger
advancement revoke @s only terf:internal/mcfr_place_trigger
advancement revoke @s only terf:internal/hit_interaction
advancement revoke @s only terf:internal/click_interaction
advancement revoke @s only terf:internal/pressed_button
advancement revoke @s only terf:glitch
advancement revoke @s only terf:internal/put_book_on_lectern

scoreboard players set @s terfmap_trigger 1

#security id
scoreboard players add @s terf_scorelink 0
execute if score @s terf_scorelink matches 0 run scoreboard players add current_player_number terf_states 1
execute if score @s terf_scorelink matches 0 run scoreboard players operation @s terf_scorelink = current_player_number terf_states
