The RSS reader sees same-origin restrictions as `NetworkError` from `Http.getString`. It needs a proxy to do those requests for it. Possiblilities:

https://github.com/Rob--W/cors-anywhere/
https://blog.javascripting.com/2015/01/17/dont-hassle-with-cors/

Or just configure Apache or Nginx as a proxy. 

This may run into bandwidth costs on your server.
