create table if not exists public.profiles(id uuid primary key references auth.users(id) on delete cascade,username text unique not null,role text not null default 'member' check(role in('member','owner')),created_at timestamptz not null default now());
create table if not exists public.site_settings(key text primary key,value jsonb not null);
alter table public.profiles enable row level security;alter table public.site_settings enable row level security;
create policy "read own profile" on public.profiles for select using(auth.uid()=id);
create or replace function public.handle_new_user() returns trigger language plpgsql security definer set search_path=public as $$ declare uname text; begin uname:=coalesce(new.raw_user_meta_data->>'username',split_part(new.email,'@',1));insert into public.profiles(id,username,role) values(new.id,uname,'member');return new;end;$$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();
insert into public.site_settings(key,value) values('maintenance','false'::jsonb),('deposit_url','""'::jsonb),('digitalocean_url','""'::jsonb),('digitalocean_description','"Cloud compute service"'::jsonb),('linode_url','""'::jsonb),('linode_description','"Virtual private server"'::jsonb),('pterodactyl_url','""'::jsonb),('pterodactyl_description','"Game server panel"'::jsonb) on conflict(key) do nothing;
-- Daftarkan owner dari UI, lalu jalankan query berikut di SQL Editor:
-- update public.profiles set role='owner' where username='USERNAME_OWNER';
