import time

from redis import Redis

r = Redis(host='127.0.0.1', port=19000)

for i in range(15000011):
    r.set("a", i)

