defmodule FfReader.Web.LayoutView do
  use FfReader.Web, :view

  def flashes() do
    [
      %{name: :info, class: "alert-info"},
      %{name: :success, class: "alert-success"},
      %{name: :warning, class: "alert-warning"},
      %{name: :danger, class: "alert-danger"},
      %{name: :error, class: "alert-danger"}
    ]
  end
end
