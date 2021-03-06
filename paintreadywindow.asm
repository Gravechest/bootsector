
%console
%name epic

%lib   KERNEL32
%func  GetModuleHandleA
%func  HeapAlloc
%func  GetProcessHeap

%lib   USER32
%func  RegisterClassA
%func  CreateWindowExA
%func  DefWindowProcA
%func  GetMessageA
%func  TranslateMessage
%func  DispatchMessageA
%func  PeekMessageA
%func  GetDC

%lib   GDI32
%func  StretchDIBits

%var   name1 "T"

%var   style         4  0
%var   lpfnWndProc   4  ~proc
%var   cbClsExtra    4  0
%var   cbWndExtra    4  0
%var   hInstance     4  0
%var   hIcon         4  0
%var   hCursor       4  0
%var   hbrBackground 4  0
%var   lpszMenuName  4  $name1
%var   lpszClassName 4  $name1

%var   DC            4  0
%var   hwnd          4  0
%var   handle        4  0
%var   msg           28 0
%var   texture       4  0
%var   bericht       4  0

%var   bit.size      4  40
%var   bit.width     4  500
%var   bit.height    4  500
%var   bit.planes    2  1
%var   bit.bitcount  2  24
%var   bit           28 0

xor    edi,edi
call   GetProcessHeap
push   750000
push   edi
push   eax
call   HeapAlloc
mov    $texture,eax
push   edi
call   GetModuleHandleA 
mov    $hInstance,eax
push   $style
call   RegisterClassA
push   edi
push   $hInstance
push   edi
push   edi
push   500
push   500
push   400
push   400
push   h10080000
push   $name1
push   $name1
push   edi
call   CreateWindowExA
mov    $hwnd,eax
push   eax
call   GetDC
mov    $DC,eax

%label inf
push   hcc0020
push   edi
push   $bit.size
push   *$texture
push   500
push   500
push   edi
push   edi
push   500
push   500
push   edi
push   edi
push   *$DC
call   StretchDIBits
push   edi
push   edi
push   edi
push   *$hwnd
push   $msg
call   PeekMessageA
cmp    al,0
je     inf
push   edi
push   edi
push   *$hwnd
push   $msg
call   GetMessageA
push   $msg
call   TranslateMessage
push   $msg
call   DispatchMessageA
jmp    inf

%label proc
push   ebp
mov    ebp,esp
push   *ebp+20
push   *ebp+16
push   *ebp+12
push   *ebp+8
call   DefWindowProcA
mov    esp,ebp
pop    ebp
ret
