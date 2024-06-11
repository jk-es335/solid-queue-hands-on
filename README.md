# README

## How to run queuing process

### solid queue

```bash
make up_sq
```

multiple workers/dispatchers

```bash
make up_sq_all
```

if you want to increase workers,

```bash
make WORKER=4 up_sq_all 
````

### delayed job

```bash
make up_dj
```

multiple processes

```bash
make up_dj_all
```

if you want to increase workers,

```bash
make WORKER=4 up_dj_all 
````

## Enqueue jobs

```bash
docker compose exec app bash -c 'bundle exec rake sample_job:run[500]'

docker compose exec app bash -c 'bundle exec rake fake_api_job:run[500]'

```

### Check the processing time

```bash
docker compose exec db bash -c 'mysql handson'
```

Run the following SQL queries

```
SELECT adapter, uuid, count(id) AS queue, TIMEDIFF(MAX(completed_at), MIN(completed_at)) AS duration FROM job_completions GROUP BY adapter, uuid;

SELECT adapter, uuid, DATE_FORMAT(completed_at, '%Y-%m-%d %H:%i:%s') as datetime, count(id) AS queue, TIMEDIFF(MAX(completed_at), MIN(completed_at)) AS duration FROM job_completions GROUP BY adapter, uuid, datetime;
```

## Check the status of the jobs (for solid queue)

http://localhost:13000/jobs

## How to destroy the containers

```bash
make down
```