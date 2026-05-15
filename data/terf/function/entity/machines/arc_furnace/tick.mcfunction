#terf_data_A = cooldown
execute unless score @s datapipes_lib_power_storage matches 16.. run return run scoreboard players set @s terf_data_A 0

execute if score NETratetimer terf_states >= NETrate terf_states run tag @s remove terf_arcfurnacecase
execute if score NETratetimer terf_states >= NETrate terf_states if block ^ ^ ^1 waxed_oxidized_cut_copper_stairs if block ^ ^1 ^1 waxed_oxidized_cut_copper_slab if block ^ ^2 ^1 waxed_oxidized_cut_copper_stairs if block ^1 ^ ^1 waxed_oxidized_cut_copper if block ^1 ^1 ^1 waxed_oxidized_cut_copper if block ^1 ^2 ^1 waxed_oxidized_cut_copper if block ^-1 ^ ^1 waxed_oxidized_cut_copper if block ^-1 ^1 ^1 waxed_oxidized_cut_copper if block ^-1 ^2 ^1 waxed_oxidized_cut_copper if block ^1 ^1 ^ waxed_copper_block if block ^-1 ^1 ^ waxed_copper_block if block ^ ^2 ^ waxed_copper_block if block ^ ^1 ^-1 petrified_oak_slab[type=double] if block ^1 ^2 ^ waxed_oxidized_cut_copper if block ^1 ^ ^ waxed_oxidized_cut_copper if block ^-1 ^2 ^ waxed_oxidized_cut_copper if block ^-1 ^ ^ waxed_oxidized_cut_copper run tag @s add terf_arcfurnacecase
execute as @s[tag=!terf_arcfurnacecase] run return run scoreboard players set @s terf_data_A 0

scoreboard players remove @s datapipes_lib_power_storage 16
particle minecraft:flame ^ ^1 ^ 0.2 0.2 0.2 0.01 1
execute if block ^ ^1 ^ air run return run function terf:entity/machines/arc_furnace/teleport_item

scoreboard players add @s terf_data_A 1
playsound minecraft:block.campfire.crackle master @a[distance=0..] ~ ~ ~ 1 2
particle minecraft:large_smoke ^ ^1 ^.3 0 0.2 0.2 0.1 10

execute unless score @s terf_data_A matches 200.. run return fail

scoreboard players set @s terf_data_A 0
execute if block ~ ~1 ~ magma_block run return run setblock ~ ~1 ~ lava
execute if block ~ ~1 ~ cobblestone run return run setblock ~ ~1 ~ magma_block
execute if block ~ ~1 ~ stone run return run setblock ~ ~1 ~ magma_block
execute if block ~ ~1 ~ smooth_stone run return run setblock ~ ~1 ~ deepslate
execute if block ~ ~1 ~ cobbled_deepslate run return run setblock ~ ~1 ~ gravel
execute if block ~ ~1 ~ calcite run return run setblock ~ ~1 ~ quartz_block
execute if block ~ ~1 ~ polished_deepslate run return run setblock ~ ~1 ~ basalt
execute if block ~ ~1 ~ blackstone run return run setblock ~ ~1 ~ tuff
execute if block ~ ~1 ~ raw_copper_block run return run setblock ~ ~1 ~ copper_block
execute if block ~ ~1 ~ raw_gold_block run return run setblock ~ ~1 ~ gold_block
execute if block ~ ~1 ~ raw_iron_block run return run setblock ~ ~1 ~ iron_block
execute if block ~ ~1 ~ wet_sponge run return run setblock ~ ~1 ~ sponge
execute if block ~ ~1 ~ sand run return run setblock ~ ~1 ~ glass
execute if block ~ ~1 ~ sculk_catalyst run return run setblock ~ ~1 ~ budding_amethyst
execute if block ~ ~1 ~ sculk run return run setblock ~ ~1 ~ cobweb

#recipes that return air
execute if block ~ ~1 ~ tnt positioned ^ ^1 ^ run summon tnt
execute if block ~ ~1 ~ emerald_block positioned ^ ^1 ^1 run function terf:require/custom_item_summon {count:1,id:"terf:palladium_group_metal"}
execute unless block ~ ~1 ~ #terf:indestructible run setblock ~ ~1 ~ air