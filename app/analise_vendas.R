# export PATH=$PATH:"/c/Program Files/R/R-4.5.1/bin/x64":"/caminho/do/tesseract":"/c/Program Files/RStudio/bin":"/c/Users/Fabiano/AppData/Local/Pandoc"
# Instalar o pacote (faça isso apenas uma vez)
# install.packages("tidyverse")
# install.packages("tidyverse", repos = "https://cran-r.c3sl.ufpr.br/")
# install.packages("tidyverse", repos = "https://vps.fmvz.usp.br/CRAN/")
# install.packages("scales", repos = "https://vps.fmvz.usp.br/CRAN/")
# install.packages("stringi", repos = "https://vps.fmvz.usp.br/CRAN/")
# install.packages("utf8", repos = "https://vps.fmvz.usp.br/CRAN/")
# R >
# Rscript analise_vendas.R
# Carregar o pacote
# https://cloud.r-project.org/
# 
#------------------------------------------------
# Projeto de Análise de Vendas de uma Loja
#------------------------------------------------

# 1. Carregar Pacotes Necessários
library(tidyverse)

# 2. Criação de um Dataframe de Exemplo
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
)

# 3. Análise Exploratória de Dados (EDA)
# Visualizando as primeiras linhas dos dados
head(dados_vendas)

# Verificando a estrutura e resumo
str(dados_vendas)
summary(dados_vendas)

# Calculando o valor total de cada venda
dados_vendas <- dados_vendas %>%
  mutate(valor_total = quantidade * preco_unitario)

# Encontrando os produtos mais vendidos por quantidade
top_produtos_quantidade <- dados_vendas %>%
  group_by(produto) %>%
  summarise(total_quantidade = sum(quantidade)) %>%
  arrange(desc(total_quantidade))

print(top_produtos_quantidade)

# Encontrando as categorias que mais geraram receita
top_categorias_receita <- dados_vendas %>%
  group_by(categoria) %>%
  summarise(total_receita = sum(valor_total)) %>%
  arrange(desc(total_receita))

print(top_categorias_receita)

# 4. Visualização de Dados (Gráficos)
# Gráfico de barras dos produtos mais vendidos
ggplot(top_produtos_quantidade, aes(x = reorder(produto, total_quantidade), y = total_quantidade)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Produtos mais vendidos (por quantidade)",
       x = "Produto",
       y = "Quantidade Total Vendida") +
  theme_minimal() +
  coord_flip()

# Gráfico de pizza para a receita por categoria
ggplot(top_categorias_receita, aes(x = "", y = total_receita, fill = categoria)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Receita por Categoria de Produto") +
  theme_void()