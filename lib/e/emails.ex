defmodule E.Emails do
  import Bamboo.Email

  def wake_up_static do
    base_email()
    |> html_body("<pre>Wake up, Neo...</pre>")
    |> text_body("Wake up, Neo...")
  end

  require EEx

  @html_path "lib/e/emails/wake_up.html.eex"
  @text_path "lib/e/emails/wake_up.text.eex"

  EEx.function_from_file(:def, :wake_up_html, @html_path, [:assigns], engine: Phoenix.HTML.Engine)
  EEx.function_from_file(:def, :wake_up_text, @text_path, [:assigns], engine: Phoenix.HTML.Engine)

  def wake_up_compiled(assigns \\ %{name: "Neo"}) do
    {:safe, html_body} = wake_up_html(assigns)
    {:safe, text_body} = wake_up_text(assigns)

    base_email()
    |> html_body(html_body)
    |> text_body(text_body)
  end

  @custom_html_path "priv/emails/wake_up.html.eex"
  @custom_text_path "priv/emails/wake_up.text.eex"

  def wake_up_runtime(assigns \\ %{name: "Neo"}) do
    {:safe, html_body} =
      EEx.eval_file(@custom_html_path, [assigns: assigns], engine: Phoenix.HTML.Engine)

    {:safe, text_body} =
      EEx.eval_file(@custom_text_path, [assigns: assigns], engine: Phoenix.HTML.Engine)

    base_email()
    |> html_body(html_body)
    |> text_body(text_body)
  end

  @custom_wake_up_key {__MODULE__, :cached_wake_up}

  # called in application.ex
  def cache_custom_wake_up do
    html_quoted = EEx.compile_file(@custom_html_path, engine: Phoenix.HTML.Engine)
    text_quoted = EEx.compile_file(@custom_text_path, engine: Phoenix.HTML.Engine)
    :ok = :persistent_term.put(@custom_wake_up_key, {html_quoted, text_quoted})
  end

  def wake_up_cached(assigns \\ %{name: "Neo"}) do
    {html_quoted, text_quoted} = :persistent_term.get(@custom_wake_up_key)
    {{:safe, html_body}, _} = Code.eval_quoted(html_quoted, assigns: assigns)
    {{:safe, text_body}, _} = Code.eval_quoted(text_quoted, assigns: assigns)

    base_email()
    |> html_body(html_body)
    |> text_body(text_body)
  end

  @custom_mod __MODULE__.Custom

  # called in application.ex
  # based on https://github.com/elixir-lang/elixir/blob/eb43a6a444c4aa9446ec1a7ad9801cedc897ab9d/lib/eex/lib/eex.ex#L178
  def compile_custom_wake_up do
    options = [engine: Phoenix.HTML.Engine]

    html_quoted =
      EEx.compile_file(
        @custom_html_path,
        Keyword.merge([file: IO.chardata_to_string(@custom_html_path), line: 1], options)
      )

    text_quoted =
      EEx.compile_file(
        @custom_text_path,
        Keyword.merge([file: IO.chardata_to_string(@custom_text_path), line: 1], options)
      )

    args = [{:assigns, [line: 1], nil}]

    contents =
      quote do
        def wake_up_html(unquote_splicing(args)), do: unquote(html_quoted)
        def wake_up_text(unquote_splicing(args)), do: unquote(text_quoted)
      end

    Module.create(@custom_mod, contents, Macro.Env.location(__ENV__))
  end

  def wake_up_runtime_compiled(assigns \\ %{name: "Neo"}) do
    {:safe, html_body} = apply(@custom_mod, :wake_up_html, [assigns])
    {:safe, text_body} = apply(@custom_mod, :wake_up_text, [assigns])

    base_email()
    |> html_body(html_body)
    |> text_body(text_body)
  end

  defp base_email do
    new_email()
    |> to("foo@bar.com")
    |> subject("Wake up!!!")
    |> put_header("Reply-To", "someone@example.com")
    |> from("myapp@example.com")

    # TODO?
    # |> put_html_layout({MyApp.LayoutView, "email.html"}) # Set default layout
    # |> put_text_layout({MyApp.LayoutView, "email.text"}) # Set default text layout
  end
end
