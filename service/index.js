const express = require("express");
const config = require("config");
const cors = require("cors");

require("./db");

const app = express();

const PORT = config.get("PORT") || 5000;

app.use(cors());

app.use(express.json({ limit: "100mb" }));
app.use(require("./routes/routes"));

app.listen(PORT, async () => {
  console.log(`Server started at port ${PORT}...`);
});
