# Repositório Spotmarket-Switcher

## Tradução LEIA-ME

[dinamarquês](README.da.md)-[Alemão](README.de.md)-[Holandês](README.nl.md)-[Inglês](README.md)-[estoniano](README.et.md)-[finlandês](README.fi.md)-[Francês](README.fr.md)-[grego](README.el.md)-[italiano](README.it.md)-[norueguês](README.no.md)-[Português](README.pt.md)-[Espanhol](README.es.md)-[sueco](README.sv.md)

## Bem-vindo ao repositório Spotmarket-Switcher!

O que este software está fazendo?
Este é um script de shell do Linux e liga o carregador de bateria e/ou soquetes comutáveis ​​​​no momento certo se os preços de energia dinâmica baseados em hora estiverem baixos.
Você pode então usar as tomadas para ligar um tanque de água quente, por exemplo, de forma muito mais barata, ou pode carregar automaticamente o armazenamento da bateria à noite, quando a energia eólica barata estiver disponível na rede.
O rendimento solar esperado pode ser levado em consideração através de uma API meteorológica e do armazenamento da bateria reservado em conformidade.
Os sistemas suportados são atualmente:

-   Produtos Shelly (como Shelly Plug S ou Shelly Plus1PM)
-   Tomadas comutáveis ​​AVM Fritz!DECT200 e 210
-   [Victron](https://www.victronenergy.com/)Venus OS Energy Storage Systems like Multiplus II.

O código é simples para que possa ser facilmente adaptado a outros sistemas de armazenamento de energia se você for capaz de controlar o carregamento por comandos do shell do Linux.
Por favor, dê uma olhada nas primeiras linhas do arquivo controller.sh para ver o que pode ser configurado pelo usuário.

## Fonte de dados

O software atualmente utiliza preços por hora EPEX Spot fornecidos por três APIs gratuitas (Tibber, aWATTar e Entso-E).
A API gratuita integrada Entso-E fornece dados sobre preços de energia dos seguintes países:
Albânia (AL), Áustria (AT), Bélgica (BE), Bósnia e Herz. (BA), Bulgária (BG), Croácia (HR), Chipre (CY), República Checa (CZ), Dinamarca (DK), Estónia (EE), Finlândia (FI), França (FR), Geórgia (GE), Alemanha (DE), Grécia (GR), Hungria (HU), Irlanda (IE), Itália (IT), Kosovo (XK), Letónia (LV), Lituânia (LT), Luxemburgo (LU), Malta (MT), Moldávia (MD), Montenegro (ME), Países Baixos (NL), Macedónia do Norte (MK), Noruega (NO), Polónia (PL), Portugal (PT), Roménia (RO), Sérvia (RS), Eslováquia (SK) , Eslovénia (SI), Espanha (ES), Suécia (SE), Suíça (CH), Turquia (TR), Ucrânia (UA), Reino Unido (UK) ver[Plataforma Entso-E de Transparência](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Instalação

Configurar o Spotmarket-Switcher é um processo simples. Se você já estiver executando uma máquina baseada em UNIX, como macOS, Linux ou Windows com o subsistema Linux, siga estas etapas para instalar o software:

1.  Baixe o script de instalação do repositório GitHub usando[este hiperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)ou execute o seguinte comando em seu terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Execute o script do instalador com opções adicionais para preparar tudo em um subdiretório para sua inspeção. Por exemplo:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    If you're using Victron Venus OS, the correct DESTDIR should be `/`(o diretório raiz). Sinta-se à vontade para explorar os arquivos instalados em`/tmp/foo`.

Observe que, embora este software esteja atualmente otimizado para o sistema operacional Venus, ele pode ser adaptado para outros dispositivos Linux, como Raspberry PI. O desenvolvimento futuro poderá melhorar a compatibilidade com outros sistemas.

### Acesso ao sistema operacional Venus

For instructions on accessing the Venus OS, please refer to <https://www.victronenergy.com/live/ccgx:root_access>.

### Execução do script de instalação

-   Se você estiver usando o sistema operacional Victron Venus:
    -   Executar`victron-venus-os-install.sh`para baixar e instalar o Spotmarket-Switcher.
    -   Edite as variáveis ​​com um editor de texto em`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Configure um cronograma de cobrança de ESS (consulte a captura de tela fornecida). No exemplo, a bateria carrega até 50% à noite se estiver ativada, outros horários de carregamento do dia são ignorados. Caso não queira, crie uma programação para todas as 24 horas do dia. Lembre-se de desativá-lo após a criação. Verifique se a hora do sistema (conforme mostrado na captura de tela) está correta.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

-   Se você estiver usando outro sistema operacional:
    -   Copie o script de shell (`controller.sh`) para um local personalizado e ajuste as variáveis ​​de acordo com suas necessidades.
    -   Crie um crontab ou outro método de agendamento para executar este script no início de cada hora.
    -   Exemplo de Crontab:
          Use a seguinte entrada crontab para executar o script de controle a cada hora:
          Abra seu terminal e digite`crontab -e`e insira a seguinte linha:
            0 * * * * /path/to/controller.sh

### Apoio e Contribuição

Se você considera este projeto valioso, considere patrocinar e apoiar o desenvolvimento futuro por meio destes links:

-   [Revolução](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Além disso, se você estiver na Alemanha e estiver interessado em mudar para uma tarifa dinâmica de eletricidade, poderá apoiar o projeto inscrevendo-se usando este[Tibber (link de referência)](https://invite.tibber.com/ojgfbx2e). Você e o projeto receberão um bônus de 50 euros em hardware. Observe que um medidor inteligente ou Pulse-IR é necessário para uma tarifa horária (<https://tibber.com/de/store/produkt/pulse-ir>) .

Se necessita de uma tarifa de gás natural ou prefere uma tarifa clássica de eletricidade, ainda pode apoiar o projeto[Energia do Polvo (link de referência)](https://share.octopusenergy.de/glass-raven-58).
Você recebe um bônus de 50 euros para você e também para o projeto.
Octopus tem a vantagem de os contratos normalmente terem prazo apenas mensal. São ideais, por exemplo, para pausar uma tarifa baseada em preços de bolsa.

## Isenção de responsabilidade

Observe os termos de uso em<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/dev/License.md>
