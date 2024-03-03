
# Postgrest + HTMX

Proof of concept [htmx](https://htmx.org/) website that shows a list of things that updates every 1s with a CRUD http API backed by [PostgREST](https://postgrest.org/en/v12/) that spins up with one command.

Mutate state via SQL or HTTP and page reflects changes.

Built in about 45 mins. Taking longer to write this readme. Inspired by [Providing HTML Content Using Htmx](https://postgrest.org/en/v12/how-tos/providing-html-content-using-htmx.html)

### Running it.

`up.sh` -> maintains persistence

`up-clean.sh` -> resets persistence

Runs on http://localhost:3000/rpc/index

```sh
# Add thing
curl -d '{"name":"Curl Thing"}' -H "Content-Type: application/json" -X POST http://localhost:3000/things

# Delete thing with id = 1
curl -X "DELETE" http://localhost:3000/things?id=eq.1
```
[PostgREST API docs](https://postgrest.org/en/v12/references/api.html)

### Shortcuts

[Adminer](https://github.com/vrana/adminer/) for quick & dirty database work.

http://localhost:8090/?pgsql=database-postgres&username=postgres&password=postgres&db=postgres&ns=demo

---

### Future?

Adding filesystem driven convention based routing/actions and wiring that to migrations would be cool.