scoreboard players add temp terf_states 3
execute if block ~ ~ ~ #minecraft:air positioned ^ ^ ^.3 run return run function terf:entity/machines/stfr/states/shutdown_failure/rays/raycast

execute unless block ~ ~ ~ #terf:stfr_blocks unless block ~ ~ ~ waxed_lightning_rod run return fail
execute if block ~ ~ ~ #terf:indestructible run return fail
function terf:entity/machines/stfr/visuals/shoot_into_falling_block
