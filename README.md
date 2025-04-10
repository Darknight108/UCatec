
# 📘 Manual: Crear un Entorno con PostgreSQL, MongoDB y Nginx usando Docker Compose

## ✅ Requisitos Previos

Antes de comenzar, asegúrate de tener lo siguiente instalado:

- 🐳 **Docker Desktop**: [Descargar Docker](https://www.docker.com/products/docker-desktop)
- ✍️ **Editor de Código** (recomendado: VSCode): [Descargar VSCode](https://code.visualstudio.com/)


---

## 🧩 Paso 1: Crear archivo `docker-compose.yml`

Este archivo define los servicios de PostgreSQL, MongoDB y Nginx.

```yaml
version: '3.9'

services:
  postgres:
    image: postgres:15
    container_name: postgres-local
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin123
      POSTGRES_DB: demo_db
    ports:
      - "5432:5432"
    volumes:
      - ./init-postgres.sql:/docker-entrypoint-initdb.d/init.sql
    restart: always

  mongo:
    image: mongo:6
    container_name: mongo-local
    ports:
      - "27017:27017"
    volumes:
      - ./init-mongo.js:/docker-entrypoint-initdb.d/init-mongo.js
    restart: always

  nginx:
    image: nginx:latest
    container_name: nginx-local
    ports:
      - "8080:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf:ro
    restart: always
```

---

## ⚙️ Paso 2: Crear archivos de inicialización

### `init-postgres.sql` – Inicializa una tabla en PostgreSQL

```sql
CREATE TABLE personas (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  edad INTEGER
);

INSERT INTO personas (nombre, edad) VALUES ('Ana Lopez', 28);
```

### `init-mongo.js` – Inicializa una colección en MongoDB

```javascript
db = db.getSiblingDB('demo_db');

db.usuarios.insertOne({
  nombre: "Carlos García",
  edad: 32
});
```

### `nginx/default.conf` – Configuración básica para Nginx

```nginx
server {
    listen 80;

    location / {
        return 200 'Servidor NGINX funcionando 🚀\n';
        add_header Content-Type text/plain;
    }
}
```

---

## 🚀 Paso 3: Levantar los servicios

Abre la terminal en la carpeta del proyecto y ejecuta:

```bash
docker-compose up -d
```

📸 ![Levantando servicios](img1.png)

---

## 🧪 Paso 4: Verificar los servicios

### PostgreSQL

Conéctate con un cliente como DBeaver o TablePlus:

| Campo         | Valor        |
|---------------|--------------|
| Host          | localhost    |
| Puerto        | 5432         |
| Usuario       | admin        |
| Contraseña    | admin123     |
| Base de Datos | demo_db      |

Consulta la tabla:

```sql
SELECT * FROM personas;
```

📸 ![Consulta PostgreSQL](imagenes/postgres-tabla.png)

---

### MongoDB

Conéctate con MongoDB Compass o en terminal:

```bash
docker exec -it mongo-local mongosh
```

Y consulta la colección:

```javascript
use demo_db;
db.usuarios.find();
```

📸 ![Consulta MongoDB](imagenes/mongo-coleccion.png)

---

### Nginx

Visita en tu navegador:

```
http://localhost:8080
```

Deberías ver:

```
Servidor NGINX funcionando 🚀
```

📸 ![Nginx funcionando](imagenes/nginx.png)

---

## 🧼 Comandos útiles

- Levantar servicios:

  ```bash
  docker-compose up -d
  ```

- Ver estado:

  ```bash
  docker-compose ps
  ```

- Ver logs:

  ```bash
  docker-compose logs -f
  ```

- Detener y eliminar servicios:

  ```bash
  docker-compose down
  ```

---

## 🧠 Recomendaciones

- Usa volúmenes para persistencia si es un entorno de desarrollo más largo.
- Personaliza las configuraciones según tu proyecto (variables, puertos, etc).
- Puedes agregar otros servicios (Redis, Adminer, etc.) fácilmente al mismo `docker-compose.yml`.

---
