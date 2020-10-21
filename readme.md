# DeepDetect Platform data container

This docker container retrieves data to run DeepDetect platform.

Data fetched:

* notebooks: DeepDetect Jupyter notebooks examples, and DeepDetect python client
* models: public and pretrained models

To run this docker container:

```
docker run -v /opt/platform:/platform/ jolibrain/platform_data
```

Here is an example to add it to your `docker-compose` configuration:

```
  platform_data:
    image: 'jolibrain/platform_data'
    volumes:
      - /opt/platform:/platform
```
