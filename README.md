<!-- 
  Tags: DadosIA
  Label: 📈 Analise de dados R
  Description: Análise de Vendas de uma Loja de Varejo
  path_hook: hookfigma.hook1
-->


![Screenshot](images/r.png)

### Visão Geral do Projeto

Este projeto consiste em uma análise de dados de vendas utilizando a linguagem R. A análise inicial está contida no script `analise_vendas.R`. O objetivo principal é gerar um relatório de vendas dinâmico e visualmente atraente, que pode ser exportado para diferentes formatos, como HTML.

---

### Estrutura
![Screenshot](images/r.png)

---

### 1. Dashboard Interativo com Shiny

Com o Shiny, o projeto deixa de ser um script estático e se transforma em um **aplicativo web interativo**.

* **O que você faria:** Em vez de rodar o `Rscript`, você criaria um arquivo `app.R` que executaria o Shiny.
* **A experiência do usuário:** A pessoa que acessasse o seu aplicativo veria uma página web. Nessa página, ela poderia usar um seletor para escolher a região (Norte, Sul, Leste, Oeste) ou um controle de data para filtrar as vendas.
* **O resultado:** Os gráficos e as tabelas seriam atualizados instantaneamente para mostrar os dados apenas da região ou período selecionado. Isso torna a análise muito mais dinâmica e útil para quem a consome.

#### Como usar:

    ```R
    # Instale os pacotes (faça isso apenas uma vez)
    install.packages("shiny", repos = "https://vps.fmvz.usp.br/CRAN/")
    install.packages("tidyverse", repos = "https://vps.fmvz.usp.br/CRAN/")

    # Carregue os pacotes no seu script (app.R)
    library(shiny)
    library(tidyverse)
    ```

Para executar o dashboard interativo, siga estes passos no console do R:

1.  Crie um arquivo chamado **`app.R`** com a estrutura do seu aplicativo Shiny.
2.  Execute o seguinte comando para iniciar o aplicativo:

    ```R
    shiny::runApp("app.R")
    ```

Isso fará com que o aplicativo seja executado e aberto em seu navegador, pronto para ser utilizado.

---

### 2. Relatório Dinâmico com R Markdown

Com o R Markdown, o projeto se torna um relatório completo e formatado, que combina o código, o texto e os resultados em um único documento (como um PDF ou HTML).

* **O que você faria:** Você escreveria a análise em um arquivo `analise_vendas.Rmd` (em vez de `.R`).
* **A experiência do usuário:** O leitor veria um documento elegante, com um título, introdução e os resultados da análise. O código do R ficaria em blocos, e os gráficos e tabelas (top_produtos_quantidade, top_categorias_receita) apareceriam diretamente no documento.
* **O resultado:** Seria um relatório fácil de compartilhar e que pode ser gerado automaticamente, ideal para apresentações ou para relatórios mensais.

#### Como usar:

    ```R
    # Instale os pacotes (faça isso apenas uma vez)
    install.packages("rmarkdown", repos = "https://vps.fmvz.usp.br/CRAN/")
    install.packages("knitr", repos = "https://vps.fmvz.usp.br/CRAN/")
    install.packages("tidyverse", repos = "https://vps.fmvz.usp.br/CRAN/")
    
    # Carregue o pacote no seu arquivo .Rmd
    library(tidyverse)
    ```

Para gerar o documento final, siga estes passos no console do R:

1.  Se estiver no terminal Bash, digite `R` para entrar no console.
2.  Rode o seguinte comando:

    ```R
    rmarkdown::render("relatorio_vendas.Rmd")
    ```

Isso criará um arquivo chamado **`relatorio_vendas.html`** na mesma pasta. Ao abrir esse arquivo no seu navegador, você verá o relatório completo, com o texto formatado, as tabelas e os gráficos.

---

### 3. Serviço de Análise com Plumber

Com o Plumber, o projeto seria transformado em um **serviço (API)** que outras aplicações poderiam usar.

* **O que você faria:** Você reestruturaria o seu código em funções e as anotaria com `@get /top-produtos` e `@get /receita-por-categoria`.
* **A experiência do usuário:** A pessoa não veria um script ou uma interface, mas sim um serviço rodando na web.
* **O resultado:** Um desenvolvedor de um aplicativo móvel, por exemplo, poderia enviar uma requisição HTTP para `https://meu-servico-r.com/top-produtos` e receberia a tabela dos produtos mais vendidos como uma resposta JSON, que ele poderia usar na sua própria aplicação.

#### Como usar:

    ```R
    # Instale os pacotes (faça isso apenas uma vez)
    install.packages("plumber", repos = "https://vps.fmvz.usp.br/CRAN/")
    install.packages("tidyverse", repos = "https://vps.fmvz.usp.br/CRAN/")
    
    # Carregue os pacotes no seu arquivo plumber.R
    library(plumber)
    library(tidyverse)
    ```

Para expor suas funções como uma API, siga estes passos no console do R:

1.  Crie um arquivo `plumber.R` com suas funções anotadas.
2.  Execute o seguinte comando para iniciar o serviço:

    ```R
    pr <- plumber::pr("plumber.R")
    plumber::pr_run(pr, port = 8000)
    ```

O serviço estará disponível na porta 8000. Você poderá testá-lo fazendo uma requisição HTTP, como, por exemplo, `GET http://localhost:8000/top-produtos`.
## Tabela de Testes da API (Plumber)

### Endpoint: `/top-produtos`

| Teste | Descrição | Método | URL | Resultado Esperado |
| :--- | :--- | :--- | :--- | :--- |
| **1. Requisição Básica** | Obter a lista dos produtos mais vendidos sem filtros. | `GET` | `http://localhost:8000/top-produtos` | Uma tabela com todos os produtos e a contagem total de unidades vendidas. |
| **2. Filtrar por Região** | Obter os produtos mais vendidos apenas na região **`Norte`**. | `GET` | `http://localhost:8000/top-produtos?regiao=Norte` | Uma tabela com os produtos e a contagem de vendas filtrada pela região "Norte". |
| **3. Filtrar por Data** | Obter os produtos vendidos entre duas datas específicas. | `GET` | `http://localhost:8000/top-produtos?data_inicio=2023-03-01&data_fim=2023-03-31` | Uma tabela com os produtos e a contagem de vendas realizadas apenas em março de 2023. |
| **4. Combinar Filtros** | Obter os produtos mais vendidos na região **`Sul`** em um período de tempo. | `GET` | `http://localhost:8000/top-produtos?regiao=Sul&data_inicio=2023-06-01&data_fim=2023-08-31` | Uma tabela com os produtos e a contagem de vendas na região "Sul" no período de junho a agosto. |
| **5. Parâmetro Inexistente** | Usar uma região que não existe nos dados. | `GET` | `http://localhost:8000/top-produtos?regiao=Centro` | Uma tabela vazia ou uma contagem de vendas igual a zero, pois não há dados para a região "Centro". |

---

### Endpoint: `/receita-por-categoria`

| Teste | Descrição | Método | URL | Resultado Esperado |
| :--- | :--- | :--- | :--- | :--- |
| **1. Requisição Básica** | Obter a receita total por categoria sem filtros. | `GET` | `http://localhost:8000/receita-por-categoria` | Uma tabela com as categorias e a receita total gerada por cada uma. |
| **2. Filtrar por Região** | Obter a receita por categoria apenas na região **`Leste`**. | `GET` | `http://localhost:8000/receita-por-categoria?regiao=Leste` | Uma tabela com as categorias e a receita total filtrada pela região "Leste". |
| **3. Filtrar por Data** | Obter a receita por categoria em um período de tempo. | `GET` | `http://localhost:8000/receita-por-categoria?data_inicio=2023-01-01&data_fim=2023-02-28` | Uma tabela com as categorias e a receita total gerada em janeiro e fevereiro de 2023. |
| **4. Combinar Filtros** | Obter a receita por categoria na região **`Oeste`** em um período de tempo. | `GET` | `http://localhost:8000/receita-por-categoria?regiao=Oeste&data_inicio=2023-09-01&data_fim=2023-11-30` | Uma tabela com as categorias e a receita total na região "Oeste" no período de setembro a novembro. |
| **5. Parâmetro Inexistente** | Usar uma data de início posterior à data de fim. | `GET` | `http://localhost:8000/receita-por-categoria?data_inicio=2023-12-31&data_fim=2023-01-01` | Uma tabela vazia, pois não haverá dados que correspondam a esse período de tempo. |

---

### Tabela Comparativa

| | **Projeto Atual (Script)** | **Com Shiny** | **Com R Markdown** | **Com Plumber** |
| :--- | :--- | :--- | :--- | :--- |
| **Saída** | Texto no terminal e imagens .png | Web app interativo | Relatório .html ou .pdf | JSON, XML, etc. |
| **Foco** | Análise e resultados brutos | Interação com o usuário | Apresentação e narrativa | Integração com outros sistemas |
| **Como usar** | `Rscript` | Abrir um navegador | Ler o documento | Fazer uma requisição HTTP |


## 👨‍💻 Autor

[Fabiano Rocha/Fabiuniz](https://github.com/SeuUsuarioGitHub)

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
