
```
create role hackmd
alter role hackmd with login;
grant all on schema public to hackmd;

grant all on all tables in schema public to hackmd;
grant all on all sequences in schema public to hackmd;
```
