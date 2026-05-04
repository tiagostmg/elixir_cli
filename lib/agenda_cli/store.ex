defmodule AgendaCli.Store do
  @contacts_file "contacts.json"

  def load do
    case File.read(@contacts_file) do
      {:ok, content} ->
        Jason.decode!(content, keys: :atoms)

      _ ->
        []
    end
  end

  def save(contacts) do
    json = Jason.encode!(contacts, pretty: true)
    File.write!(@contacts_file, json)
  end
end
