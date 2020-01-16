# patch_for_interface_drivers
Patch files to re-compile kernel drivers for DA/AD/Penc boards made by interface corporation.

For more details, please visit [my blog page](https://qiita.com/larking95/items/257f99177058d5ed0030). (Only available Japanese)

# Target Environment
* Ubuntu 16.04 with kernel ver. 4.9.80
* [gpg3100](http://www.interface.co.jp/catalog/soft/prdc_soft_all.asp?name=GPG-3100) (gpg3100_i386_056046.tgz)
* [gpg3300](http://www.interface.co.jp/catalog/soft/prdc_soft_all.asp?name=GPG-3300) (gpg3300_i386_047043.tgz)
* [gpg6204](http://www.interface.co.jp/catalog/soft/prdc_soft_all.asp?name=GPG-6204) (gpg6204_i386_044020.tgz)

# How to use patch files
1. Before using these patch files, install official driver files.
2. Download files and place them in target pc.
3. Run script named `compile_drivers.sh` as root.
