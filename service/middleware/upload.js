const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const config = require("config");

const Publication = require("../models/publications");
const generateRandomName = require("../scripts/generateRandomName");

router.post("/publication", async (req, res) => {
  const { token, image, description } = req.body;
  const verifyToken = jwt.verify(token, config.get("secret_key"));

  if (verifyToken) {
    const userId = verifyToken.userId;

    await new Publication({
      userId,
      data: image,
      desctiption: description || "",
      name: generateRandomName(50),
    }).save();

    res.status(201).send();
  } else {
    res.status(401).send({ message: "Вы не авторизованы" });
  }
});

router.post("/story", async (req, res) => {
  try {
    const { token, image, description } = req.body;
    const verifyToken = jwt.verify(token, config.get("secret_key"));

    if (verifyToken) {
      const userId = verifyToken.userId;

      await new Publication({
        userId,
        data: image,
        name: generateRandomName(50),
        type: "story",
      }).save();

      res.status(201).send();
    } else {
      res.status(401).send({ message: "Вы не авторизованы" });
    }

    res.status(201).send();
  } catch (e) {
    console.log(e);
    res.status(500).send();
  }
});

module.exports = router;
