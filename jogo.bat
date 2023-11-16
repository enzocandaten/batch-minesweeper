@echo off
setlocal enabledelayedexpansion

SET campoTamanho=9
SET "campo[0][0]=0"
SET gameOver=false


SET /a i=0
:whileLoopCampo
	SET /a j=0
	:whileLoopInside
		if !j! GTR !campoTamanho! (
			goto :check
		) else (
			SET "campo[!i!][!j!]=0"
			SET /a j=j+1
			goto :whileLoopInside
		)

:check
rem LOOP DO BAGULHO

SET /a randomNum=%random% %% 10
SET "campo[!i!][!randomNum!]=x"

SET /a i=i+1
if !i! GTR !campoTamanho! (
	goto :whileLoop
) else (
	goto :whileLoopCampo
	SET /a j=0
)





:whileLoop

SET "output="
for /L %%i in (0, 1, !campoTamanho!) do (
	for /L %%j in (0, 1, !campoTamanho!) do (
		SET "output=!output! !campo[%%i][%%j]!"
	)
	echo !output!
	SET "output="
)

SET /p "celula=echo qual celula voce quer?"


if !celula! == 5 (
	SET gameOver=true
)





CLS
if %gameOver% == true (
	endLocal
) else (
	goto :whileLoop
)

endLocal