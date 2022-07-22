# Processador-8-bits
Projeto e descrição em Verilog HDL de um processador de 8 bits uniciclo, baseado na arquitetura do MIPS.

Caminho de dados:
![datapath](https://user-images.githubusercontent.com/86082269/179384002-75c84c3a-e07d-49e4-b274-bfb55c29b0cd.png)

As etapas de IF - ID - EXE - MEM(R) acontecem durante o semiciclo positivo do clock.
As etapas de MEM(W) e REG WB ocorrem na borda de descida do clock.

Conjunto de instruções, tabela de controle e programas testados:
https://docs.google.com/spreadsheets/d/1jTgcv_d65m7bKRawLwDhGFnjqreM5VpYS6qBkbGyiEc/edit#gid=1924621090

Dentre as diferenças da arquitetura do MIPS, a mais significativa é de que todos os desvios necessitam de um endereço absoluto que deve ser setado no registrador rJump antes de qualquer instrução de desvio (beq, bne, beqz ou j), utilizando a instrucao sjmp (set jump).

## Simulação: Programas e casos de teste

O processador foi capaz de executar com sucesso, na simulação RTL, um algoritmo de BubbleSort e um algoritmo para encontrar o maior elemento de um vetor.

O código em código de máquina para o programa do BubbleSort pode ser encontrado no arquivo "m_inst_bubblesort.txt" e o código de máquina para o programa de encontrar o maior elemento de um vetor pode ser encontrado no arquivo "m_inst_maior.txt". Para carregar esses programas na memória de instruções, é necessário alterar o arquivo "memoria_instrucao.v", colocando o PATH completo na função $readmemb.

Para cada programa foram criados dois casos de teste, que podem ser encontrados nos arquivos "m_dado_teste_bs_10pos.txt", "m_dado_teste_bs_20pos.txt", "m_dado_teste_maior_10pos.txt", "m_dado_teste_maior_20pos.txt".Para carregar esses valores na memória de dados, é necessário alterar o arquivo "memoria_dados.txt", colocando o PATH completo na função $readmemb.

Ao se trocar o programa a ser executado, o arquivo "simulacao_processador.v" tambem deve ser alterado, trocando os comentários no bloco initial e no fim do bloco always, para escrever no console corretamente para cada programa executado.

### Bubblesort
<img src="https://user-images.githubusercontent.com/86082269/179384354-e6ff5385-2156-4594-b2b5-16e6196636ea.png" width="525">

Caso 1 - Vetor de 10 posições
<p float="left">
  <img src="https://user-images.githubusercontent.com/86082269/179384502-124b0bf5-ad32-4458-aa7b-057074978a41.png" width="215" /> 
  <img src="https://user-images.githubusercontent.com/86082269/179384476-730ca730-b0f9-41ad-908a-2209c89e57d1.png" width="150" />
</p>

Caso 2 - Vetor de 20 posições
<p float="left">
  <img src="https://user-images.githubusercontent.com/86082269/179384567-952afa59-3a0f-4282-a773-e73cfdf177cb.png" width="215" /> 
  <img src="https://user-images.githubusercontent.com/86082269/179384576-36882c57-1699-479d-b986-0cc36acb26a2.png" width="150" />
</p>

### Maior elemento
<img src="https://user-images.githubusercontent.com/86082269/179384636-cd89fa04-d758-46b6-a4fa-79656196fc40.png" width="500">

Caso 1 - Vetor de 10 posições
<p float="left">
  <img src="https://user-images.githubusercontent.com/86082269/179384706-6484a501-283b-4060-acb4-2aab0755fbe5.png" width="240" /> 
  <img src="https://user-images.githubusercontent.com/86082269/179384710-0cbed040-c59a-4302-9049-7e58cfce6e6a.png" width="500" />
</p>

Caso 2 - Vetor de 20 posições
<p float="left">
  <img src="https://user-images.githubusercontent.com/86082269/179384771-dc766f8b-3f87-42b0-8b29-ae8f9721af5b.png" width="240" /> 
  <img src="https://user-images.githubusercontent.com/86082269/179384776-f2d96a35-d007-41de-b0ea-7fb01615d57b.png" width="500" />
</p>
