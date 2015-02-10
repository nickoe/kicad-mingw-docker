# Exit on first ror
set -e


#[[ -d kicad-source-mirror ]] && rm -r kicad-source-mirror
#mkdir kicad-source-mirror && cd kicad-source-mirror
git clone --depth=1 https://github.com/KiCad/kicad-source-mirror.git .

#export VERSION=`cat pom.xml|grep -e '<version>\(.*\)</version>'|head -n 1|sed  's/^.*<version>\(.*\)<\/version>/\1/g'`
#export VERSION=`git log -n1 --pretty=format:%at | awk '{print strftime("%y%m%d%H%M",$1)}'`
export VERSION=`git log -n1 --pretty=format:%ai|cut -c1-10`
echo $VERSION
echo "hello world"


#build =============> 32bit
export HOST=i686-w64-mingw32
export ARCH=w32
export CROSSPREFIX=i686-w64-mingw32-
mkdir build-$ARCH
cd build-$ARCH


  # Configure and build KiCad.
  #[[ -d build-${MINGW_CHOST} ]] && rm -r build-${MINGW_CHOST}
  #mkdir build-${MINGW_CHOST} && cd build-${MINGW_CHOST}
LDFLAGS="-L/build/${ARCH}" CXXFLAGS="-I/build/mingw"   \
  cmake -DCMAKE_TOOLCHAIN_FILE=/build/Toolchain-cross-mingw32-linux.cmake \
    -DHOST=$HOST \
    -DARCH=$ARCH \
    -DCMAKE_PREFIX_PATH=${CROSSPREFIX} \
    -DCMAKE_INSTALL_PREFIX=/opt/${CROSSPREFIX} \
    -DOPENSSL_ROOT_DIR=${CROSSPREFIX} \
    -DKICAD_SKIP_BOOST=OFF \
    -DKICAD_SCRIPTING=OFF \
    -DKICAD_SCRIPTING_MODULES=OFF \
    -DKICAD_SCRIPTING_WXPYTHON=OFF \
    -DwxWidgets_CONFIG_EXECUTABLE=`which wx-config` \
    -DwxWidgets_wxrc_EXECUTABLE=`which wxrc` \
    -DwxWidgets_FIND_STYLE="unix" \
    -DwxWidgets_INCLUDE_DIRS="/usr/include/wx-3.0" \
    ../
    #-DVERBOSE=1
#       -DPYTHON_EXECUTABLE=${CROSSPREFIX}/bin/python2 \
#    -G"MSYS Makefiles" \
	echo "Gonna make this shit!!!"
	echo "......................."
  make


cd -


#build =============> 64bit
export HOST=x86_64-w64-mingw32
export ARCH=w64
export CROSSPREFIX=x86_64-w64-mingw32-
mkdir build-$ARCH
cd build-$ARCH
echo "TODO: Do $ARCH building here..."
cd -

echo "TODO: Publish build here..."


