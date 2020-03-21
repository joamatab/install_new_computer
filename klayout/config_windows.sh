#!/bin/bash
# installs klive, layermaps, cross-section and drc scripts 
# run ./install_layer_maps
# Then restart Klayout

# REMOVE FILES OR LINKS
# rm -rf %userprofile%/klayout/tech
# rm -rf %userprofile%/klayout/pymacros
# rm -rf %userprofile%/klayout/drc
# rm -rf %userprofile%/klayout/boolean

rm -rf ~/KLayout/tech
rm -rf ~/KLayout/pymacros
rm -rf ~/KLayout/drc
rm -rf ~/KLayout/boolean
rm -rf ~/KLayout/xsection

mkdir -p ~/KLayout/pymacros

ln -s $PWD/software/klayout/tech ~/KLayout/
ln -s $PWD/software/klayout/xsection  ~/KLayout/
ln -s $PWD/software/klayout/drc  ~/KLayout/drc
cp $PWD/software/klayout/pymacros/klive.lym  ~/KLayout/pymacros/


# ln -s $PWD/pymacros  ~/KLayout/
# ln -s $PWD/drc ~/KLayout/
# ln -s $PWD/boolean ~/Klayout
# ln -s $PWD/xsection ~/Klayout/xsection
# ln -s $PWD/macros  ~/.klayout/
# cp -r $PWD/tech ~/KLayout/tech
# cp -r tech ~/KLayout/
# cp -r tech ~/.klayout/
# cp -r drc  ~/.klayout/
# cp -r boolean  ~/.klayout/macros
# cp -r macros   ~/.klayout/
# cp -r macros_red_toolbox   ~/.klayout/macros/
# cp -r pymacros ~/.klayout/
# cp pymacros_lukas/* ~/.klayout/pymacros/
