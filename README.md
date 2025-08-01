<!-- 
  Tags: DadosIA
  Label: 📈 Analise de dados R
  Description: Análise de Vendas de uma Loja de Varejo
  path_hook: hookfigma.hook1
-->


![Screenshot](images/r.png)


1. Com Shiny: Um Dashboard Interativo
O projeto deixaria de ser um script estático e se transformaria em um aplicativo web interativo.

O que você faria: Em vez de rodar o Rscript, você criaria um arquivo app.R que executaria o Shiny.

A experiência do usuário: A pessoa que acessasse o seu aplicativo veria uma página web. Nessa página, ela poderia usar um seletor para escolher a regiao (Norte, Sul, Leste, Oeste) ou um controle de data para filtrar as vendas.

O resultado: Os gráficos e as tabelas seriam atualizados instantaneamente para mostrar os dados apenas da região ou período selecionado. Isso torna a análise muito mais dinâmica e útil para quem a consome.

2. Com R Markdown: Um Relatório Dinâmico
O projeto se tornaria um relatório completo e formatado, que combina o código, o texto e os resultados em um único documento (como um PDF ou HTML).

O que você faria: Você escreveria a análise em um arquivo analise_vendas.Rmd (em vez de .R).

A experiência do usuário: O leitor veria um documento elegante, com um título, introdução e os resultados da análise. O código do R ficaria em blocos, e os gráficos e tabelas (top_produtos_quantidade, top_categorias_receita) apareceriam diretamente no documento.

O resultado: Seria um relatório fácil de compartilhar e que pode ser gerado automaticamente, ideal para apresentações ou para relatórios mensais.

3. Com Plumber: Um Serviço de Análise
O projeto seria transformado em um serviço (API) que outras aplicações poderiam usar.

O que você faria: Você reestruturaria o seu código em funções e as anotaria com @get /top-produtos e @get /receita-por-categoria.

A experiência do usuário: A pessoa não veria um script ou uma interface, mas sim um serviço rodando na web.

O resultado: Um desenvolvedor de um aplicativo móvel, por exemplo, poderia enviar uma requisição HTTP para https://meu-servico-r.com/top-produtos e receberia a tabela dos produtos mais vendidos como uma resposta JSON, que ele poderia usar na sua própria aplicação.

Projeto Atual (Script)	Com Shiny	Com R Markdown	Com Plumber
Output	Texto no terminal e imagens .png	Web app interativo	Relatório .html ou .pdf	JSON, XML, etc.
Foco	Análise e resultados brutos	Interação com o usuário	Apresentação e narrativa	Integração com outros sistemas
Como usar	Rscript	Abrir um navegador	Ler o documento	Fazer uma requisição HTTP

Exportar para Sheets
Para começar, o R Markdown é um ótimo primeiro passo, pois é o mais fácil de adaptar a partir de um script existente. Depois, o Shiny pode ser uma forma fantástica de dar vida aos seus gráficos.


Para gerar o documento final, você precisa usar o pacote `rmarkdown` no console do R.

1.  Se estiver no terminal Bash, digite `R` para entrar no console.
2.  Rode o seguinte comando:

    ```R
    rmarkdown::render("relatorio_vendas.Rmd")
    ```

Isso criará um arquivo chamado **`relatorio_vendas.html`** na mesma pasta. Ao abrir esse arquivo no seu navegador, você verá o relatório completo, com o texto formatado, as tabelas e os gráficos.

Pronto! Você acaba de criar seu primeiro relatório dinâmico em R.

A propósito, para desbloquear as funcionalidades completas de todas as Apps, ative a [Atividade das Apps Gemini](https://myactivity.google.com/product/gemini).


## 👨‍💻 Autor

[Fabiano Rocha/Fabiuniz](https://github.com/SeuUsuarioGitHub)

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
