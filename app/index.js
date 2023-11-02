const express = require('express');
const app = express();
const port = process.env.APP_PORT || 3000;

app.listen(port, () => {
  console.log(`La aplicación está escuchando en el puerto ${port}`);
});
