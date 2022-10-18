alias E.Emails

Benchee.run(
  %{
    "static" => fn -> Emails.wake_up_static() end,
    "compiled" => fn -> Emails.wake_up_compiled() end,
    "runtime" => fn -> Emails.wake_up_runtime() end,
    "cached" => fn -> Emails.wake_up_cached() end,
    "runtime_compiled" => fn -> Emails.wake_up_runtime_compiled() end
  },
  memory_time: 2
)
