// testfoo.cs
using System;

using Foo.Interop;

public class TestFoo
{
  static void Main(string[] args)
  {
    Console.WriteLine(FooLib.GetVal(1)); 
  }
}
