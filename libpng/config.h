/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Define to 1 if you have the `feenableexcept' function. */
#define HAVE_FEENABLEEXCEPT 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the `m' library (-lm). */
#define HAVE_LIBM 1

/* Define to 1 if you have the `z' library (-lz). */
#define HAVE_LIBZ 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `pow' function. */
/* #undef HAVE_POW */

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

/* Name of package */
#define PACKAGE "libpng"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "png-mng-implement@lists.sourceforge.net"

/* Define to the full name of this package. */
#define PACKAGE_NAME "libpng"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "libpng 1.6.36"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "libpng"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "1.6.36"

/* Turn on ARM Neon optimizations at run-time */
/* #undef PNG_ARM_NEON_API_SUPPORTED */

/* Check for ARM Neon support at run-time */
/* #undef PNG_ARM_NEON_CHECK_SUPPORTED */

/* Enable ARM Neon optimizations */
/* #undef PNG_ARM_NEON_OPT */

/* Enable Intel SSE optimizations */
/* #undef PNG_INTEL_SSE_OPT */

/* Turn on MIPS MSA optimizations at run-time */
/* #undef PNG_MIPS_MSA_API_SUPPORTED */

/* Check for MIPS MSA support at run-time */
/* #undef PNG_MIPS_MSA_CHECK_SUPPORTED */

/* Enable MIPS MSA optimizations */
/* #undef PNG_MIPS_MSA_OPT */

/* Turn on POWERPC VSX optimizations at run-time */
/* #undef PNG_POWERPC_VSX_API_SUPPORTED */

/* Check for POWERPC VSX support at run-time */
/* #undef PNG_POWERPC_VSX_CHECK_SUPPORTED */

/* Enable POWERPC VSX optimizations */
/* #undef PNG_POWERPC_VSX_OPT */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Define to 1 if your <sys/time.h> declares `struct tm'. */
/* #undef TM_IN_SYS_TIME */

/* Version number of package */
#define VERSION "1.6.36"

/* Define to empty if `const' does not conform to ANSI C. */
/* #undef const */

/* Define to the equivalent of the C99 'restrict' keyword, or to
   nothing if this is not supported.  Do not define if restrict is
   supported directly.  */
#define restrict __restrict
/* Work around a bug in Sun C++: it does not support _Restrict or
   __restrict__, even though the corresponding Sun C compiler ends up with
   "#define restrict _Restrict" or "#define restrict __restrict__" in the
   previous line.  Perhaps some future version of Sun C++ will work with
   restrict; if so, hopefully it defines __RESTRICT like Sun C does.  */
#if defined __SUNPRO_CC && !defined __RESTRICT
# define _Restrict
# define __restrict__
#endif

/* Define to `unsigned int' if <sys/types.h> does not define. */
/* #undef size_t */
