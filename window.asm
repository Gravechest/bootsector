%window
%name epic

%library USER32
%function MessageBoxA
%function CreateWindowExA
%function RegisterClassExA
%function DefWindowProcA

%library KERNEL32
%function GetModuleHandleA

%variable mes "hello world!"

%variable class "class"

%variable cbsize 4 0
%variable style 4 0
%variable proc 4 0
%variable m1 4 0
%variable m2 4 0
%variable hinstance 4 0
%variable icon 4 0
%variable cursor 4 0
%variable background 4 0
%variable menuname 4 0
%variable clasname 4 0
%variable icn 4 0

mov    al,52
mov    $cbsize,eax
mov    eax,$class
mov    $clasname,eax
mov    eax,~proc
mov    $proc,eax
push   $cbsize
call   RegisterClassExA 
push   0
call   GetModuleHandleA
push   0
push   eax
push   0
push   0
push   40
push   40
push   40
push   40
push   h10000000
push   $mes
push   $class
push   0
call   CreateWindowExA
ret

%label proc
call   DefWindowProcA
ret













