@echo off
setlocal enabledelayedexpansion

SET campoTamanho=9
SET "campo[0][0]=0"
SET gameOver=false

rem ESSE CODIGO GERA O CAMPO COM AS MINAS
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
		goto :checkBombs
	) else (
		goto :whileLoopCampo
		SET /a j=0
	)



rem ESSE CODIGO CHECA AS MINAS PRESENTES E DEFINE O NUMERO DA POSIÇÃO, SE VAI SER 0, 1, 2, etc.
:checkBombs
	SET /a linhaComeco=0
	SET /a linhaFim=!campoTamanho!
	SET /a colComeco=0
	SET /a colFim=!campoTamanho!

	SET /a row=0
	:linhaBombas
		SET /a linhaComeco=0
		SET /a linhaFim=!campoTamanho!
		SET /a colComeco=0
		SET /a colFim=!campoTamanho!

		SET /a col=0
		:colunaBombas
			SET /a bombas=0

			SET /a PH=%col%-1
			IF %PH% GTR 0 SET /a colComeco=!PH!
			SET /a PH=%col%+1
			IF %PH% LEQ !campoTamanho! SET /a colFim=!PH!

			SET /a PH=%row%-1
			IF %PH% GTR 0 SET /a linhaComeco=!PH!
			SET /a PH=%row%+1
			IF %PH% LEQ !campoTamanho! SET /a linhaFim=!PH!

			IF "!campo[%row%][%col%]!" NEQ "x" (
				FOR /l %%r IN (%linhaComeco%, 1, %linhaFim%) do (
					FOR /l %%c IN (%colComeco%, 1, %colFim%) do (
						IF "!campo[%%r][%%c]!" EQU "x" (
							SET /a bombas+=1
							@REM ECHO !campo[%%r][%%c]!
						)
						
					)
				)
				SET "campo[%row%][%col%]=!bombas!"
			)

			SET /a col += 1
			IF %col% LEQ %campoTamanho% goto :colunaBombas

		SET /a row += 1
		IF %row% LEQ %campoTamanho% goto :linhaBombas


:whileLoop

	SET "output="
	for /L %%i in (0, 1, !campoTamanho!) do (
		for /L %%j in (0, 1, !campoTamanho!) do (
			SET "output=!output! !campo[%%i][%%j]!"
		)
		echo !output!
		SET "output="
	)
	SET /p "celula=qual celula voce quer?"

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
