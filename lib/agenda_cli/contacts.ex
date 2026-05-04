defmodule AgendaCli.Contacts do
  def add(contacts, contact) do
    [contact | contacts]
  end

  def list(contacts) do
    Enum.each(contacts, fn c ->
      IO.puts("#{c.id} | #{c.name} | #{c.company} | #{c.phone} | #{c.email}")
    end)
  end

  def show(contacts, id) do
    case Enum.find(contacts, fn c -> to_string(c.id) == id end) do
      nil -> IO.puts("Não encontrado")
      c -> IO.inspect(c)
    end
  end

  def delete(contacts, id) do
    Enum.reject(contacts, fn c -> to_string(c.id) == id end)
  end

  def search(contacts, field, value) do
    value = String.downcase(value)

    contacts
    |> Enum.filter(fn c ->
      c[field]
      |> String.downcase()
      |> String.contains?(value)
    end)
    |> list()
  end

  def edit(contacts, id, updates) do
    Enum.map(contacts, fn c ->
      if to_string(c.id) == id do
        Map.merge(c, updates)
      else
        c
      end
    end)
  end
end
