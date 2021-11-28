
%console
%name epic

%lib   KERNEL32
%func  GetModuleHandleA
%func  ExitProcess

%lib   USER32
%func  RegisterClassA
%func  CreateWindowExA
%func  DefWindowProcA
%func  GetMessageA
%func  TranslateMessage
%func  DispatchMessageA
%func  PeekMessageA	
%func  GetDC
%func  FillRect

%lib   GDI32
%func  SetPixelV

%var   style         4  0
%var   lpfnWndProc   4  0
%var   cbClsExtra    4  0
%var   cbWndExtra    4  0
%var   hInstance     4  0
%var   hIcon         4  0
%var   hCursor       4  0
%var   hbrBackground 4  0
%var   lpszMenuName  4  0
%var   lpszClassName 4  0

%var   hwnd          4  0
%var   handle        4  0
%var   msg           32 0
%var   rect1         4  0
%var   rect2         4  0
%var   rect3         4  50
%var   rect4         4  50

%var   name1 "window"
%var   name2 "debug.txt"


push   0
call   GetModuleHandleA 
mov    $hInstance,eax
mov    eax,$name1
mov    $lpszMenuName,eax
mov    $lpszClassName,eax
mov    eax,~proc
mov    $lpfnWndProc,eax
push   $style
call   RegisterClassA
push   0
push   $hInstance
push   0
push   0
push   h200
push   h500
push   h100
push   h100
push   h10080000
push   $name1
push   $name1
push   0
call   CreateWindowExA
mov    $hwnd,eax
push   eax
call   GetDC
mov    esi,eax

%label inf
push   3
push   $rect1
push   esi
call   FillRect
mov    eax,*$rect3
inc    eax
cmp    eax,200

mov    $rect3,eax
push   0
push   0
push   0
mov    eax,*$hwnd
push   eax
push   $msg
call   PeekMessageA
cmp    eax,0
je     inf
push   0
push   0
mov    eax,*$hwnd
push   eax
push   $msg
call   GetMessageA
push   $msg
call   TranslateMessage
push   $msg
call   DispatchMessageA
jmp    inf

%label exit
call   ExitProcess

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

















