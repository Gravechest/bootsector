
%console
%name epic

%lib  KERNEL32
%func GetTickCount
%func WriteConsoleA
%func GetStdHandle
%func Sleep

%var handle 8 0
%var output 16 0

push   hf5
call   GetStdHandle
mov    $handle,eax
mov    ebx,10

%label print
rdrand eax
push   eax
xor    ecx,ecx

%label recursion1
xor    edx,edx
cmp    eax,0
je     bepaald
div    ebx
inc    ecx
jmp    recursion1

%label bepaald
pop    eax
mov    edi,$output
add    edi,ecx
mov    edx,10
mov    *edi,edx
dec    edi
push   ecx

%label recursion2
xor    edx,edx
div    ebx
add    edx,h30
mov    *edi,dl
dec    edi
loop   recursion2
pop    ecx
inc    ecx
push   0
push   0
push   ecx
push   $output
mov    eax,*$handle
push   eax
call   WriteConsoleA
push   1000
call   Sleep
jmp    print
