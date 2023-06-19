defmodule CompanyApi.Manufactures do
  @moduledoc """
  The Manufactures context.
  """

  import Ecto.Query, warn: false
  alias CompanyApi.Repo

  alias CompanyApi.Manufactures.Line

  @doc """
  Returns the list of lines.

  ## Examples

      iex> list_lines()
      [%Line{}, ...]

  """
  def list_lines do
    Repo.all(Line)
  end

  @doc """
  Gets a single line.

  Raises `Ecto.NoResultsError` if the Line does not exist.

  ## Examples

      iex> get_line!(123)
      %Line{}

      iex> get_line!(456)
      ** (Ecto.NoResultsError)

  """
  def get_line!(id), do: Repo.get!(Line, id)

  @doc """
  Creates a line.

  ## Examples

      iex> create_line(%{field: value})
      {:ok, %Line{}}

      iex> create_line(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_line(attrs \\ %{}) do
    %Line{}
    |> Line.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a line.

  ## Examples

      iex> update_line(line, %{field: new_value})
      {:ok, %Line{}}

      iex> update_line(line, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_line(%Line{} = line, attrs) do
    line
    |> Line.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a line.

  ## Examples

      iex> delete_line(line)
      {:ok, %Line{}}

      iex> delete_line(line)
      {:error, %Ecto.Changeset{}}

  """
  def delete_line(%Line{} = line) do
    Repo.delete(line)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking line changes.

  ## Examples

      iex> change_line(line)
      %Ecto.Changeset{data: %Line{}}

  """
  def change_line(%Line{} = line, attrs \\ %{}) do
    Line.changeset(line, attrs)
  end
end
