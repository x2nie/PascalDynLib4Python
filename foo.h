// foo.h
#include <stdint.h>

#ifdef _MSC_VER
  #define CDECL __cdecl
  #define STDCALL __stdcall
#else
  #define CDECL  /* */
  #define STDCALL __attribute__((stdcall))
#endif

#ifdef USE_STDCALL
  #define FOO_CALL STDCALL
#else
  #define FOO_CALL CDECL
#endif
 //Note issue with 32-bit Windows DLL: if __stdcall is used, 
 // MSVC linker looks for stdcall-decorated "C" function names.
 // http://en.wikipedia.org/wiki/Name_mangling
 // https://msdn.microsoft.com/en-us/library/x7kb4e2f.aspx
 // https://msdn.microsoft.com/en-us/library/deaxefa7.aspx

typedef int32_t FOO_INT;

FOO_INT FOO_CALL FooGetVal(FOO_INT InParam);
