' FooLib.vb
Option Explicit On
Option Strict On

Imports System.Runtime.InteropServices

Namespace Foo.Interop

  Public Class FooLib

  #If USE_64_BIT Then
    Private Const FooLibNameBase As String = "foo64"
  #Else
    Private Const FooLibNameBase As String = "foo"
     'Note 32-bit Mono on OS X needs 32-bit or "fat" libfoo.dylib
  #End If

  #If USE_STDCALL Then
    Private Const FooCallConv As CallingConvention = CallingConvention.StdCall
  #Elseif USE_WINAPI Then  'uses StdCall on Windows and Cdecl on OS X and Linux
    Private Const FooCallConv As CallingConvention = CallingConvention.Winapi
  #Else
    Private Const FooCallConv As CallingConvention = CallingConvention.Cdecl
  #End If

     <DllImport(FooLibNameBase, _
                CallingConvention:=FooCallConv)> _
    Private Shared Function FooGetVal (InParam As Int32) As Int32
    End Function

    Public Shared Function GetVal (InParam As Int32) As Int32
      GetVal = FooGetVal(InParam)
    End Function

  End Class

End Namespace
