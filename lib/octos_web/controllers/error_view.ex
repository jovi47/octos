defmodule OctosWeb.ErrorView do
  use OctosWeb, :view

  def render("error.json", %{changeset: changeset}) do
    # Adapte conforme necessário para retornar erros do seu changeset
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  defp translate_error({_, _}) do
    # Traduza mensagens conforme necessário
    "a"
  end
end
