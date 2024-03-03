create schema if not exists demo;

create role demo_user nologin;
grant usage on schema demo to demo_user;

alter default privileges in schema demo grant all privileges on tables to demo_user;
alter default privileges in schema demo grant all privileges on sequences to demo_user;

create table demo.things (
  id serial primary key,
  name text not null
);

insert into demo.things (name) values
  ('thing'), ('the thing'), ('another thing');

-- https://postgrest.org/en/v12/how-tos/providing-html-content-using-htmx.html

create domain "text/html" as text;

create or replace function demo.sanitize_html(text) returns text as $$
  select replace(replace(replace(replace(replace($1, '&', '&amp;'), '"', '&quot;'),'>', '&gt;'),'<', '&lt;'), '''', '&apos;')

$$ language sql;

create or replace function demo.html_thing(demo.things) returns text as $$
  select format($html$
    <li>
      <span>%1$s</span>
    </li>
    $html$,
    demo.sanitize_html($1.name)
  );

$$ language sql stable;

create or replace function demo.html_all_things() returns "text/html" as $$
  select coalesce('<ul id="todo-list" role="list">'|| string_agg(demo.html_thing(t), '' order by t.id) || '</ul>')
  from demo.things t;

$$ language sql;

create or replace function demo.index() returns "text/html" as $$
select $html$
  <!doctype html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>instadash</title>
      <script src="https://unpkg.com/htmx.org"></script>
    </head>
    <body hx-headers='{"accept": "text/html"}'>
      <div>
        <div>
          <h5>things</h5>
          <div hx-get="/rpc/html_all_things" hx-trigger="every 1s" hx-target="this">
          <div>
        </div>
      </div>
    </body>
  </html>
  $html$;
$$ language sql;