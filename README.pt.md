<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[Tcheco](README.cs.md)-[dinamarquês](README.da.md)-[Alemão](README.de.md)-[Inglês](README.md)-[Espanhol](README.es.md)-[estoniano](README.et.md)-[finlandês](README.fi.md)-[Francês](README.fr.md)-[grego](README.el.md)-[italiano](README.it.md)-[Holandês](README.nl.md)-[norueguês](README.no.md)-[polonês](README.pl.md)-[Português](README.pt.md)-[sueco](README.sv.md)-[japonês](README.ja.md)

## Bem-vindo ao repositório Spotmarket-Switcher!

O que este software está fazendo?
Spotmarket-Switcher é uma ferramenta de software fácil de usar que ajuda você a economizar dinheiro em suas contas de energia. Se você possui um carregador de bateria inteligente ou dispositivos como aquecedores de água que podem ligar e desligar automaticamente, esta ferramenta é perfeita para você! Ele liga seus dispositivos de forma inteligente quando os preços da energia estão baixos, especialmente útil se os custos de energia mudam a cada hora.

Este resultado típico demonstra a capacidade do Spotmarket-Switcher de automatizar o uso de energia de forma eficiente, não apenas economizando custos, mas também otimizando o uso de fontes de energia renováveis. É um excelente exemplo de como a tecnologia inteligente pode ser utilizada para gerir o consumo de energia de uma forma mais sustentável e económica. (azul = uso de bateria, vermelho = rede, amarelo = solar)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Uso noturno: Durante a noite, quando os preços da energia estavam mais baixos, o Spotmarket-Switcher ativou de forma inteligente uma tomada comutável para ligar a bomba de calor de água quente (pico indicado em vermelho). Isto mostra a capacidade do sistema de identificar e utilizar períodos de energia de baixo custo para tarefas que consomem muita energia.
-   Eficiência Econômica no Carregamento da Bateria: O programa decidiu estrategicamente não carregar o armazenamento da bateria neste momento. Esta decisão baseou-se numa verificação económica que teve em conta as perdas de cobrança e as comparou com os preços médios ou mais elevados da energia do dia. Essa abordagem garante que o carregamento da bateria ocorra somente quando for mais econômico.
-   Uso ideal da bateria nos horários de pico: No gráfico, os horários de energia mais caros são indicados pela manhã e à noite. Durante estes períodos, o Spotmarket-Switcher utilizou a energia armazenada da bateria (mostrada em azul), evitando assim elevados custos de eletricidade. Esta é uma estratégia inteligente para reduzir despesas de energia, utilizando energia armazenada quando é mais caro extraí-la da rede.
-   Reserva de Bateria para Horas de Alto Custo: Após os períodos de alto custo, o Sistema de Armazenamento de Energia (ESS) da bateria foi desligado. Não estava vazio à noite, por volta das 20:00. Esta ação foi tomada para reservar capacidade suficiente da bateria para as próximas horas caras da manhã seguinte. É uma abordagem inovadora que antecipa futuros períodos de custos elevados e garante que a energia armazenada esteja disponível para compensar esses custos.

Por que usar o Spotmarket-Switcher?

-   Economize dinheiro: liga seus aparelhos quando a energia está mais barata, reduzindo suas contas.
-   Eficiência Energética: Ao usar energia quando há excesso (como noites de vento), você contribui para um planeta mais verde.
-   Uso inteligente: carregue automaticamente o armazenamento da bateria ou ligue dispositivos como aquecedores de água nos melhores horários.

Os sistemas suportados são atualmente:

-   Produtos Shelly (como[Plugue Shelly S](https://shellyparts.de/products/shelly-plus-plug-s)ou[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)e[210](https://avm.de/produkte/smart-home/fritzdect-210/)tomadas comutáveis
-   [Victron](https://www.victronenergy.com/)Sistemas de armazenamento de energia Venus OS como o[MultiPlus-II series](https://www.victronenergy.com/inverters-chargers)

Começando:

-   Baixe e instale: O processo de configuração é simples. Baixe o script, ajuste algumas configurações e você estará pronto para começar.
-   Programe e relaxe: configure-o uma vez e ele será executado automaticamente. Sem complicações diárias!

Interessado?

-   Confira nossas instruções detalhadas para diferentes sistemas, como configurações do sistema operacional Victron Venus, Windows ou Linux. Garantimos que as etapas sejam fáceis de seguir.
-   Junte-se a nós para tornar o uso de energia mais inteligente e econômico! Para qualquer dúvida, sugestão ou feedback, sinta-se à vontade para entrar em contato.

O código é simples para que possa ser facilmente adaptado a outros sistemas de armazenamento de energia se você for capaz de controlar o carregamento por comandos shell do Linux.
Por favor, dê uma olhada em controller.sh e pesquise charger_command_turnon para ver como ele pode ser facilmente adaptado.
Crie um fork do github e compartilhe sua personalização para que outros usuários possam se beneficiar dele.

## Fonte de dados

O software atualmente utiliza preços por hora EPEX Spot fornecidos por três APIs gratuitas (Tibber, aWATTar e Entso-E).
A API gratuita integrada Entso-E fornece dados sobre preços de energia dos seguintes países:
Albânia (AL), Áustria (AT), Bélgica (BE), Bósnia e Herz. (BA), Bulgária (BG), Croácia (HR), Chipre (CY), República Checa (CZ), Dinamarca (DK), Estónia (EE), Finlândia (FI), França (FR), Geórgia (GE), Alemanha (DE), Grécia (GR), Hungria (HU), Irlanda (IE), Itália (IT), Kosovo (XK), Letónia (LV), Lituânia (LT), Luxemburgo (LU), Malta (MT), Moldávia (MD), Montenegro (ME), Países Baixos (NL), Macedónia do Norte (MK), Noruega (NO), Polónia (PL), Portugal (PT), Roménia (RO), Sérvia (RS), Eslováquia (SK) , Eslovénia (SI), Espanha (ES), Suécia (SE), Suíça (CH), Turquia (TR), Ucrânia (UA), Reino Unido (UK) ver[Plataforma Entso-E de Transparência](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)

## Instalação

Configurar o Spotmarket-Switcher é um processo simples. Se você já estiver executando uma máquina baseada em UNIX, como macOS, Linux ou Windows com o subsistema Linux, siga estas etapas para instalar o software:

1.  Baixe o script de instalação do repositório GitHub usando[este hiperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)ou execute o seguinte comando em seu terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Execute o script do instalador com opções adicionais para preparar tudo em um subdiretório para sua inspeção. Por exemplo:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Se você estiver usando Victron Venus OS, o DESTDIR correto deve ser`/`(o diretório raiz). Sinta-se à vontade para explorar os arquivos instalados em`/tmp/foo`.
    Em um Cerbo GX o sistema de arquivos é montado somente leitura. Ver<https://www.victronenergy.com/live/ccgx:root_access>. Para tornar o sistema de arquivos gravável, você precisa executar o seguinte comando antes de executar o script de instalação:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Observe que, embora este software esteja atualmente otimizado para o sistema operacional Venus, ele pode ser adaptado para outros tipos de Linux, como Debian/Ubuntu em um Raspberry Pi ou outra placa pequena. Um candidato principal é certamente[OpenWRT](https://www.openwrt.org). Usar uma máquina desktop é adequado para fins de teste, mas quando usado 24 horas por dia, 7 dias por semana, seu maior consumo de energia é preocupante.

### Acesso ao sistema operacional Venus

Para obter instruções sobre como acessar o Venus OS, consulte<https://www.victronenergy.com/live/ccgx:root_access>.

### Execução do script de instalação

-   Se você estiver usando o sistema operacional Victron Venus:
    -   Em seguida, edite as variáveis ​​com um editor de texto em`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Configure um cronograma de cobrança de ESS (consulte a captura de tela fornecida). No exemplo, a bateria carrega à noite até 50% se ativada, outros horários de carregamento do dia são ignorados. Caso não queira, crie uma programação para todas as 24 horas do dia. Lembre-se de desativá-lo após a criação. Verifique se a hora do sistema (conforme mostrado no canto superior direito da tela) está correta.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

A captura de tela mostra a configuração do carregamento automatizado durante os horários definidos pelo usuário. Desativado por padrão, pode ser ativado temporariamente pelo script.

-   Instruções para instalar o Spotmarket-Switcher num sistema Windows 10 ou 11 para testes sem dispositivos Victron (apenas tomadas comutáveis).

    -   lançar`cmd.exe`como administrador
    -   Digitar`wsl --install -d Debian`
    -   Digite um novo nome de usuário como`admin`
    -   Insira uma nova senha
    -   Digitar`sudo su`e digite sua senha
    -   Digitar`apt-get update && apt-get install wget curl`
    -   Continue com a descrição manual do Linux abaixo (o script do instalador não é compatível).
    -   Não se esqueça que se você fechar o shell, o Windows irá parar o sistema.


-   Se você estiver usando um sistema Linux como Ubuntu ou Debian:
    -   Copie o script de shell (`controller.sh`) para um local personalizado e ajuste as variáveis ​​de acordo com suas necessidades.
    -   os comandos são`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`e para editar suas configurações use`vi /path/to/save/config.txt`
    -   Crie um crontab ou outro método de agendamento para executar este script no início de cada hora.
    -   Exemplo de Crontab:
          Use a seguinte entrada crontab para executar o script de controle a cada hora:
          Abra seu terminal e digite`crontab -e`e insira a seguinte linha:`0 * * * * /path/to/controller.sh`

### Apoio e Contribuição: +1:

Se você considera este projeto valioso, considere patrocinar e apoiar o desenvolvimento futuro por meio destes links:

-   [Revolução](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Se você é da Alemanha e está interessado em mudar para uma tarifa dinâmica de eletricidade, você pode apoiar o projeto inscrevendo-se usando este[Tibber (link de referência)](https://invite.tibber.com/ojgfbx2e)ou digitando o código`ojgfbx2e`em seu aplicativo. Você e o projeto receberão**Bônus de 50 euros para hardware**. Observe que um medidor inteligente ou Pulse-IR é necessário para uma tarifa horária (<https://tibber.com/de/store/produkt/pulse-ir>).
Se necessita de uma tarifa de gás natural ou prefere uma tarifa clássica de eletricidade, ainda pode apoiar o projeto[Energia do Polvo (link de referência)](https://share.octopusenergy.de/glass-raven-58).
Você recebe um bônus (a oferta varia**entre 50 e 120 euros**) para você e também para o projeto.
Octopus tem a vantagem de algumas ofertas não terem prazo mínimo de contrato. São ideais, por exemplo, para pausar uma tarifa baseada em preços de bolsa.

Se você é da Áustria, pode nos apoiar usando[aWATTar Áustria (link de referência)](https://www.awattar.at/services/offers/promotecustomers). Por favor, faça uso`3KEHMQN2F`como código.

## Isenção de responsabilidade

Observe os termos de uso em<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>
