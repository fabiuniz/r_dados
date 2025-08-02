# Este arquivo 'app.R' contém o código completo para o seu dashboard Shiny.
# Ele cria uma interface de usuário (UI) com controles e uma lógica de servidor (server)
# para filtrar os dados e renderizar os resultados.

library(shiny)
library(tidyverse)

# Criação dos dados de vendas.
# Esta parte é executada uma vez quando o aplicativo inicia.
dados_vendas_originais <- tibble(
  id_venda = 1:100,
  data_venda = as.Date("2023-01-01") + sample(1:365, 100, replace = TRUE),
  produto = sample(c("Camiseta", "Calça Jeans", "Tênis", "Meia", "Boné"), 100, replace = TRUE),
  categoria = case_when(
    produto %in% c("Camiseta", "Calça Jeans", "Meia") ~ "Vestuário",
    produto == "Tênis" ~ "Calçado",
    TRUE ~ "Acessório"
  ),
  quantidade = sample(1:5, 100, replace = TRUE),
  preco_unitario = sample(c(30, 80, 200, 15, 45), 100, replace = TRUE),
  regiao = sample(c("Norte", "Sul", "Leste", "Oeste"), 100, replace = TRUE)
) %>%
  mutate(valor_total = quantidade * preco_unitario)

# Define a interface de usuário (UI) do aplicativo.
# A UI é o que o usuário vê e interage no navegador.
ui <- fluidPage(
  # Título do aplicativo
  titlePanel("Dashboard Interativo de Vendas"),

  # Layout com barra lateral para os controles e painel principal para os resultados
  sidebarLayout(
    # Painel da barra lateral com os controles de entrada
    sidebarPanel(
      h4("Filtros de Dados"),
      # Seletor para a região
      selectInput("regiao_selecionada",
                  "Selecione a Região:",
                  choices = c("Todas", unique(dados_vendas_originais$regiao)),
                  selected = "Todas"),
      # Seletor para o período de datas
      dateRangeInput("periodo_selecionado",
                     "Selecione o Período:",
                     start = min(dados_vendas_originais$data_venda),
                     end = max(dados_vendas_originais$data_venda),
                     format = "dd/mm/yyyy")
    ),

    # Painel principal para mostrar os resultados
    mainPanel(
      # Título do gráfico
      h3("Produtos mais vendidos (por quantidade)"),
      # Saída do gráfico
      plotOutput("plot_quantidade"),
      hr(),
      # Título da tabela 1
      h3("Tabela de Produtos mais vendidos"),
      # Saída da tabela 1
      tableOutput("tabela_produtos"),
      hr(),
      # Título da tabela 2
      h3("Tabela de Categorias por Receita"),
      # Saída da tabela 2
      tableOutput("tabela_categorias")
    )
  )
)

# Define a lógica do servidor do aplicativo.
# O servidor lida com a entrada do usuário e gera os resultados para a UI.
server <- function(input, output) {

  # Cria um objeto reativo (reactive) que filtra os dados com base na entrada do usuário.
  # Qualquer alteração nos inputs (região, período) irá re-executar esta parte do código.
  dados_filtrados <- reactive({
    dados <- dados_vendas_originais
    
    # Filtra por região, se não for "Todas"
    if (input$regiao_selecionada != "Todas") {
      dados <- dados %>% filter(regiao == input$regiao_selecionada)
    }

    # Filtra por período de datas
    dados %>%
      filter(data_venda >= input$periodo_selecionado[1] & data_venda <= input$periodo_selecionado[2])
  })

  # Renderiza o gráfico de barras
  output$plot_quantidade <- renderPlot({
    dados_grafico <- dados_filtrados() %>%
      group_by(produto) %>%
      summarise(total_quantidade = sum(quantidade)) %>%
      arrange(desc(total_quantidade))

    ggplot(dados_grafico, aes(x = reorder(produto, total_quantidade), y = total_quantidade)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(title = "Produtos mais vendidos (por quantidade)",
           x = "Produto",
           y = "Quantidade Total Vendida") +
      theme_minimal() +
      coord_flip()
  })

  # Renderiza a tabela de produtos mais vendidos
  output$tabela_produtos <- renderTable({
    dados_filtrados() %>%
      group_by(produto) %>%
      summarise(total_quantidade = sum(quantidade)) %>%
      arrange(desc(total_quantidade))
  })

  # Renderiza a tabela de categorias por receita
  output$tabela_categorias <- renderTable({
    dados_filtrados() %>%
      group_by(categoria) %>%
      summarise(total_receita = sum(valor_total)) %>%
      arrange(desc(total_receita))
  })

}

# Executa o aplicativo Shiny
shinyApp(ui = ui, server = server)
