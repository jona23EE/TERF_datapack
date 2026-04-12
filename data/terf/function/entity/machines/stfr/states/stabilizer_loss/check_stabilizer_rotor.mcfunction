execute unless block ^1 ^ ^10 #terf:stfr_stabilizer_rotor_copper run return fail
execute unless block ^-1 ^ ^10 #terf:stfr_stabilizer_rotor_copper run return fail
execute unless block ^ ^1 ^10 #terf:stfr_stabilizer_rotor_copper run return fail
execute unless block ^ ^-1 ^10 #terf:stfr_stabilizer_rotor_copper run return fail

execute unless block ^1 ^ ^9 #terf:stfr_stabilizer_rotor_copper run return fail
execute unless block ^-1 ^ ^9 #terf:stfr_stabilizer_rotor_copper run return fail
execute unless block ^ ^1 ^9 #terf:stfr_stabilizer_rotor_copper run return fail
execute unless block ^ ^-1 ^9 #terf:stfr_stabilizer_rotor_copper run return fail

execute unless block ^ ^ ^10 netherite_block run return fail

execute unless block ^1 ^1 ^10 #terf:stfr_stabilizer_rotor_stairs run return fail
execute unless block ^-1 ^1 ^10 #terf:stfr_stabilizer_rotor_stairs run return fail
execute unless block ^1 ^-1 ^10 #terf:stfr_stabilizer_rotor_stairs run return fail
execute unless block ^-1 ^-1 ^10 #terf:stfr_stabilizer_rotor_stairs run return fail

execute unless block ^1 ^1 ^9 #terf:stfr_stabilizer_rotor_stairs run return fail
execute unless block ^-1 ^1 ^9 #terf:stfr_stabilizer_rotor_stairs run return fail
execute unless block ^1 ^-1 ^9 #terf:stfr_stabilizer_rotor_stairs run return fail
execute unless block ^-1 ^-1 ^9 #terf:stfr_stabilizer_rotor_stairs run return fail

data modify storage terf:temp args set value {arg1:'summon item_display ^ ^ ^10 {Tags:["terf_stab_loss_laser","terf_related_',arg3:'","terf_currententity"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[8.01f,8.01f,0f]},brightness:{sky:15,block:15},item:{id:"minecraft:firework_star",components:{item_model:"terf:visual/stfr/stab_loss","minecraft:firework_explosion":{shape:"star",colors:[0]}},Count:1b}}'}
data modify storage terf:temp args.arg2 set from entity @s data.terf.machine_id
function datapipes_lib:require/with_args/3 with storage terf:temp args

execute as @e[type=item_display,tag=terf_currententity] run rotate @s facing ~ ~ ~

tag @e[type=item_display] remove terf_currententity

$function terf:entity/machines/stfr/stab_transform/on/stab_$(stab) with entity @s data.terf