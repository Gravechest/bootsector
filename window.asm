
%window
%name epic

%lib   KERNEL32
%func  GetModuleHandleA
%func  ExitProcess
%func  GetLastError
%func  WriteConsoleA
%func  CreateFileA
%func  CloseHandle

%lib   USER32
%func  RegisterClassA
%func  CreateWindowExA
%func  DefWindowProcA
%func  ShowWindow
%func  MessageBoxA

%var   style         4 0
%var   lpfnWndProc   4 0
%var   cbClsExtra    4 0
%var   cbWndExtra    4 0
%var   hInstance     4 0
%var   hIcon         4 0
%var   hCursor       4 0
%var   hbrBackground 4 0
%var   lpszMenuName  4 0
%var   lpszClassName 4 0

%var   hwnd          4 0
%var   handle        4 0

%var   name1 "window"
%var   name2 "debug.txt"

push   0
push   h80
push   1
push   0
push   1
push   h40000000
push   $name2
call   CreateFileA
push   eax
call   CloseHandle
push   0
push   0
push   0
push   0
call   MessageBoxA
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
cmp    eax,0
je     exit
push   0
push   $hInstance
push   0
push   0
push   h40
push   h40
push   h40
push   h40
push   h10000000
push   $lpszClassName
push   $lpszClassName
push   0
call   CreateWindowExA
mov    $hwnd,eax
call   GetLastError
mov    $style,eax

%label inf
jmp    inf

%label exit
ret

%label proc
push   0
call   ExitProcces
push   0
push   0
push   0
push   $hwnd
call   DefWindowProcA
ret



























