#z = sin(min(x,10000) / 30 - .5) / 5

$data modify storage terf:temp args.x set value $(input)f
#divide by 30 and multiply by 1000000 for accuracy
execute store result score temp terf_states run data get storage terf:temp args.x 33333.333333333333333333333333333333
execute if score temp terf_states matches 333333333.. run scoreboard players set temp terf_states 333333333
scoreboard players remove temp terf_states 500000
execute if score temp terf_states matches ..-1 run scoreboard players set temp terf_states 0

execute store result entity 0010eff0-0010-effa-0010-cd370010c94e Rotation[0] float 0.000001 run scoreboard players get temp terf_states
execute as 0010eff0-0010-effa-0010-cd370010c94e rotated as @s in terf:intermediary_technical_storage_dimension positioned 0. 0 0. run tp @s ^ ^ ^0.5

#return with the accuracy of 1000000 in barns
return run data get entity 0010eff0-0010-effa-0010-cd370010c94e Pos[0] -200000