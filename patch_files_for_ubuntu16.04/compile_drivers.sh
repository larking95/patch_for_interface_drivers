#!/bin/bash

# @brief インターフェイス社のドライバーのソースを書き換えて，コンパイルするスクリプト<br>
#	Ubuntu 16.04 LTS用です。<br>
#	とりあえず書いてみただけなので，動かないかもです。(主にタイプミスの可能性が高い)
#
#	sudo bash compile_drivers.sh で実行します。
#	前提条件として，このスクリプトと同じ場所にパッチファイルは配置してください。
#
#	Copyright (c) 2019 larking95 (https://qiita.com/larking95)
#	Released under the MIT Licence
#	https://opensource.org/licenses/mit-license.php

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)	# スクリプトの場所
distParentDirectory="/usr/src/interface/"					# インターフェイスドライバの場所
arch="i386"

set -e		# エラー時に停止する

if [ ! -e ${distParentDirectory} ]; then
	echo "before this script, please install each driver first!"
	exit 1
fi

echo "dpg0100 is compiling..."
distDirectory="${distParentDirectory%/}/common/dpg0100/src/"
mv "${distDirectory%/}/Makefile" "${distDirectory%/}/Makefile.org"	# オリジナルを保存
cp ./Makefile.dpg0100 "${distDirectory%/}/Makefile"					# Makefileを置き換え
cp ./dpg0100.patch "${distDirectory%/}/dpg0100.patch"				# パッチファイルをコピー
cd ${distDirectory}
patch -b -i dpg0100.patch -N && :										# パッチを当てる
make
make install
cd $script_dir
echo "done"
echo -e "\n===================================\n"

echo "dpg0101 is compiling..."
distDirectory="${distParentDirectory%/}/common/dpg0101/src/"
mv "${distDirectory%/}/Makefile" "${distDirectory%/}/Makefile.org"	# オリジナルを保存
cp ./Makefile.dpg0101 "${distDirectory%/}/Makefile"					# Makefileを置き換え
cp ./dpg0101.patch "${distDirectory%/}/dpg0101.patch"				# パッチファイルをコピー
cd ${distDirectory}
patch -b -i dpg0101.patch -N && :										# パッチを当てる
make
make install
cd $script_dir
echo "done"
echo -e "\n===================================\n"

echo "gpg3100 is compiling..."
distDirectory="${distParentDirectory%/}/gpg3100/${arch}/linux/drivers/src/"
mv "${distDirectory%/}/Makefile" "${distDirectory%/}/Makefile.org"	# オリジナルを保存
cp ./Makefile.gpg3100 "${distDirectory%/}/Makefile"					# Makefileを置き換え
cp ./gpg3100.patch "${distDirectory%/}/gpg3100.patch"				# パッチファイルをコピー
cd ${distDirectory}
patch -b -i gpg3100.patch -N && :										# パッチを当てる
ln -fs "${distDirectory%/}/../ver26/bocp3100.o" ./							# シンボリックリンク作成
ln -fs /usr/include/fbiad.h ./										# シンボリックリンク作成
make
make install
cd $script_dir
echo "done"
echo -e "\n===================================\n"

echo "gpg3300 is compiling..."
distDirectory="${distParentDirectory%/}/gpg3300/${arch}/linux/drivers/src/"
mv "${distDirectory%/}/Makefile" "${distDirectory%/}/Makefile.org"	# オリジナルを保存
cp ./Makefile.gpg3300 "${distDirectory%/}/Makefile"					# Makefileを置き換え
cp ./da_drventry.patch "${distDirectory%/}/da_drventry.patch"		# パッチファイルをコピー
cd ${distDirectory}
ln -fs "${distDirectory%/}/../ver26/bocp3300.o" ./							# シンボリックリンク作成
ln -fs /usr/include/fbida.h ./										# シンボリックリンク作成
patch -N -b -i da_drventry.patch && :									# パッチを当てる
make
make install
cd $script_dir
echo "done"
echo -e "\n===================================\n"

echo "gpg6204 is compiling..."
distDirectory="${distParentDirectory%/}/gpg6204/${arch}/linux/drivers/src/"
mv "${distDirectory%/}/Makefile" "${distDirectory%/}/Makefile.org"	# オリジナルを保存
cp ./Makefile.gpg6204 "${distDirectory%/}/Makefile"					# Makefileを置き換え
cp ./gpg6204.patch "${distDirectory%/}/penc_drventry.patch"		# パッチファイルをコピー
cd ${distDirectory}
ln -fs /usr/include/dpg0100.h ./									# シンボリックリンク作成
ln -fs /usr/include/fbipenc.h ./									# シンボリックリンク作成
ln -fs "${distDirectory%/}/../ver26/bocp6204.o" ./									# シンボリックリンク作成
patch -N -b -i penc_drventry.patch && :									# パッチを当てる
make
make install
cd $script_dir
echo "done"
echo -e "\n===================================\n"

depmod -a	# 
depmod -A

echo "All compiling (maybe) suceeded! "
echo "Could you try to load kernel modules. "
