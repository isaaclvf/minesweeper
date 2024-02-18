# Projeto Minesweeper MIPS

Este projeto implementa o jogo Minesweeper em linguagem Assembly MIPS, dividindo o código em vários arquivos para facilitar a organização. Cada funcionalidade do jogo está contida em um arquivo separado.

## Estrutura do Repositório

- **main.asm**: Contém a função principal (main) que controla o fluxo do jogo em Assembly MIPS.
- **printboard.asm**: Implementa a função para imprimir o tabuleiro.
- **initializeboard.asm**: Implementa a função para inicializar o tabuleiro.
- **plantbombs.asm**: Implementa a função para posicionar as bombas no tabuleiro.
- **macros.asm**: Contém macros úteis para facilitar o desenvolvimento em MIPS.
- **Mars.jar**: Executável do Mars MIPS, necessário para rodar os arquivos .asm.
- **minesweeper.c**: Contém a implementação em C do jogo Minesweeper. Este arquivo serve como referência para a lógica do jogo e pode ser utilizado para comparação com as implementações em Assembly MIPS.
- **play.asm**, **checkvictory.asm**, **revealcells.asm**: Arquivos em branco. Os alunos devem implementar essas funções em Assembly MIPS.

## Relatorio de Construção de Função
- **countAdjacentBombs.asm**:
	Nesta função, como todas as outras, começamos dando um save_context e movendo os parâmetros da função contidos em $a para registradores. Nesta função recebemos o tabuleiro, bem como o valores de linha e coluna. Após isso, para verificar as bombas ao redor da célula, temos que fazer verificações na linha imediatamente anterior e imediatamente posterior da celular (o mesmo para a coluna), para isso somamos e diminuímos 1 para os dois parâmetros e guardamos em registradores.
Iniciamos os labels onde serão feitas as verificações para efetuar os laços de repetições for:
	No começo de cada laço i e j fazemos bgt(branch if greather than) para delimitar as margens do tabuleiro, com os parâmetros guardados nos registradores e levando ao label de fim de execução de for.
	Dentro das labels de for ainda, fazemos as 5 verificações da função. Na verificação do núcleo, se chegar nela, fazemos uma interação no contador. Caso uma das verificações não seja favorável fazemos um jump para a label endif.
	Na label endif fazemos as interações de i e j e damos um jump para a continuação ou não dos laços de repetição.
No label end_for_i, que é o laço de repetição mais externo, temos o final da nossa função, onde movemos para $v0 o retorno da nossa função e retomamos o contexto dela.

- **play.asm**:
- **checkvictory.asm**:
	Nesta função, como todas as outras, começamos dando um save_context e movendo os parâmetros da função contidos em $a para registradores. Após isso inicializamos o contador, que começa em zero, e fazemos os laços de repetição for, com i e j indo de zero até o tamanho da borda do tabuleiro mediante bge (branch if greater or equal), para pular, em caso verdadeiro, para a label end_for.
	No núcleo das funções for acessamos na memória o local do tabuleiro com sll (shift left logical) e a partir disso fazemos a verificação com bltz (branch if less than zero), caso seja, pula para o label skip_count, caso não o registrador estabelecido para ser o contador é iterado. 
	No label skip_count fazemos a interações dos registradores referentes a i e j e damos um jump para os laços.
	No label end_for_i_it, o label do final do laço de repetição mais externo, temos o valor 0 sendo retornado para o registrados de resposta de função, logo após isso é feita uma verificação blt (branch if lass than) entre o registrador contador e o número de células vazias (sem bombas), caso esse número seja menor, pulamos para o label finish que encerra a função, caso seja maior, a próxima linha carrega 1 para o registrador de resposta de função ($v)e após isso também encerra a função no label finish.
- **revealcells.asm**:
  
## Instruções de Execução

### Requisitos

O arquivo executável Mars.jar está incluído neste repositório.

### Execução do Código em C

1. Abra o terminal na pasta do repositório.
2. Compile o código C usando um compilador padrão C, como o GCC, com o seguinte comando:

   ```bash
   gcc minesweeper.c -o minesweeper
   ```
3. Execute o executável gerado:

   ```bash
   ./minesweeper
   ```
4. Siga as instruções no console para jogar o Minesweeper em C.

### Execução dos Arquivos em Assembly MIPS

1. Abra o terminal na pasta do repositório.
2. Execute o Mars MIPS digitando o seguinte comando:

   ```bash
   java -jar Mars.jar
   ```
3. No Mars MIPS, abra cada arquivo .asm individualmente e monte/executa o código. 
4. A saída do jogo será exibida na console do Mars MIPS.

### Observações

1. As macros no arquivo macros.asm foram criadas para simplificar o desenvolvimento e podem ser utilizadas conforme necessário.
2. Este projeto foi desenvolvido para a disciplina de Arquitetura de Computadores, período 2023.2, pelo professor Ramon Nepomuceno na UFCA.

Divirta-se jogando Minesweeper em Assembly MIPS!
