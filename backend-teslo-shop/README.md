# Nest - TesloShop Backend

Temas puntuales de la sección
Esta sección tiene por objetivo principal montar un backend real para realizar nuestro trabajo lo más parecido a la realidad posible.

Puntualmente veremos:

- Docker
- Docker compose
- Imágenes de docker
- Conectarse a postgres usando TablePlus
- Probar el backend configurado
- Llenar la base de datos
- Leer la documentación del backend
- Generar JWTs y probarlos
- Uso de bearer tokens en los headers de autenticación
- Trabajar las pruebas con Postman

De nuevo, el objetivo es trabajar lo más apegado a la realidad posible, como si ustedes y yo trabajáramos en la misma empresa y se les pide que hagan la aplicación móvil, conectándose a ese backend, que es literal el backend usando en producción, pero con una base de datos y variables de entorno diferentes.

## Development

1. Tener corriendo el servicio de Docker (Docker Desktop o Docker Daemon)
2. Clonar el archivo **.env.template** y renombrar la copia a **.env**
3. Levantar los servicios con el comando

```
docker compose up -d
```

4. Llenar la base de datos con data temporal:

   http://localhost:3001/api/seed

5. Documentación de los endpoints disponibles:

   http://localhost:3001/api

   También están disponibles los scripts de Postman.

# Extra

Si desean saber más sobre docker y cómo se construyó esta imagen, esto es parte de mi curso de Nest y Docker:

[Cursos sobre Docker](https://fernando-herrera.com/#/search/docker)

[Imagen en DockerHub](https://hub.docker.com/repository/docker/klerith/flutter-backend-teslo-shop/general)
