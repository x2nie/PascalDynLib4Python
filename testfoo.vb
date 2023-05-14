' testfoo.vb
Option Explicit On
Option Strict On

Imports Foo.Interop

Public Class TestFoo

  Public Shared Sub Main()
    Console.WriteLine(FooLib.GetVal(1)) 
  End Sub

End Class
