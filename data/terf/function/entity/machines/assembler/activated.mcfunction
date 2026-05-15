execute store result score @s terf_data_B run data get storage terf:temp array[0].t
execute store result score @s terf_data_C run data get storage terf:temp array[0].m
data modify entity @s data.terf.s set from storage terf:temp array[0].s
data modify entity @s data.terf.z set from storage terf:temp array[0].z
data modify entity @s data.terf.n set string storage terf:temp array[0].name 0 -10
execute positioned ^-2 ^ ^4 run function datapipes_lib:item_transfer/remove_items/start

tag @s add terf_body
function terf:entity/machines/assembler/transform_on with entity @s data.terf
scoreboard players set @s terf_data_A 1
scoreboard players set @s terf_data_D 0

playsound terf:elevator_start master @a[distance=0..] ~ ~ ~ 2 0

data merge block ^-2 ^1 ^5 {front_text:{has_glowing_text:1b,messages:[{text:"    Assembler    ",color:"yellow",underlined:1b},"",{text:"Initializing...",color:green},""],has_glowing_text:1b,color:"yellow"},is_waxed:1b}