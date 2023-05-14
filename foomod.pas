library foomod;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

uses
  SysUtils,
{$IFDEF FPC}
  ctypes,
{$ENDIF}
  PyAPI;

{$DEFINE UNIV_OR_32BIT}
{$IFNDEF DARWIN}  {Assume OS X library is universal 32/64-bit}
  {$IFDEF CPUX64}
    {$UNDEF UNIV_OR_32BIT}
  {$ENDIF}
  {$IFDEF CPU64}
    {$UNDEF UNIV_OR_32BIT}
  {$ENDIF}
{$ENDIF}

const
{$IFDEF UNIV_OR_32BIT}
  FooLibNameBase = 'foo';
  {$IFDEF USE_PYTHON3}
  FooModName = 'foomod_3';
  {$ELSE}
  FooModName = 'foomod';
  {$ENDIF}
{$ELSE}
  FooLibNameBase = 'foo64';
  {$IFDEF USE_PYTHON3}
  FooModName = 'foomod64_3';
  {$ELSE}
  FooModName = 'foomod64';
  {$ENDIF}
{$ENDIF}

{$IFDEF DARWIN}
  {$linklib foo}
{$ENDIF}

{$IFNDEF FPC}
type
  cint32 = LongInt;
{$ENDIF}

 //By default, use cdecl on Windows too: if stdcall, MSVC won't link
 // to 32-bit Delphi/FPC DLL unless it exports decorated names too.
{$DEFINE USE_CDECL}
{$IFDEF USE_STDCALL}  //Override and use stdcall?
  {$UNDEF USE_CDECL}
{$ENDIF}

//function FooGetVal(InParam : cint32) : cint32; {$IFDEF USE_CDECL}cdecl{$ELSE}stdcall{$ENDIF}; external FooLibNameBase;


function GetVal(Self : PyObject;
                Args : PyObject) : PyObject; cdecl;
var
  InParam : cint32;
begin
  try
    if PyArg_ParseTuple(Args, 'i', @InParam) = 0 then
    begin  //Python exception will also be set, eg, OverflowError
      Result := nil;
      Exit;
    end;
    // Result := PyInt_FromLong(FooGetVal(InParam));
    Result := PyInt_FromLong(InParam * 2);
  except
    on E:Exception do
    begin
      PyErr_SetString(PyErr_NewException(FooModName + '.Error', nil, nil), 
                      PAnsiChar(AnsiString(E.Message)));
      Result := nil;
    end;
  end;
end;


const
  NumFuncs = 1;

var
  Methods : packed array [0..NumFuncs] of PyMethodDef;

{$IFDEF USE_PYTHON3}
  ModuleDef : PyModuleDef;

  {$IFDEF UNIV_OR_32BIT}
procedure PyInit_foomod_3; cdecl;
  {$ELSE}
procedure PyInit_foomod64_3; cdecl;
  {$ENDIF}

{$ELSE}
  {$IFDEF UNIV_OR_32BIT}
procedure initfoomod; cdecl;
  {$ELSE}
procedure initfoomod64; cdecl;
  {$ENDIF}
{$ENDIF}

begin
  Methods[0].name := 'GetVal';
  Methods[0].meth := @GetVal;
  Methods[0].flags := METH_VARARGS;
  Methods[0].doc := 'This iss GetVal description: okay.';

  Methods[NumFuncs].name := nil;
  Methods[NumFuncs].meth := nil;
  Methods[NumFuncs].flags := 0;
  Methods[NumFuncs].doc := nil;

{$IFDEF USE_PYTHON3}
  ModuleDef.m_name := FooModName;
  ModuleDef.m_doc := nil;
  ModuleDef.m_size := 0;  //?
  ModuleDef.m_methods := @Methods;
  ModuleDef.m_reload := nil;
  ModuleDef.m_traverse := nil;
  ModuleDef.m_clear := nil;
  ModuleDef.m_free := nil;
  PyModule_Create(ModuleDef);
{$ELSE}
  Py_InitModule(FooModName, Methods[0]);
{$ENDIF}
end;

exports
{$IFDEF USE_PYTHON3}
  {$IFDEF UNIV_OR_32BIT}
  PyInit_foomod_3;
  {$ELSE}
  PyInit_foomod64_3;
  {$ENDIF}
{$ELSE}
  {$IFDEF UNIV_OR_32BIT}
  initfoomod;
  {$ELSE}
  initfoomod64;
  {$ENDIF}
{$ENDIF}
 
end.
