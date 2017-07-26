defmodule FfReader.Config do
  def external_url(path) do
    domain_name + path 
  end

  defp domain_name do
    if Mix.env != :prod do
      "localhost:4000"
    else
      System.get_env("DOMAIN_NAME")
    end
  end
end
