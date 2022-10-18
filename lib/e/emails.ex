defmodule E.Emails do
  import Bamboo.Email

  def wake_up_static do
    base_email()
    |> to("foo@bar.com")
    |> subject("Welcome!!!")
    |> put_header("Reply-To", "someone@example.com")
    |> html_body("<pre>Wake up, Neo...</pre>")
    |> text_body("Wake up, Neo...")
  end

  require EEx

  EEx.function_from_file(:def, :wake_up_html, "lib/e/emails/wake_up.html.eex", [:assigns],
    engine: Phoenix.HTML.Engine
  )

  EEx.function_from_file(:def, :wake_up_text, "lib/e/emails/wake_up.text.eex", [:assigns],
    engine: Phoenix.HTML.Engine
  )

  def wake_up_compiled(assigns \\ %{name: "Neo"}) do
    base_email()
    |> to("foo@bar.com")
    |> subject("Welcome!!!")
    |> put_header("Reply-To", "someone@example.com")
    |> html_body(wake_up_html(assigns))
    |> text_body(wake_up_text(assigns))
  end

  def wake_up_runtime(assigns \\ %{name: "Neo"}) do
  end

  def wake_up_cached(assigns \\ %{name: "Neo"}) do
  end

  defp base_email do
    new_email()
    |> from("myapp@example.com")

    # TODO
    # |> put_html_layout({MyApp.LayoutView, "email.html"}) # Set default layout
    # |> put_text_layout({MyApp.LayoutView, "email.text"}) # Set default text layout
  end
end
