
runtime! syntax/jade.vim

syn region  jadeMontageSerializationFilter matchgroup=jadeFilter start="^\z(\s*\):bindings\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlCoffeescript
syn region  jadeMontageSerializationFilter matchgroup=jadeFilter start="^\z(\s*\):montage-bind\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlCoffeescript
syn region  jadeMontageCodeFilter matchgroup=jadeFilter start="^\z(\s*\):montage-script\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlCoffeescript
syn region  jadeMontageStylusFilter matchgroup=jadeFilter start="^\z(\s*\):montage-style\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlStylus
"
