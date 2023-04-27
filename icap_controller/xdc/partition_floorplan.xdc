create_pblock pblock_partition
add_cells_to_pblock [get_pblocks pblock_partition] [get_cells -quiet [list bridge_i/partition]]
resize_pblock [get_pblocks pblock_partition] -add {SLICE_X0Y63:SLICE_X7Y73}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_partition]
set_property SNAPPING_MODE ON [get_pblocks pblock_partition]
set_property IS_SOFT FALSE [get_pblocks pblock_partition]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
