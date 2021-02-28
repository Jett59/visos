[bits 16]

section .text
global set_es
set_es:
mov es, ax
retd

global set_fs
set_fs:
mov fs, ax
retd

global set_gs
set_gs:
mov gs, ax
retd

global read_es
read_es:
push si
mov si, ax
mov eax, dword [es:si]
pop si
retd

global read_fs
read_fs:
push si
mov si, ax
mov eax, dword [fs:si]
pop si
retd

global read_gs
read_gs:
push si
mov si, ax
mov eax, dword [gs:si]
pop si
retd

global write_es
write_es:
push si
mov si, ax
mov dword [es:si], edx
pop si
retd

global write_fs
write_fs:
push si
mov si, ax
mov dword [fs:si], edx
pop si
retd

global write_gs
write_gs:
push si
mov si, ax
mov dword [gs:si], edx
pop si
retd
