const mongoose = require("mongoose");
const config = require("config");

console.log(`Trying to connect ${config.get("db.url")}`);
mongoose
  .connect(
    config
      .get("db.url")
      .replace("<login>", config.get("db.login"))
      .replace("<password>", config.get("db.password"))
  )
  .then(async () => {
    console.log(`Connected to ${config.get("db.url")}`);
  })
  .catch(async () => {
    console.log(`Error in connect db ${config.get("db.url")}`);
  });
