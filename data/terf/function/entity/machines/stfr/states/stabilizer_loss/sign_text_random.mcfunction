execute if predicate datapipes_lib:chances/10 run return fail

data modify storage terf:temp temp set from block ~ ~ ~ front_text.messages

scoreboard players set succeeded terf_states 1
$execute if predicate {"condition":"minecraft:random_chance","chance":$(chance)} run scoreboard players set succeeded terf_states 0

execute if score succeeded terf_states matches 1 run function terf:entity/machines/stfr/states/stabilizer_loss/random_text_success
execute if score succeeded terf_states matches 0 run function terf:entity/machines/stfr/states/stabilizer_loss/random_text_fail

data remove storage terf:temp temp[-1]
data modify block ~ ~ ~ front_text.messages set from storage terf:temp temp
