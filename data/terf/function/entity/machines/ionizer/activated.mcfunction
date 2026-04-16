$function datapipes_lib:fluid_transfer/remove_fluid {tank:0,amount:$(a)}
execute store result score @s terf_data_A run data get storage terf:temp output.t
data modify entity @s data.terf.stored_recipe set from storage terf:temp output