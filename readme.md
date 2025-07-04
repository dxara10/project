# 🤖 Projeto de Automação de Testes com Robot Framework

Bem-vindo ao projeto de automação de testes! Esta suíte foi construída utilizando **Robot Framework** para garantir a qualidade e a estabilidade de aplicações web e de suas APIs REST, através de testes funcionais automatizados.

## ✅ Apresentação do Projeto

Este projeto é uma suíte de testes automatizados `end-to-end` que valida as principais funcionalidades de um sistema, dividida em duas frentes de atuação:

1.  **Testes de API:** Validam os `endpoints` da aplicação, cobrindo operações de CRUD (Create, Read, Update, Delete) para recursos como autenticação, usuários, filmes, etc. Garante que a lógica de negócio no backend funcione como esperado.
2.  **Testes de Web (UI):** Simulam a interação de um usuário real com a interface da aplicação, validando fluxos críticos, elementos visuais e a experiência do usuário (UX) no frontend.

O projeto foi estruturado para ser altamente legível e manutenível, utilizando as melhores práticas do Robot Framework, como a separação de casos de teste (`tests`), recursos reutilizáveis (`resources`) e configuração de ambiente.

## 🏆 Principais Benefícios

* **Garantia de Qualidade Contínua:** Automatiza a execução de testes de regressão, permitindo que novas funcionalidades sejam desenvolvidas com a segurança de que as antigas não foram quebradas.
* **Alta Legibilidade e Manutenção:** Utiliza a sintaxe Gherkin (Given-When-Then) do Robot Framework, que permite que os testes sejam escritos em uma linguagem próxima à natural, facilitando o entendimento por parte de toda a equipe (QAs, Devs e POs).
* **Integração com CI/CD:** O projeto já inclui um workflow para GitHub Actions (`executar-testes.yml`), permitindo que os testes sejam executados automaticamente a cada `push` ou `pull request`, fornecendo feedback rápido ao time de desenvolvimento.
* **Relatórios Completos e Intuitivos:** Ao final de cada execução, o Robot Framework gera automaticamente relatórios detalhados (`report.html` e `log.html`) com o status de cada teste, passos executados e screenshots em caso de falha.
* **Reutilização e Escalabilidade:** A estrutura baseada em `resources` permite que keywords e variáveis sejam compartilhadas entre diferentes suítes de teste, evitando duplicação de código e facilitando a expansão da cobertura de testes.

## ⚙️ Guia Completo de Instalação e Uso

Siga os passos abaixo para configurar e executar o projeto em seu ambiente local.

### Pré-requisitos

Antes de começar, garanta que você tenha os seguintes softwares instalados:
* [Git](https://git-scm.com/)
* [Python](https://www.python.org/downloads/) (versão 3.8 ou superior)
* Um navegador de sua preferência (Google Chrome, Firefox, etc.)
* **WebDriver** correspondente ao seu navegador. **Esta etapa é crucial.**

### Passo 1: Clonar o Repositório

Abra seu terminal e clone este repositório para sua máquina local.

```bash
git clone <URL_DO_SEU_REPOSITORIO_GIT>
cd project
```

### Passo 2: Configurar o Ambiente Python

Utilizaremos um ambiente virtual (`venv`) para gerenciar as dependências do projeto.

```bash
# Criar o ambiente virtual (faça isso apenas uma vez)
python -m venv .venv

# Ativar o ambiente virtual
# No Windows:
.venv\Scripts\activate
# No macOS/Linux:
source .venv/bin/activate
```

Com o ambiente ativado, instale todas as dependências listadas no arquivo `requirements.txt`:

```bash
pip install -r requirements.txt
```
> **Nota:** Se o seu `requirements.txt` ainda não estiver completo, ele deve conter pelo menos as seguintes bibliotecas para este projeto:
> ```txt
> # requirements.txt
> robotframework
> robotframework-seleniumlibrary
> robotframework-requests
> ```

### Passo 3: Configurar os WebDrivers

Para que os testes de Web (UI) funcionem, o Selenium precisa controlar o navegador através de um WebDriver.

1.  **Baixe o WebDriver** para o seu navegador (ex: [ChromeDriver](https://googlechromelabs.github.io/chrome-for-testing/) para Google Chrome).
2.  **Descompacte** o arquivo baixado.
3.  **Adicione o local** do executável do WebDriver à variável de ambiente `PATH` do seu sistema operacional. Isso permite que o Robot Framework o encontre e o utilize.

### Passo 4: Configurar as Variáveis de Ambiente do Projeto

As configurações de ambiente, como a URL da aplicação a ser testada, estão no arquivo `resources/env.resource`.

Abra o arquivo `resources/env.resource` e ajuste as variáveis conforme necessário. O principal alvo é a `TARGET_URL`:

```robotframework
*** Settings ***
Resource    base.resource

*** Variables ***
${TARGET_URL}    http://localhost:3000/api/v1    # Altere para a URL da sua aplicação
```

### Passo 5: Executando os Testes

Com o ambiente virtual ativado, utilize o comando `robot` para executar os testes.

**1. Para executar TODOS os testes (API e Web):**
```bash
robot tests/
```

**2. Para executar apenas os testes de API:**
```bash
robot tests/api/
```

**3. Para executar uma suíte de testes específica (ex: `movies.robot`):**
```bash
robot tests/api/movies.robot
```

**4. Para executar testes marcados com uma TAG específica (ex: `smoke`):**
```bash
robot --include smoke tests/
```

### Visualizando os Relatórios

Após a execução, os arquivos `log.html` e `report.html` serão criados na raiz do projeto. Abra-os em qualquer navegador para ver os resultados detalhados dos testes.

---
Desenvolvido com ❤️ e foco na qualidade por Douglas