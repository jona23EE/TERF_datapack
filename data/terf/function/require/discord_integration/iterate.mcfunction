data modify storage terf:temp args.string set from storage terf:temp array[0]
data modify storage terf:temp args.string set from storage terf:temp array[0].text
function terf:require/discord_integration/add_string with storage terf:temp args
data remove storage terf:temp array[0]
execute if data storage terf:temp array[0] run function terf:require/discord_integration/iterate