#/bin/sh

ARCH=`uname -m`

if [ "x$ARCH" = "xx86_64" ]; then
  LIBDIRSUFFIX=64
else
  LIBDIRSUFFIX=
fi

# Check for stripped /lib/ld.so
LD_LIB=`ls /lib${LIBDIRSUFFIX}/ld*.so`
DBG_SYMS=`nm --debug-syms ${LD_LIB} | wc -l`
if (( DBG_SYMS > 0 )); then
  echo "INFO: Your system $LD_LIB library has debugging symbols."
else
  echo "WARNING: Your system $LD_LIB library is stripped!"
  echo "         Valgrind's memcheck will not work properly."
fi

# Check for relocation
CWD=`pwd`
if [ "$CWD" != "/" ]; then
  echo "WARNING: The build of Valgrind is not relocatable!"
  echo "         You should install in / to prevent problems."
fi

