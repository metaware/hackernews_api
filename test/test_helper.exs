ExUnit.start

Mix.Task.run "ecto.create", ~w(-r HackernewsApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r HackernewsApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(HackernewsApi.Repo)

