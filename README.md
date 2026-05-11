# Agenda CLI

Uma agenda de contatos simples feita em Elixir para uso no terminal.

## Como rodar

1. Instale as dependencias:

```bash
mix deps.get
```

2. Abra o terminal interativo do projeto:

```bash
iex -S mix
```

3. Inicie a agenda:

```elixir
AgendaCli.main()
```

Depois disso, o prompt `agenda>` sera exibido para voce digitar os comandos.

## Persistencia dos dados

Os contatos sao salvos no arquivo `contacts.json`, na raiz do projeto. Se o arquivo ainda nao existir, ele sera criado automaticamente quando voce salvar o primeiro contato.

## Comandos disponiveis

### Adicionar contato

```text
add --name NOME --company EMPRESA --phone TELEFONE --email EMAIL
```

Exemplo:

```text
add --name Tiago --company OpenAI --phone 99999-9999 --email tiago@email.com
```

### Listar contatos

```text
list
```

Lista todos os contatos no formato:

```text
id | nome | empresa | telefone | email
```

### Exibir um contato

```text
show ID
```

Exemplo:

```text
show 1715600000000
```

### Remover contato

```text
del ID
```

Exemplo:

```text
del 1715600000000
```

### Buscar contatos

Voce pode buscar por nome, telefone ou email.

```text
search --name VALOR
search --phone VALOR
search --email VALOR
```

Exemplos:

```text
search --name tiago
search --phone 99999
search --email openai
```

### Editar contato

```text
edit ID [--name NOME] [--company EMPRESA] [--phone TELEFONE] [--email EMAIL]
```

Exemplo:

```text
edit 1715600000000 --phone 98888-7777 --company NovaEmpresa
```

Voce pode informar apenas os campos que deseja alterar.

### Sair

```text
exit
```

## Observacoes

- O comando `search` aceita apenas um criterio por vez.
- O `id` do contato e gerado automaticamente com base no tempo do sistema.
- Se um comando invalido for informado, a aplicacao exibira `Comando invalido`.
