#terf_data_A = progress

execute unless score @s terf_data_A matches 1.. run function terf:entity/machines/ionizer/checks
execute if score @s terf_data_A matches 1.. if score @s datapipes_lib_power_storage matches 15.. run function terf:entity/machines/ionizer/operation
