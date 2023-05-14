// testfoo.swift

class FooLib {

  class func GetVal(InParam: Int32) -> Int32 {
    return FooGetVal(InParam)
  }
}

print(FooLib.GetVal(1))
