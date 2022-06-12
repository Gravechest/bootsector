#include <windows.h>

HWND window;
WNDCLASS wndclass;
char *windowname = "w";
MSG msg;

_declspec(naked) main(){
	_asm{
		push   0
		call   [GetModuleHandleA]
		mov    wndclass.hInstance,eax
		mov    eax,offset windowname
		mov    wndclass.lpszClassName,eax
		mov    wndclass.lpszMenuName,eax
		mov    eax,@proc
		mov    wndclass.lpfnWndProc,eax
		push   offset wndclass.style
		call   [RegisterClassA]
		push   0
		push   offset wndclass.hInstance
		push   0
		push   0
		push   0x100
		push   0x100
		push   0x40
		push   0x40
		push   0x10000000
		push   offset windowname
		push   offset windowname
		push   0
		call   [CreateWindowExA]
		mov    window,eax
	@inf:	
		mov    eax,window
		push   eax
		push   offset msg
		call   [GetMessageA]
		push   offset msg
		call   [TranslateMessage]
		push   offset msg
		call   [DispatchMessageA]
		jmp    @inf
	@proc:
		push   ebp
		mov    ebp,esp
		push   dword [ebp+20]
		push   dword [ebp+16]
		push   dword [ebp+12]
		push   dword [ebp+8 ]
		call   [DefWindowProcA]
		mov    esp,ebp
		pop    ebp
		ret
	}
}
