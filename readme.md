# Projeto Cinema API - Testes Automatizados

Bem-vindo ao repositório de automação de testes para a API do sistema Cinema!  
Este projeto foi desenvolvido para garantir a qualidade, robustez e confiabilidade das funcionalidades do backend de um sistema de gestão de cinemas, abrangendo desde o cadastro de filmes, sessões, reservas, usuários e teatros, até a autenticação e autorização de acessos.

## Benefícios do Projeto

- **Qualidade Garantida:** Automatiza a validação de todos os fluxos críticos da API, reduzindo falhas em produção.
- **Facilidade de Manutenção:** Permite rápida identificação de regressões a cada alteração no código.
- **Documentação Viva:** Os testes servem como documentação prática dos endpoints e regras de negócio.
- **Acelera o Desenvolvimento:** Desenvolvedores podem testar rapidamente novas funcionalidades e correções.
- **Padronização:** Uso de boas práticas em automação, com keywords reutilizáveis e organização modular.
- **Ambiente Seguro:** Garante que permissões e autenticações estejam sempre corretas.

## Pré-requisitos

- Python 3.12+
- [pip](https://pip.pypa.io/en/stable/)
- [Robot Framework](https://robotframework.org/)
- [RequestsLibrary](https://github.com/MarketSquare/robotframework-requests)
- [FakerLibrary](https://github.com/guykisel/robotframework-faker)
- Backend da API Cinema rodando localmente ou acessível via rede

## Instalação

1. **Clone o repositório:**
   ```bash
   git clone <url-do-repositorio>
   cd <pasta-do-projeto>
   ```

2. **Crie um ambiente virtual (opcional, mas recomendado):**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Instale as dependências:**
   ```bash
   pip install -r requirements.txt
   ```

   Se não houver um `requirements.txt`, instale manualmente:
   ```bash
   pip install robotframework
   pip install robotframework-requests
   pip install robotframework-faker
   ```

4. **Configure o ambiente:**
   - Certifique-se de que o arquivo `resources/env.resource` contém a variável `${URL}` apontando para o endpoint correto da API.
   - Exemplo:
     ```
     ${URL}    http://localhost:3000/api/v1
     ```

5. **Garanta que o backend da API Cinema está rodando:**
   - Por padrão, os testes apontam para `http://localhost:3000/api/v1`.
   - Ajuste a variável `${URL}` caso utilize outro endereço.

## Como Executar os Testes

Execute todos os testes de uma vez:
```bash
robot -d logs tests/api
```

Execute apenas um arquivo de testes específico:
```bash
robot -d logs tests/api/sessions.robot
```

Os relatórios serão gerados na pasta `logs/`:
- `log.html` — Detalhamento dos testes
- `report.html` — Resumo executivo
- `output.xml` — Saída padrão do Robot Framework

## Estrutura do Projeto

- `resources/` — Keywords reutilizáveis, variáveis e configurações
- `resources/api/` — Keywords específicas para cada recurso da API (filmes, sessões, reservas, etc)
- `tests/api/` — Casos de teste organizados por funcionalidade
- `logs/` — Relatórios de execução

## Contribuição

Sinta-se à vontade para contribuir com novos testes, melhorias nas keywords ou sugestões de boas práticas.  
Abra uma issue ou envie um pull request!

## Considerações Finais

Este projeto é um aliado fundamental para equipes de desenvolvimento que buscam excelência, agilidade e segurança no ciclo de vida do software.  
A automação de testes proporciona confiança para evoluir o sistema, reduz o retrabalho e eleva o padrão de qualidade do produto entregue.

---
**Desfrute de um desenvolvimento mais seguro, ágil e profissional com o poder dos testes automatizados!**