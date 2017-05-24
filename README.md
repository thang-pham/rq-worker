# RQ (Redis Queue)
*RQ is a simple library for creating background jobs and processing them.*


* What is RQ?

  RQ (Redis Queue) is a simple Python library for queueing jobs and
  processing them in the background with workers. It is backed by Redis and
  it is designed to have a low barrier to entry. It can be integrated in your
  web stack easily.

  For more info: http://python-rq.org/

* What language is RQ written in?

  Python (v2.7)

* How do I create a Docker container?

  ```
     docker build -t rq-worker .
     docker run -d --name redis redis
     docker run -d --link redis:redis --name rq_worker rq-worker
  ```

  rq_settings.py specifies the Redis host/port to use and which queues to
  listen on. Override the default rq_settings.py by mounting a volume:

  ```
    docker run -d --link redis:redis --name rq_worker
    -v <path>/rq_settings.py:/home/docker/rq/rq_settings.py rq-worker
  ```
