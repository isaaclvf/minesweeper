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

## Relatório de Construção de Função
### countAdjacentBombs.asm

Nesta função, como todas as outras, começamos dando um save_context e movendo os parâmetros da função contidos em $a para registradores. Nesta função recebemos o tabuleiro, bem como o valores de linha e coluna. Após isso, para verificar as bombas ao redor da célula, temos que fazer verificações na linha imediatamente anterior e imediatamente posterior da celular (o mesmo para a coluna), para isso somamos e diminuímos 1 para os dois parâmetros e guardamos em registradores.

Iniciamos os labels onde serão feitas as verificações para efetuar os laços de repetições for:

No começo de cada laço i e j fazemos bgt(branch if greather than) para delimitar as margens do tabuleiro, com os parâmetros guardados nos registradores e levando ao label de fim de execução de for.

Dentro das labels de for ainda, fazemos as 5 verificações da função. Na verificação do núcleo, se chegar nela, fazemos uma interação no contador. Caso uma das verificações não seja favorável fazemos um jump para a label endif.

Na label endif fazemos as interações de i e j e damos um jump para a continuação ou não dos laços de repetição.

No label end_for_i, que é o laço de repetição mais externo, temos o final da nossa função, onde movemos para $v0 o retorno da nossa função e retomamos o contexto dela.

### play.asm

A função play é responsável por calcular as jogadas e dar continuação às partidas. A forma que ela foi implementada foi a seguida. 

Primeiro, a função inicia salvando o contexto da função. Em seguida, os argumentos passados para a função são movidos para registradores específicos, facilitando o acesso a eles durante a execução. Ela então calcula o índice correspondente à posição na matriz, considerando a linha e a coluna fornecidas como entrada. Após calcular o índice, o código carrega o valor contido nessa posição da matriz.

Após carregar o valor, são feitas verificações para determinar se o valor é -1 ou -2. Caso seja -1 (bomba), a função define o valor de retorno como 0 e encerra a execução. Se o valor for -2 (vazio), o código continua sua execução, armazenando a posição atual na matriz e chamando a função countAdjacentBombs para contar o número de bombas adjacentes. O resultado retornado por countAdjacentBombs é então armazenado na posição da matriz correspondente à posição atual.

Após atualizar a matriz, o código verifica se o valor retornado por countAdjacentBombs é diferente de zero. Se for, a função retorna 1, encerrando a execução. Caso contrário, a função chama a função revealNeighboringCells e continua a execução do jogo. Após todas as operações, o contexto da função é restaurado e o valor adequado é retornado.


### checkVictory.asm

Nesta função, como todas as outras, começamos dando um save_context e movendo os parâmetros da função contidos em $a para registradores. Após isso inicializamos o contador, que começa em zero, e fazemos os laços de repetição for, com i e j indo de zero até o tamanho da borda do tabuleiro mediante bge (branch if greater or equal), para pular, em caso verdadeiro, para a label end_for.
	
No núcleo das funções for acessamos na memória o local do tabuleiro com sll (shift left logical) e a partir disso fazemos a verificação com bltz (branch if less than zero), caso seja, pula para o label skip_count, caso não o registrador estabelecido para ser o contador é iterado. 

No label skip_count fazemos a interações dos registradores referentes a i e j e damos um jump para os laços.
	
No label end_for_i_it, o label do final do laço de repetição mais externo, temos o valor 0 sendo retornado para o registrados de resposta de função, logo após isso é feita uma verificação blt (branch if lass than) entre o registrador contador e o número de células vazias (sem bombas), caso esse número seja menor, pulamos para o label finish que encerra a função, caso seja maior, a próxima linha carrega 1 para o registrador de resposta de função ($v)e após isso também encerra a função no label finish.


### revealNeighboringCells.asm

Essa função tem como objetivo revelar as células vizinhas a uma determinada célula. A função começa reservando espaço na pilha e salvando o endereço de retorno. Em seguida, salva o contexto da função e move os argumentos recebidos para registradores específicos para facilitar o acesso.

A função então itera sobre as células vizinhas à célula fornecida, começando da célula acima e à esquerda até a célula abaixo e à direita. Para cada célula vizinha, a função verifica se a célula está dentro dos limites da matriz e se já foi revelada. Se a célula vizinha atender a essas condições, a função chama a função countAdjacentBombs para contar o número de bombas adjacentes e atualiza o valor da célula vizinha com esse número.

Após iterar sobre todas as células vizinhas e atualizar seus valores, a função restaura o contexto e o endereço de retorno, liberando o espaço reservado na pilha, e retorna para a função chamadora.

  
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
