library foo;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

uses
  SysUtils
{$IFDEF FPC},
  ctypes
{$ENDIF};
  
{$IFNDEF FPC}
type
  cint32 = LongInt;
{$ENDIF}

 //By default, use cdecl on Windows too: if stdcall, MSVC won't link
 // to 32-bit Delphi/FPC DLL unless export decorated names too (below).
{$DEFINE USE_CDECL}
{$IFDEF USE_STDCALL}  //Override and use stdcall?
  {$UNDEF USE_CDECL}
{$ENDIF}

function FooGetVal(InParam : cint32) : cint32; {$IFDEF USE_CDECL}cdecl{$ELSE}stdcall{$ENDIF};
begin
  try
    Result := InParam * 2;
  except  //No way to return E.Message, so just return impossible value (odd).
    Result := -1;
  end;
end;

exports
  FooGetVal
{$IFNDEF USE_CDECL}
  {$IFDEF WIN32},
  FooGetVal name 'FooGetVal@4' //Also export stdcall-decorated name with Win32.
  {$ENDIF}
{$ENDIF};

end.
