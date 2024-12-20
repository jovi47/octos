defmodule OctosWeb.Accounts.UserView do
  use OctosWeb, :view

  @doc """
  Renders a list of users.
  """
  def render("user_token.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end

  def render("error.json", params) do
    IO.puts(inspect(params))
    %{error: "a"}
  end
end
