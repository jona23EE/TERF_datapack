execute if score @s terf_data_A matches 1.. run return fail

## Check button
execute unless block ^-2 ^ ^5 polished_blackstone_button[powered=true] run return fail
execute positioned ^-2 ^ ^5 run function terf:require/turn_off_blackstone_button

## Fail if mainframe is not connected
execute unless score @s terf_connected_mainframe = @s terf_connected_mainframe run return run data merge block ^-2 ^1 ^5 {front_text:{messages:["",{"text":"No Signal","bold":true,"color":"red"},{"text":"||||||||||||||||||||||||","bold":true,"color":"red"},""],has_glowing_text:1b,color:"orange"},is_waxed:1b}

## Fail if body is broken
execute unless function terf:entity/machines/assembler/structure_checks/is_body_valid run return run data merge block ^-2 ^1 ^5 {front_text:{has_glowing_text:1b,messages:[{text:"    Assembler    ",color:"yellow",underlined:1b},"",{text:"Assembler Body",color:red},{text:"Broken!",color:red}],has_glowing_text:1b,color:"yellow"},is_waxed:1b}

## Fail if platform is broken
execute unless function terf:entity/machines/assembler/structure_checks/is_platform_valid run return run data merge block ^-2 ^1 ^5 {front_text:{has_glowing_text:1b,messages:[{text:"    Assembler    ",color:"yellow",underlined:1b},"",{text:"Assembler",color:red},{text:"Platform Broken!",color:red}],has_glowing_text:1b,color:"yellow"},is_waxed:1b}

## Check for recipe
data merge block ^-2 ^1 ^5 {front_text:{has_glowing_text:1b,messages:[{text:"    Assembler    ",color:"yellow",underlined:1b},"",{text:"Ready",color:green},""]},is_waxed:1b}

execute positioned ^-2 ^ ^4 run function datapipes_lib:item_transfer/count_items/start

data modify storage terf:temp array set from storage terf:constants recipes.assembler
function terf:entity/machines/assembler/checks_iterate