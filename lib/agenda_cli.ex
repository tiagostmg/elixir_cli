defmodule AgendaCli do
  alias AgendaCli.{Contacts, Store}

  def main do
    contacts = Store.load()
    loop(contacts)
  end

  defp loop(contacts) do
    input = IO.gets("agenda> ") |> String.trim()

    case String.split(input) do
      ["add" | args] ->
        new_contact = parse_add(args)
        updated = Contacts.add(contacts, new_contact)
        Store.save(updated)
        loop(updated)

      ["list"] ->
        Contacts.list(contacts)
        loop(contacts)

      ["show", id] ->
        Contacts.show(contacts, id)
        loop(contacts)

      ["del", id] ->
        updated = Contacts.delete(contacts, id)
        Store.save(updated)
        loop(updated)

      ["search" | args] ->
        {field, value} = parse_search(args)
        Contacts.search(contacts, field, value)
        loop(contacts)

      ["edit", id | args] ->
        updates = parse_edit(args)
        updated = Contacts.edit(contacts, id, updates)
        Store.save(updated)
        loop(updated)

      ["exit"] ->
        IO.puts("Saindo...")

      _ ->
        IO.puts("Comando inválido")
        loop(contacts)
    end
  end

  defp parse_add(args) do
    %{
      id: System.system_time(:millisecond),
      name: get_flag(args, "--name"),
      company: get_flag(args, "--company"),
      phone: get_flag(args, "--phone"),
      email: get_flag(args, "--email")
    }
  end

  defp parse_search(["--name", value]), do: {:name, value}
  defp parse_search(["--phone", value]), do: {:phone, value}
  defp parse_search(["--email", value]), do: {:email, value}

  defp parse_edit(args) do
    %{
      name: get_flag(args, "--name"),
      company: get_flag(args, "--company"),
      phone: get_flag(args, "--phone"),
      email: get_flag(args, "--email")
    }
    |> Enum.filter(fn {_k, v} -> v != nil end)
    |> Enum.into(%{})
  end

  defp get_flag(args, flag) do
    case Enum.chunk_every(args, 2) |> Enum.find(fn [f, _] -> f == flag end) do
      [_, value] -> value
      _ -> nil
    end
  end
end
