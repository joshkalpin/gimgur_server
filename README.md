gimgur_server
=============

A server, written in Ruby using Sinatra, for the [gimgur application](https://github.com/cdeange/gimgur).


#How Do?

Submit a POST to `http://aqueous-harbor-2434.herokuapp.com` with the following JSON:

```json   
{
  "imgs":["http://jasonlefkowitz.net/wp-content/uploads/2013/07/cats-16140154-1920-1080.jpg",
          "http://jasonlefkowitz.net/wp-content/uploads/2013/07/cats-16140154-1920-1080.jpg"],
  "title":"KITTENZ" //Optional 
}
```

You will receive a response in the following form:

```json 
{
  "id":"imgur_album_id_here"
}
```
