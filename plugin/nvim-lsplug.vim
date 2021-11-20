" prevent loading file twice
if exists("g:nvim_lsplug")
  finish
endif

lua require("nvim-lsplug").init()

let g:nvim_lsplug = 1
