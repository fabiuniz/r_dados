# Este arquivo 'plumber.R' define a API usando o pacote Plumber.
# Cada função com a anotação `#* @get` se torna um endpoint (URL).
# Os endpoints podem aceitar parâmetros para filtrar os dados.

library(plumber)
library(tidyverse)

# Criação dos dados de vendas.
# Esta parte é executada uma vez quando o serviço de API inicia.
dados_vendas <- tibble(
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

#* Retorna os produtos mais vendidos por quantidade, com opção de filtro por região e data.
#* @param regiao A região para filtrar os dados (opcional).
#* @param data_inicio A data de início para filtrar os dados (formato YYYY-MM-DD, opcional).
#* @param data_fim A data de fim para filtrar os dados (formato YYYY-MM-DD, opcional).
#* @get /top-produtos
function(regiao = NULL, data_inicio = NULL, data_fim = NULL) {
  
  dados_filtrados <- dados_vendas
  
  if (!is.null(regiao)) {
    dados_filtrados <- dados_filtrados %>% filter(regiao == !!regiao)
  }
  
  if (!is.null(data_inicio)) {
    dados_filtrados <- dados_filtrados %>% filter(data_venda >= as.Date(data_inicio))
  }
  
  if (!is.null(data_fim)) {
    dados_filtrados <- dados_filtrados %>% filter(data_venda <= as.Date(data_fim))
  }
  
  dados_filtrados %>%
    group_by(produto) %>%
    summarise(total_quantidade = sum(quantidade)) %>%
    arrange(desc(total_quantidade))
}

#* Retorna as categorias por receita, com opção de filtro por região e data.
#* @param regiao A região para filtrar os dados (opcional).
#* @param data_inicio A data de início para filtrar os dados (formato YYYY-MM-DD, opcional).
#* @param data_fim A data de fim para filtrar os dados (formato YYYY-MM-DD, opcional).
#* @get /receita-por-categoria
function(regiao = NULL, data_inicio = NULL, data_fim = NULL) {
  
  dados_filtrados <- dados_vendas
  
  if (!is.null(regiao)) {
    dados_filtrados <- dados_filtrados %>% filter(regiao == !!regiao)
  }
  
  if (!is.null(data_inicio)) {
    dados_filtrados <- dados_filtrados %>% filter(data_venda >= as.Date(data_inicio))
  }
  
  if (!is.null(data_fim)) {
    dados_filtrados <- dados_filtrados %>% filter(data_venda <= as.Date(data_fim))
  }
  
  dados_filtrados %>%
    group_by(categoria) %>%
    summarise(total_receita = sum(valor_total)) %>%
    arrange(desc(total_receita))
}
