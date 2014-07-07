****************************************
HTTPie: a CLI, cURL-like tool for humans
****************************************


HTTPie (pronounced *aych-tee-tee-pie*) is a **command line HTTP client**.  Its
goal is to make CLI interaction with web services as **human-friendly** as
possible. It provides a simple ``http`` command that allows for sending
arbitrary HTTP requests using a simple and natural syntax, and displays
colorized responses. HTTPie can be used for **testing, debugging**, and
generally **interacting** with HTTP servers.



------------------------
Stable version |version|
------------------------

On **Mac OS X**, HTTPie can be installed via `Homebrew <http://brew.sh/>`_:

.. code-block:: bash

    $ brew install httpie


Most **Linux** distributions provide a package that can be installed via
system package manager, e.g. ``yum install httpie`` or ``apt-get install httpie``.
Note that the package might include a slightly older version of HTTPie.


A **universal installation method** (that works on **Windows**, Mac OS X, Linux, …,
and provides the latest version) is to use `pip`_:


.. code-block:: bash

    $ pip install --upgrade httpie


If the above fails, please use ``easy_install`` instead (``$ easy_install httpie``).




-------------------
Development version
-------------------

=============  =============
Mac/Linux      Windows
|unix|         |windows|
=============  =============


The **latest development version** can be installed directly from GitHub:

.. code-block:: bash

    # Mac OS X via Homebrew
    $ brew install httpie --HEAD

    # Universal
    $ pip install --upgrade https://github.com/jakubroztocil/httpie/tarball/master



=====
Usage
=====


Hello World:


.. code-block:: bash

    $ http httpie.org


Synopsis:

.. code-block:: bash

    $ http [flags] [METHOD] URL [ITEM [ITEM]]


See also ``http --help``.


--------
Examples
--------

Custom `HTTP method`_, `HTTP headers`_ and `JSON`_ data:

.. code-block:: bash

    $ http PUT example.org X-API-Token:123 name=John


Submitting `forms`_:

.. code-block:: bash

    $ http -f POST example.org hello=World


See the request that is being sent using one of the `output options`_:

.. code-block:: bash

    $ http -v example.org


Use `Github API`_ to post a comment on an
`issue <https://github.com/jakubroztocil/httpie/issues/83>`_
with `authentication`_:

.. code-block:: bash

    $ http -a USERNAME POST https://api.github.com/repos/jakubroztocil/httpie/issues/83/comments body='HTTPie is awesome!'


Upload a file using `redirected input`_:

.. code-block:: bash

    $ http example.org < file.json


Download a file and save it via `redirected output`_:

.. code-block:: bash

    $ http example.org/file > file


Download a file ``wget`` style:

.. code-block:: bash

    $ http --download example.org/file

Use named `sessions`_ to make certain aspects or the communication persistent
between requests to the same host:

.. code-block:: bash

    $ http --session=logged-in -a username:password httpbin.org/get API-Key:123

    $ http --session=logged-in httpbin.org/headers


Set a custom ``Host`` header to work around missing DNS records:

.. code-block:: bash

    $ http localhost:8000 Host:example.com

..

--------

*What follows is a detailed documentation. It covers the command syntax,
advanced usage, and also features additional examples.*


===========
HTTP Method
===========

The name of the HTTP method comes right before the URL argument:

.. code-block:: bash

    $ http DELETE example.org/todos/7


Which looks similar to the actual ``Request-Line`` that is sent:

.. code-block:: http

    DELETE /todos/7 HTTP/1.1


When the ``METHOD`` argument is **omitted** from the command, HTTPie defaults to
either ``GET`` (with no request data) or ``POST`` (with request data).


===========
Request URL
===========

The only information HTTPie needs to perform a request is a URL.
The default scheme is, somewhat unsurprisingly, ``http://``,
and can be omitted from the argument – ``http example.org`` works just fine.

Additionally, curl-like shorthand for localhost is supported.
This means that, for example ``:3000`` would expand to ``http://localhost:3000``
If the port is omitted, then port 80 is assumed.

.. code-block:: bash

    $ http :/foo


.. code-block:: http

    GET /foo HTTP/1.1
    Host: localhost


.. code-block:: bash

    $ http :3000/bar


.. code-block:: http

    GET /bar HTTP/1.1
    Host: localhost:3000


.. code-block:: bash

    $ http :


.. code-block:: http

    GET / HTTP/1.1
    Host: localhost

If find yourself manually constructing URLs with **querystring parameters**
on the terminal, you may appreciate the ``param==value`` syntax for appending
URL parameters so that you don't have to worry about escaping the ``&``
separators. To search for ``HTTPie`` on Google Images you could use this
command:

.. code-block:: bash

    $ http GET www.google.com search==HTTPie tbm==isch


.. code-block:: http

    GET /?search=HTTPie&tbm=isch HTTP/1.1


=============
Request Items
=============

There are a few different *request item* types that provide a
convenient mechanism for specifying HTTP headers, simple JSON and
form data, files, and URL parameters.

They are key/value pairs specified after the URL. All have in
common that they become part of the actual request that is sent and that
their type is distinguished only by the separator used:
``:``, ``=``, ``:=``, ``==``, ``@``, ``=@``, and ``:=@``. The ones with an
``@`` expect a file path as value.

+-----------------------+-----------------------------------------------------+
| Item Type             | Description                                         |
+=======================+=====================================================+
| HTTP Headers          | Arbitrary HTTP header, e.g. ``X-API-Token:123``.    |
| ``Name:Value``        |                                                     |
+-----------------------+-----------------------------------------------------+
| URL parameters        | Appends the given name/value pair as a query        |
| ``name==value``       | string parameter to the URL.                        |
|                       | The ``==`` separator is used                        |
+-----------------------+-----------------------------------------------------+
| Data Fields           | Request data fields to be serialized as a JSON      |
| ``field=value``,      | object (default), or to be form-encoded             |
| ``field=@file.txt``   | (``--form, -f``).                                   |
+-----------------------+-----------------------------------------------------+
| Raw JSON fields       | Useful when sending JSON and one or                 |
| ``field:=json``,      | more fields need to be a ``Boolean``, ``Number``,   |
| ``field:=@file.json`` | nested ``Object``, or an ``Array``,  e.g.,          |
|                       | ``meals:='["ham","spam"]'`` or ``pies:=[1,2,3]``    |
|                       | (note the quotes).                                  |
+-----------------------+-----------------------------------------------------+
| Form File Fields      | Only available with ``--form, -f``.                 |
| ``field@/dir/file``   | For example ``screenshot@~/Pictures/img.png``.      |
|                       | The presence of a file field results                |
|                       | in a ``multipart/form-data`` request.               |
+-----------------------+-----------------------------------------------------+

You can use ``\`` to escape characters that shouldn't be used as separators
(or parts thereof). For instance, ``foo\==bar`` will become a data key/value
pair (``foo=`` and ``bar``) instead of a URL parameter.

You can also quote values, e.g. ``foo="bar baz"``.

Note that data fields aren't the only way to specify request data:
`Redirected input`_ allows for passing arbitrary data to be sent with the
request.


====
JSON
====

JSON is the *lingua franca* of modern web services and it is also the
**implicit content type** HTTPie by default uses:

If your command includes some data items, they are serialized as a JSON
object by default. HTTPie also automatically sets the following headers,
both of which can be overwritten:

================    =======================================
``Content-Type``    ``application/json; charset=utf-8``
``Accept``          ``application/json``
================    =======================================

You can use ``--json, -j`` to explicitly set ``Accept``
to ``application/json`` regardless of whether you are sending data
(it's a shortcut for setting the header via the usual header notation –
``http url Accept:application/json``).

Simple example:

.. code-block:: bash

    $ http PUT example.org name=John email=john@example.org

.. code-block:: http

    PUT / HTTP/1.1
    Accept: application/json
    Accept-Encoding: identity, deflate, compress, gzip
    Content-Type: application/json; charset=utf-8
    Host: example.org

    {
        "name": "John",
        "email": "john@example.org"
    }


Non-string fields use the ``:=`` separator, which allows you to embed raw JSON
into the resulting object. Text and raw JSON files can also be embedded into
fields using ``=@`` and ``:=@``:

.. code-block:: bash

    $ http PUT api.example.com/person/1 \
        name=John \
        age:=29 married:=false hobbies:='["http", "pies"]' \  # Raw JSON
        description=@about-john.txt \   # Embed text file
        bookmarks:=@bookmarks.json      # Embed JSON file


.. code-block:: http

    PUT /person/1 HTTP/1.1
    Accept: application/json
    Content-Type: application/json; charset=utf-8
    Host: api.example.com

    {
        "age": 29,
        "hobbies": [
            "http",
            "pies"
        ],
        "description": "John is a nice guy who likes pies.",
        "married": false,
        "name": "John",
        "bookmarks": {
            "HTTPie": "http://httpie.org",
        }
    }


Send JSON data stored in a file (see `redirected input`_ for more examples):

.. code-block:: bash

    $ http POST api.example.com/person/1 < person.json
