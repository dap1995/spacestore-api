defmodule SpacestoreWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias Spacestore.Repo
  alias Spacestore.Account.User

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})
      _ -> conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
        {:ok, claims} = Spacestore.Guardian.decode_and_verify(token),
        {:ok, current_user} <- get_user(claims["sub"])
    do
      {:ok, %{current_user: current_user, token: token}}
    end
  end

  defp get_user(id) do
    User
    |> Repo.get(id)
    |> case do
      nil -> {:error, "Invalid authorization token"}
      user -> {:ok, user}
    end
  end
end