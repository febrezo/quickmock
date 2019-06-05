Configuration Files Format
==========================

Quickmock helps developers to quickly deploy mocked HTTP servers using simple configuration files.
The idea is to deploy a FLASK server which will deal with each and every reply send to it taking into account the information stored in these configuration files.
Although the simplest configuration files are pretty straightforward, the JSON format is pretty flexible.


Main Mock Features
------------------

The first level attributes are the following:

- `host`. A string with the preferred accepted hostname.
- `port`. An int with the preferred port.
- `responses`. A dictionary containing the possible responses. They are grouped by HTTP method (e. g., `GET`, `POST`, etc.). Responses are fully defined below, but they include a dictionary where the keys are the available paths (without the starting `/` and the values are list of possible responses which will be iterated in order in search of a scenario where the conditions are met.


Definition of a Response
------------------------

A sample response can be defined as follows:

```
{
  "checks": {…},
  "response": {
    "status": 200,
    "mimetype": "application/json",
    "return": {
      "user_id": "ai9565234",
      "address": {
        "locality": "Valladolid",
        "street_address": "Evergreen Terrace Street, N33, 2nd - B",
        "country": "Spain",
        "region": "Valladolid",
        "postal_code": "47022",
        "formatted": "Evergreen Terrace Street, N33, 2nd-B\r\n47022…"
      },
      "email_shipment": false,
      "postal_address_shipment": true,
      "email": "default_example@global-int.com",
      "identifiers": [
        "andres.iniesta@mailinator.com",
        "+882600000002",
        "+882700000001",
        "+882600000003"
      ]
    }
  }
}
```

We can identify here two different attributes:

- `checks`. This is an optional attribute which defines the checks that need to be met. For example, the response found in the `response` attribute would be returned if and only if any of the conditions found in `checks` are met. The checks implemented in this version are `data` and `headers` and they would be triggered if the `headers` and `data` of the request sent are exactly the ones found inside. If no checks are available, the response below is always triggered.
- `response`. The response object is formed by the response that would be returned in case of a positive match of the checks. It includes the HTTP Status Code to launch (`status`), the Mimetype (`mimetype`) and the response itself (`return`). This response will be serialized.


Resolution Process
------------------

The process to select a response is defined as follows:

1. The method of the HTTP request is obtained.
2. Taking the path of the request, an ordered list of possible responses is obtained. A generic 400 error will be launched if the path has not been foreseen.
3. The server wll iterate through each of them, checking if the conditions defined in `checks` are met. If so, the first response will be returned.
