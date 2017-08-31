defmodule MarvelComicsWeb.Controllers.ComicsSearchHelpers do
  @recv_timeout 15_000
  def fetch_comics(url) do
    case HTTPoison.get(url, [], recv_timeout: @recv_timeout) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Not Found"
      {:ok, %HTTPoison.Response{status_code: 401}} ->
        "Authentication Required"
      {:error, %HTTPoison.Error{reason: reason}} ->
        Poison.decode!(reason)
    end
  end

  def auth_token do
    ts = DateTime.utc_now() |> DateTime.to_unix()
    {public_key, private_key} = marvel_api_keys()
    md5 = :crypto.hash(:md5, "#{ts}#{private_key}#{public_key}") |> Base.encode16(case: :lower)
    "ts=#{ts}&apikey=#{public_key}&hash=#{md5}"
  end

  @comics_per_page 15
  def pagination(page) do
    "limit=#{@comics_per_page}&offset=#{@comics_per_page * (to_page(page) - 1)}"
  end

  def to_page(page) when is_bitstring(page), do: String.to_integer(page)
  def to_page(page) when is_integer(page) and page > 0, do: page
  def to_page(_), do: 1

  def ordered, do: "orderBy=-issueNumber"
  def with_issues, do: "hasDigitalIssue=\"true\""

  defp marvel_api_keys do
    marvel_api = Application.get_env(:marvel_comics, :marvel_api)
    {marvel_api[:public_key], marvel_api[:private_key]}
  end
end
