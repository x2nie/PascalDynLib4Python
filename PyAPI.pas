unit PyAPI;

{

  Minimum set of Python function declarations for module libraries.

  Author:    Phil Hess.
  Copyright: Copyright (C) Phil Hess.
  License:   Modified LGPL (see Free Pascal's rtl/COPYING.FPC).

  To add other Python function declarations, see the Python header
   files (.h) included with every Python distribution.

}

{$IFDEF FPC}
 {$mode objfpc}{$H+}
{$ENDIF}

interface

{$DEFINE IS32BIT}
{$IFDEF CPUX64}  {Delphi}
 {$UNDEF IS32BIT}
{$ENDIF}
{$IFDEF CPU64}  {FPC}
 {$UNDEF IS32BIT}
{$ENDIF}

const
{$IFDEF MSWINDOWS}
 {$IFDEF USE_PYTHON3}
  PythonLib = 'python35.dll';
 {$ELSE}
  PythonLib = 'python27.dll';
 {$ENDIF}
{$ENDIF}

{$IFDEF LINUX}
 {$IFDEF USE_PYTHON3}
  PythonLib = 'python3.8';
 {$ELSE}
  PythonLib = 'python2.7';
 {$ENDIF}
{$ENDIF}

{$IFDEF DARWIN}
  PythonLib = '';  //Link against system Python framework (-k'-framework Python').
                   // To link against a specific version of Python, pass the
                   // full path to that version's library instead. Examples:
                   //  -k'/Library/Frameworks/Python.framework/Versions/3.5/Python'
                   //  -k'/System/Library/Frameworks/Python.framework/Versions/2.7/Python'
{$ENDIF}

type
{$IFDEF IS32BIT}
  c_long = LongInt;
  c_ulong = LongWord;
  c_int  = LongInt;
{$ELSE}
  c_long = Int64;
  c_ulong = UInt64;
  c_int = Int64;  //"int" also appears to be 8 bytes with 64-bit Python
{$ENDIF}

  PyMethodDef = packed record
    name  : PAnsiChar;  //Python function name
    meth  : Pointer;    //Address of function that implements it
    flags : c_int;      //METH_xxx flags; describe function's arguments
    doc   : PAnsiChar;  //Description of funtion
    end;

  PyObject = Pointer;

const
  PYTHON_API_VERSION = 1013;  //Python 2.5 and later
  METH_VARARGS = 1;

{$IFDEF USE_PYTHON3}
type
  PPyMethodDef = ^PyMethodDef;

  PyModuleDef_Base = packed record
    ob_refcnt : c_int;
    ob_type   : Pointer;  //PyTypeObject?
    m_init    : function( ) : PyObject; cdecl;
    m_index   : c_int;
    m_copy    : PyObject;
    end;

  PyModuleDef = packed record
    m_base     : PyModuleDef_Base;
    m_name     : PAnsiChar;
    m_doc      : PAnsiChar;
    m_size     : c_int;
    m_methods  : PPyMethodDef;
    m_reload   : Pointer;  //inquiry?
    m_traverse : Pointer;  //traverseproc?
    m_clear    : Pointer;  //inquiry?
    m_free     : Pointer;  //inquiry?
    end;

function PyModule_Create(var moduledef : PyModuleDef;
                             apiver    : c_int = PYTHON_API_VERSION): PyObject; cdecl;
          external PythonLib name 'PyModule_Create2';

function PyInt_FromLong(along : c_long) : PyObject; cdecl; external PythonLib name 'PyLong_FromLong';

function PyString_FromString(astr : PAnsiChar) : PyObject; cdecl; external PythonLib name 'PyUnicode_FromString';

{$ELSE}
function Py_InitModule(    name    : PAnsiChar;
                       var methods : PyMethodDef;
                           doc     : PAnsiChar = nil;
                           self    : PyObject = nil;
                           apiver  : c_int = PYTHON_API_VERSION) : PyObject; cdecl; 
          external PythonLib name {$IFDEF IS32BIT}'Py_InitModule4'{$ELSE}'Py_InitModule4_64'{$ENDIF};

function PyInt_FromLong(along : c_long) : PyObject; cdecl; external PythonLib;
 
function PyString_FromString(astr : PAnsiChar) : PyObject; cdecl; external PythonLib;
{$ENDIF}
 
function PyArg_ParseTuple(args   : PyObject;
                          format : PAnsiChar) : c_int; cdecl; varargs; external PythonLib;
 //Note varargs allows us to simulate C variable number of arguments (...)

function PyLong_FromLong(along : c_long) : PyObject; cdecl; external PythonLib;

function PyFloat_FromDouble(adouble : Double) : PyObject; cdecl; external PythonLib;

function PyLong_FromUnsignedLong(aulong : c_ulong) : PyObject; cdecl; external PythonLib;

function PyLong_FromVoidPtr(aptr : Pointer) : PyObject; cdecl; external PythonLib;

procedure PyErr_SetString(_type   : PyObject;
                          message : PAnsiChar); cdecl; external PythonLib;

function PyErr_NewException(name : PAnsiChar;
                            base : PyObject;
                            dict : PyObject) : PyObject; cdecl; external PythonLib;

{$IFDEF FPC}  //Not supported by Delphi
var
  PyExc_RuntimeError : PyObject; external PythonLib;
{$ENDIF}


implementation


end.
