#terf_data_A = toxicity
#terf_data_B = flammability

data modify entity @s BatFlags set value 0b
execute if block ~ ~-1 ~ water run return run kill @s
execute if predicate datapipes_lib:can_see_sky run return run kill @s
execute if entity @s[tag=terf_fire] if predicate terf:flammable_nearby unless entity @e[type=bat,tag=terf_fire,distance=0.01..3,limit=1] run function terf:entity/gases/fire_spread
execute unless entity @e[type=bat,tag=terf_gas,distance=0.01..7,limit=1] run kill @s
execute if entity @s[tag=terf_toxic] run function terf:entity/gases/poison
execute if entity @s[tag=terf_flammable] if block ~ ~-.3 ~ #terf:ignition_source run function terf:entity/gases/explode
