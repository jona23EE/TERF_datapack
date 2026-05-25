#discord integration
execute unless dimension minecraft:overworld run return fail
execute unless score oldmapadditions_installed terfmap_states matches 1 run return fail

#clean up text
$data modify entity 0010ccd2-0010-cd37-0010-cd360010c8e1 CustomName set value $(text_components)
data modify entity 0010effb-0010-ccd3-0010-f0550010cd2c text set from entity 0010ccd2-0010-cd37-0010-cd360010c8e1 CustomName

data modify storage terf:temp args set value {arg1:'data modify storage terf:temp temp set value  '}
data modify storage terf:temp args.arg2 set from entity 0010effb-0010-ccd3-0010-f0550010cd2c text
function datapipes_lib:require/with_args/2 with storage terf:temp args
#always remember to reset the text of this after using it
data modify entity 0010effb-0010-ccd3-0010-f0550010cd2c text set value ""

data modify storage terf:temp args.output set from storage terf:temp temp.text
data modify storage terf:temp array set from storage terf:temp temp.extra
function terf:require/discord_integration/iterate

data modify storage terf:temp args.arg1 set value 'data modify storage terf:temp args.output set value '
data modify storage terf:temp args.arg2 set from storage terf:temp args.output
function datapipes_lib:require/with_args/2 with storage terf:temp args

$data modify storage terf:temp args.arg1 set value 'discordsrv broadcast $(prefix)'
data modify storage terf:temp args.arg2 set from storage terf:temp args.output
function datapipes_lib:require/with_args/2 with storage terf:temp args