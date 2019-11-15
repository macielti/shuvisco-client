
![Banana](https://cdn.pixabay.com/photo/2019/04/03/04/47/rainbow-4099502_960_720.jpg)

# Projeto Shuvisco

É de conhecimento público que os níveis de qualidade dos serviços de acesso a internet fixa disponíveis em cidades pequenas do nordeste do Brasil não refletem o valor que é cobrado a seus consumidores, e este problema é agravado mais ainda nos períodos chuvosos. Para lutar por uma qualidade de serviço melhor criei o projeto Shuvisco.

O projeto Shuvisco trata-se da personalização do sistema de roteadores para que os mesmos atuem como fiscais da qualidade de sua rede, registrando períodos em que a internet não está funcionando e gerando relatórios para que o usuário possa solicitar descontos na conta devido as interrupções dos serviços. O desconto na conta de internet devido ao motivo supracitado é um direito assegurado pela Resolução 614/2013 da Agência Nacional de Telecomunicações (Anatel).

> Caso ocorra a interrupção do serviço pela prestadora, a Prestadora deve descontar do total do plano o valor proporcional ao número de horas ou fração superior a 30 minutos.
>  https://www.anatel.gov.br/consumidor/banda-larga/direitos/interrupcao-do-servico

Os dados coletados também podem ser utilizados para realizar análises empíricas e comparações com a finalidade de eleger qual provedor oferece o melhor serviço (ou o menos pior).

## FAQ

1. **Como o teste de conexão é realizado?** É realizada uma tentativa de conexão ao servidor de DNS mais rápido do mundo, "1.1.1.1". Se a conexão for bem sucedida, consideramos que a sua internet está em bom estado.

2. **A minha internet vai ficar mais lenta com estes testes?** Não. O teste de conexão foi pensado objetivando o menor consumo possível da sua conexão com a internet, sendo assim, este teste não deve influenciar na sua conexão.

3. **Minha provacidade é afetada? Que dados são coletados?** Os testes não afetam a privacidade dos seus dados. Os dados coletados são o estado da sua conexão representado pelos números 1 (sem internet) e 0 (internet boa), data, hora, minuto e segundo em que o teste foi realizado. Como na tabela abaixo:

| Data, Hora, Minuto e Segundos  | Estado da Internet| Número de Pacotes Enviados|Número de Pacotes Bem Sucedidos|Servidor de Ping|
|--------|---------------|---------------|---------------|---------------|
| 1573273877      |    1 | 60| 30 |1.1.1.1|
| 1573273677      |    0 |60| 48|1.1.1.1|
| 1573273777    |    1 |60| 25|1.1.1.1|
| 1573273987     |    0 |60|59|1.1.1.1|

**Observação:**  A informação referente ao relógio é armazenada em um formato especial chamado Unix Timestamp.

## Instalação do Cliente

Primeiramente instale as dependências:

    # opkg update
    # opkg install autossh

No diretório `/root/` baixe o instalador:

    # wget https://github.com/macielti/shuvisco-client/blob/master/install.run?raw=true

Adicione a permissão de execução ao instalador:

    # chmod +x install.run

Execute o instalador (você precisa executar o instalador no diretório `/root/`)

    # ./install.run

A execução do instalador vai gerar um arquivo de configuração de acesso a API do servidor no diretório `/etc/shuvisco.conf`. Você precisa configurar as suas credenciais de acesso, a primeira é o `SERVEO` que é o sudomínio de acesso remoto ao roteador, o segundo é o `ROUTER_ID` que é o código identificador dos registros do roteador no banco de dados. Sendo assim, adicione as seguintes duas linhas de configuração no final do arquivo `/etc/shuvisco.conf`. Preencha os valores removendo os sinais `<>`:

    SERVEO="<sudomínio de acesso remoto ao roteador>"
    ROUTER_ID="<código identificador dos registros do roteador no banco de dados>"

O último passo é a reinicialização do roteador para que as alterações façam efeito.

