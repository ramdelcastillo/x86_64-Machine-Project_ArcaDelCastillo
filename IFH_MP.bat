nasm -f win64 ImgFlipHorizontal.asm
gcc -c CImgFlipHorizontal.c -o CImgFlipHorizontal.obj -m64
gcc CImgFlipHorizontal.obj ImgFlipHorizontal.obj -o ImgFlipHorizontal.exe -m64
ImgFlipHorizontal.exe