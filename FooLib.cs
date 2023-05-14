// FooLib.cs
using System;
using System.Runtime.InteropServices;

namespace Foo.Interop
{
  public class FooLib
  {
  #if USE_64_BIT
    private const string FooLibNameBase = "foo64";
  #else
    private const string FooLibNameBase = "foo";
     //Note 32-bit Mono on OS X needs 32-bit or "fat" libfoo.dylib
  #endif

  #if USE_STDCALL
    private const CallingConvention FooCallConv = CallingConvention.StdCall;
  #elif USE_WINAPI  //uses StdCall on Windows and Cdecl on OS X and Linux
    private const CallingConvention FooCallConv = CallingConvention.Winapi;
  #else
    private const CallingConvention FooCallConv = CallingConvention.Cdecl;
  #endif

     [DllImport(FooLibNameBase,
                CallingConvention=FooCallConv)]
    private static extern Int32 FooGetVal(Int32 InParam);

    public static Int32 GetVal(Int32 InParam)
    {
      return FooGetVal(InParam);
    }
  }
}
