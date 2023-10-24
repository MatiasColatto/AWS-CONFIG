const express = require('express');
const app = express();
const port = 3000; // Puerto en el que se ejecutará la aplicación

// Ruta para la página de inicio
app.get('/', (req, res) => {
  res.send('¡Bienvenido a mi aplicación web!');
});

// Iniciar el servidor
app.listen(port, () => {
  console.log(`La aplicación está escuchando en el puerto ${port}`);
});
