db = db.getSiblingDB('demo_db');

db.usuarios.insertOne({
  nombre: "Carlos García",
  edad: 32
});