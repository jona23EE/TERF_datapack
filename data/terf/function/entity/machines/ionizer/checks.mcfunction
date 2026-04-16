#terf_data_A = progress

execute unless score @s terf_data_A = @s terf_data_A run function terf:entity/machines/ionizer/setup

tag @s remove terf_ionizer_case
execute if block ~ ~ ~ petrified_oak_slab[type=double] if block ~ ~-3 ~ granite_slab[type=double] if block ~ ~-2 ~ waxed_lightning_rod[facing=down] if block ^ ^-1 ^1 observer if block ^ ^-1 ^-1 observer if block ^1 ^-1 ^ quartz_block if block ^-1 ^-1 ^ quartz_block if block ^ ^-2 ^1 quartz_block if block ^ ^-2 ^-1 quartz_block if block ^1 ^-2 ^ quartz_block if block ^-1 ^-2 ^ quartz_block if block ^ ^-3 ^1 quartz_block if block ^ ^-3 ^-1 quartz_block if block ^1 ^-3 ^ quartz_block if block ^-1 ^-3 ^ quartz_block run tag @s add terf_ionizer_case
#if block ^1 ^-1 ^ quartz_block if block ^-1 ^-1 ^ quartz_block if block ^ ^-2 ^1 quartz_block if block ^ ^-2 ^-1 quartz_block if block ^1 ^-2 ^ quartz_block if block ^-1 ^-2 ^ quartz_block if block ^ ^-3 ^1 quartz_block if block ^ ^-3 ^-1 quartz_block if block ^1 ^-3 ^ quartz_block if block ^-1 ^-3 ^ quartz_block run tag @s add terf_ionizer_case
execute if entity @s[tag=!terf_ionizer_case] run return fail

execute store result score fluid_amount terf_states run data get entity @s data.fluids[0].amount
execute if score fluid_amount terf_states matches 0 run return fail

data modify storage terf:temp args set value {name:"ionizer",a:"z"}
data modify storage terf:temp args.a set from entity @s data.fluids[0].id

function terf:require/read_1_recipes with storage terf:temp args
execute store result score a terf_states run data get storage terf:temp output.a

execute if data storage terf:temp output.1 if score fluid_amount terf_states >= a terf_states run function terf:entity/machines/ionizer/activated with storage terf:temp output
