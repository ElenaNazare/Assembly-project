.data
	matrice_produs: .space 40000
	matrice: .space 40000
	matrice2: .space 40000
	v: .space 400
	lineIndex: .space 4
	columnIndex: .space 4
	st: .space 4		
	dr: .space 4		
	index: .space 4
	contor: .space 4
	val: .space 4
	nrCerinta: .space 4
	nrNoduri: .space 4
	nrLegaturi: .space 4
	#2
	lungime_drum: .space 4
	nodSursa: .space 4
	nodDest: .space 4
	pt_pop: .space 4
	rezultat: .space 4
	
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
	formatPrintf2: .asciz "%d"
	newLine: .asciz "\n"

.text
matrix_mult:
	pushl %ebp
	movl %esp,%ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	movl 8(%ebp),%edi
	addl $16,%esp

	movl 16(%ebp),%ebx
	movl %ebx,-28(%ebp)
	movl $0,-16(%ebp)
	for_linie_matrprod:
		movl -16(%ebp),%ecx
		cmp %ecx,20(%ebp)
		je restaurare

		movl 12(%ebp),%esi
		movl $0,-20(%ebp)
		for_linie_matr1:
			movl -20(%ebp),%ecx
			cmp %ecx,20(%ebp)
			je end_for_linie_matr1

			xorl %ebx,%ebx

			movl $0,-24(%ebp)
			for_coloana_matr2:
				movl -24(%ebp),%ecx
				cmp %ecx,20(%ebp)
				je end_for_coloana_matr2

				movl %ecx,%eax		#ecx*n
				mull 20(%ebp)

				movl (%esi,%eax,4),%eax
				movl -24(%ebp),%ecx
				pushl %ebx
				movl (%edi,%ecx,4),%ebx
				mull %ebx
				popl %ebx

				addl %eax,%ebx
				incl -24(%ebp)
				jmp for_coloana_matr2
			end_for_coloana_matr2:

			movl -28(%ebp),%eax
			movl -20(%ebp),%ecx
			movl %ebx,(%eax,%ecx,4)

			incl -20(%ebp)
			addl $4,%esi
			jmp for_linie_matr1
		end_for_linie_matr1:

		#incerc sa mut adresele pe liniile 2 ale matr_prod si matr1
		movl 20(%ebp),%eax
		sal $2,%eax

		addl %eax,%edi
		addl %eax,-28(%ebp)

		incl -16(%ebp)
		jmp for_linie_matrprod

	restaurare:

	subl $16,%esp
	popl %edi
	popl %esi
	popl %ebx
	popl %ebp
	ret

.global main
cerinta_1:
	movl $0,lineIndex
	for_lines:
		movl lineIndex,%ecx
		cmp %ecx,nrNoduri
		je et_exit

		movl $0,columnIndex
		for_columns:
			movl columnIndex,%ecx
			cmp %ecx,nrNoduri
			je continue 

			movl lineIndex,%eax
			mull nrNoduri
			addl columnIndex,%eax

			lea matrice,%edi
			movl (%edi,%eax,4),%ebx

			pushl %ebx
			pushl $formatPrintf
			call printf 
			popl %ebx
			popl %ebx

			pushl $0
			call fflush
			popl %ebx

			incl columnIndex
			jmp for_columns
	continue:
		incl lineIndex
		jmp for_lines
	
	jmp et_exit

drum_lungime_1:
	movl nodSursa,%eax
	mull nrNoduri
	addl nodDest,%eax
	lea matrice,%edi
	movl (%edi,%eax,4),%ebx
	movl %ebx,rezultat

	#afisare
	pushl rezultat
	pushl $formatPrintf2
	call printf 
	popl %ebx
	popl %ebx

	jmp et_exit

cerinta_2:
	pushl $lungime_drum
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $nodSursa
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $nodDest
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl $1,%eax
	cmp lungime_drum,%eax
	je drum_lungime_1

	lea matrice,%edi
	lea matrice2,%esi
	xorl %ecx,%ecx
	movl nrNoduri,%eax
	mull nrNoduri
	#crearea matricei 2
	loop_mat_2:
		cmp %ecx,%eax
		je et_sf_loop_mat_2

		movl (%edi,%ecx,4),%ebx
		movl %ebx,(%esi,%ecx,4)
		incl %ecx
		jmp loop_mat_2

	et_sf_loop_mat_2:

	movl $1,index
	loop_pt_calc_lung:
		movl index,%ecx
		cmp %ecx,lungime_drum
		je cont

		pushl nrNoduri
		pushl $matrice_produs
		pushl $matrice2
		pushl $matrice
		call matrix_mult
		addl $16,%esp 

		#matricea 2 = matricea produs
		lea matrice_produs,%edi
		lea matrice2,%esi
		xorl %ecx,%ecx
		movl nrNoduri,%eax
		mull nrNoduri
		#crearea matricei 2
		matrix_swap:
			cmp %ecx,%eax
			je matrix_swap_end

			movl (%edi,%ecx,4),%ebx
			movl %ebx,(%esi,%ecx,4)
			incl %ecx
			jmp matrix_swap
		matrix_swap_end:

		incl index
		jmp loop_pt_calc_lung
	cont:
	#iau valoarea de pe (i,j) din matricea produs
	movl nodSursa,%eax
	mull nrNoduri
	addl nodDest,%eax
	lea matrice_produs,%edi
	movl (%edi,%eax,4),%ebx
	movl %ebx,rezultat

	#afisare
	pushl rezultat
	pushl $formatPrintf2
	call printf 
	popl %ebx
	popl %ebx

	jmp et_exit

main:
	pushl $nrCerinta
	pushl $formatScanf
	call scanf 
	popl %ebx
	popl %ebx

	pushl $nrNoduri
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	lea v,%edi
	movl $0,index
	et_loop_vector:
		movl index,%ecx
		cmp %ecx,nrNoduri
		je et_continuare

		pushl $nrLegaturi
		pushl $formatScanf
		call scanf
		popl %ebx
		popl %ebx

		movl index,%ecx
		movl nrLegaturi,%eax
		movl %eax,(%edi,%ecx,4)
		incl index
		jmp et_loop_vector

	et_continuare:
		movl $0,index 

	et_loop_matrice_1:
		movl index,%ecx
		cmp %ecx,nrNoduri
		je et_cerinta

		movl (%edi,%ecx,4),%ebx
		movl %ebx,val
		movl $0,contor
		et_legatura:
			movl contor,%ecx
			cmp %ecx,val
			je et_loop_matrice_2

			movl index,%ebx
			movl %ebx,st

			pushl $dr
			pushl $formatScanf
			call scanf
			popl %ebx
			popl %ebx

			movl st,%eax	#completarea matricei
			mull nrNoduri
			addl dr,%eax
			lea matrice,%esi
			movl $1,(%esi,%eax,4)
			
			incl contor
			jmp et_legatura
	et_loop_matrice_2:
		incl index
		jmp et_loop_matrice_1


	et_cerinta:
		movl $1,%eax
		cmp nrCerinta,%eax
		je cerinta_1
		movl $2,%eax
		cmp nrCerinta,%eax
		je cerinta_2

et_exit:
	pushl $0
	call fflush
	popl %ebx
	
	movl $1,%eax
	xorl %ebx,%ebx
	int $0x80
	