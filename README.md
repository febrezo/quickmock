Sample Mocked Services
======================

A simple service mocking utility.
Services can be mocked using `.json` files where the paths and the responses can be defined.


Installation
------------

To install the quickmock, just clone the repository and `cd` into it to install it with `pip`.

```
$ git clone http://github.com/febrezo/quickmock
$ cd quickmock
$ pip3 install -e . --user
```

Afterwards, you will be able to use it the tool using the new entry point in your system:

```
$ quickmock --help
```

Simple Service
--------------

A typical `.json` file contains three keywords:

- `host`. The host. Typically, 0.0.0.0 to permit requests from any machine.
- `port`. An integer defining the local port in the Docker container.
- `responses`. This dictionary contains several subdictionaries order by methods and URL.

```
{
    "host": "0.0.0.0",
    "port": 6000,
    "responses": {
        "GET": {
            "simple/1": [
                  {
                    "response": {
                        "status": 200,
                        "return": {
                            "name": "James Bond"
                        },
                        "mimetype": "application/json"
                    }
                }
            ],
            "simple/1001": [
                {
                    "response": {
                        "status": 404,
                        "return": {
                            "code": 404,
                            "message": "User not found"
                        },
                        "mimetype": "application/json"
                    }
                }
            ]
        }
    }
}
```

More complex examples can be found in the [`./doc/examples`](./doc/examples) folder to define conditional behaviour depending on the headers or data provided together with the request.
However, there is also a creator assistant that guides the user through the creation of a new template:

```
$ quickmock template
```

The output file can be set using `-t`:

```
$ quickmock template -t my_conf.json
```

Deployment
----------

To run the newly created web server, use `quickmock run`:

```
$ quickmock run -c ./my_conf.json
```

For further assistance, use `--help`.
