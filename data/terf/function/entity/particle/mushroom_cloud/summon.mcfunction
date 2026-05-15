data merge entity @s {Rotation:[0f,-90f],Tags:["terf_mushroom_cloud"],text:{text:"\ueff5",color:"#000000"},background:0,teleport_duration:3,text_opacity:128,billboard:center}

execute store result storage terf:temp args.yaw float 0.001 run random value 1..360000
execute store result storage terf:temp args.dist float 0.001 run random value 1..3000
function terf:entity/particle/mushroom_cloud/summon_args with storage terf:temp args